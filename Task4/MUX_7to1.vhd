library IEEE;
use IEEE.std_logic_1164.all;

ENTITY MUX_7to1 IS
GENERIC(n_in: integer := 7);  
PORT(in6, in7: IN std_logic_vector(n_in -1 downto 0); -- the inputs are the 4 letterls, the blank state and other two inputs
     sel: IN std_logic_vector(3-1 downto 0);
	  output: OUT std_logic_vector(n_in -1 downto 0));
END MUX_7to1;

ARCHITECTURE behavioral OF MUX_7to1 IS
SIGNAL H,E,L,O,BLANK: std_logic_vector(n_in -1 downto 0);
BEGIN
H <= "0001001"; -- 0 to 6 for all the letters 
E <= "0000110";  
L <= "1000111"; 
O <= "1000000"; 
BLANK <= "1111111";
PROCESS(sel, H,E,L,O,BLANK, in6, in7)
BEGIN
CASE sel IS
	when "000" => output <= H;
	when "001" => output <= E;
	when "010" => output <= L;
	when "011" => output <= O;
	when "100" => output <= BLANK;
	when "101" => output <= in6;
	when "110" => output <= in7;
	when others => output <= BLANK;
END CASE;
END PROCESS;
END behavioral;