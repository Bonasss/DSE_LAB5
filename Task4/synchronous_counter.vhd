LIBRARY ieee; 
USE ieee.std_logic_1164.all; 
USE ieee.numeric_std.all;

ENTITY synchronous_counter IS 
GENERIC(N: INTEGER:= 16);
PORT (enable, clock, clear: IN STD_LOGIC;
Q: OUT UNSIGNED(N-1 DOWNTO 0));
END synchronous_counter;

ARCHITECTURE behaviour OF synchronous_counter IS

SIGNAL q_out: UNSIGNED (N-1 DOWNTO 0):=(OTHERS => '0');

BEGIN
Q <= q_out;
PROCESS(enable, clock, clear)
BEGIN
    IF(clock'event AND clock ='1' AND clear = '0') THEN q_out <= (OTHERS=>'0');
    ELSIF (clock'event AND clock ='1' AND enable ='1') THEN q_out <= q_out +1;
    END IF;
END PROCESS;

END behaviour;