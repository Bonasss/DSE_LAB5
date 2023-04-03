library IEEE;
use IEEE.std_logic_1164.all;

ENTITY my_register IS
GENERIC(N: integer := 7);
PORT(input_s: IN std_logic_vector(N-1 downto 0); 
	clock, reset,enable: IN std_logic; 
	output_s: OUT std_logic_vector(N-1 downto 0));
END my_register;

ARCHITECTURE structural OF my_register IS

COMPONENT D_ff IS
PORT (D,EN,RST,CLK: in std_logic;
Q: out std_logic);
END component;

BEGIN

mygen: for i in 0 to N-1 generate
DFFx: D_ff PORT MAP(D => input_s(i), CLK => clock, RST => reset, EN => enable, Q => output_s(i));
end generate;

END structural;
 