LIBRARY ieee; 
USE ieee.std_logic_1164.all; 

ENTITY MUX_2to1 IS
PORT(in1, in2: IN std_logic_vector(6 downto 0);
     seln: IN std_logic_vector(2 downto 0); 
     output: OUT std_logic_vector(6 downto 0));
END MUX_2to1;

ARCHITECTURE beh OF MUX_2to1 IS
BEGIN
PROCESS(seln, in1, in2) IS
BEGIN
if (seln = "110") then
	output <= in2;
else
	output <= in1;
end if;
END PROCESS;
END beh;
