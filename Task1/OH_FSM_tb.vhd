LIBRARY IEEE;
use IEEE.std_logic_1164.all;
USE IEEE.numeric_std.all;

ENTITY OH_FSM_tb IS
END OH_FSM_tb;

ARCHITECTURE test OF OH_FSM_tb IS

SIGNAL clk, w, z, resetn: STD_LOGIC:='1';
SIGNAL KEY_tb, SW_tb: STD_LOGIC_VECTOR(1 DOWNTO 0);
SIGNAL LED_tb: STD_LOGIC_VECTOR(9 DOWNTO 0):= (others=>'0');
CONSTANT clock_cycles: INTEGER:=60;

COMPONENT OH_FSM IS
PORT(
    SW, KEY: IN STD_LOGIC_VECTOR(1 DOWNTO 0);
    LEDR: OUT STD_LOGIC_VECTOR(9 DOWNTO 0)
);
END COMPONENT;

BEGIN

KEY_tb <= '0' & clk;
SW_tb <= w & resetn;
z <= LED_tb(0);
uut: OH_FSM PORT MAP(SW=>SW_tb, KEY=>key_tb, LEDR=>LED_tb);

PROCESS
    BEGIN
    WAIT FOR 2 ns;
    FOR i in 0 to clock_cycles loop
        clk <= not clk;
        WAIT FOR 25 ns;
    END loop;
    WAIT;
END PROCESS;

PROCESS
BEGIN 
    resetn <= '0';
    WAIT FOR 55 ns; -- reset plus enough time for the clock to catch up, state A
    resetn <= '1';
    for i in 0 to 8 loop -- loop w s.t. z doesn't turn on
        w <= not w;
        WAIT FOR 48 ns;
    END loop;
    WAIT FOR 400 ns; -- tests for one value of w, z should turn to '1' after 4 clock and stay
    resetn <= '0';
    WAIT FOR 55 ns; -- reset plus enough time for the clock to catch up, state A
    resetn <= '1';      -- start counting the sequence
    WAIT FOR 10 ns;
    w <= not w;
    WAIT FOR 400 ns; -- tests for the other value of w
    w <= not w;
    WAIT FOR 150 ns; -- tests what happens if w stays the same for 3 clock cycles
    W <= not w;
    WAIT;
END PROCESS;
END test;