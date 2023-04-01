LIBRARY IEEE;
use IEEE.std_logic_1164.all;

ENTITY OH_FSM IS
PORT(
    SW, KEY: IN STD_LOGIC_VECTOR(1 DOWNTO 0);
    LEDR: OUT STD_LOGIC_VECTOR(9 DOWNTO 0)
);
END OH_FSM;
-- SW1: w input --SW0: active low synch reset --KEY1: unused --KEY0: manual clock input
-- LEDR(8 DOWNTO 1): unused (turn them off)

ARCHITECTURE structure OF OH_FSM IS

SIGNAL curr_state, next_state: STD_LOGIC_VECTOR(8 DOWNTO 0);

COMPONENT flipflop IS
PORT (D, Clock, Resetn : IN STD_LOGIC;
Q : OUT STD_LOGIC);
END COMPONENT;

COMPONENT cc1_ohs IS 
PORT (
    w, resetn: IN STD_LOGIC;
    y: IN STD_LOGIC_VECTOR(8 DOWNTO 0);
    x: OUT STD_LOGIC_VECTOR(8 DOWNTO 0)
);
END COMPONENT;

COMPONENT cc2_ohs IS 
PORT (
    y: IN STD_LOGIC_VECTOR(8 DOWNTO 0);
    z: OUT STD_LOGIC
);
END COMPONENT;

BEGIN
cc1: cc1_ohs PORT MAP (w=>SW(1), resetn=>SW(0), y=>curr_state, x=>next_state);
cc2: cc2_ohs PORT MAP (y=>curr_state, z=>LEDR(0));
q1: FOR i IN 0 to 8 GENERATE
    ffx: flipflop PORT MAP(D=>next_state(i), Clock=>KEY(0), Resetn=>SW(0), Q=>curr_state(i));
END GENERATE;
LEDR(9 DOWNTO 1)<=(others=>'0');
END structure;