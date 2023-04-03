LIBRARY ieee; 
USE ieee.std_logic_1164.all; 
USE ieee.numeric_std.all;

ENTITY comparator Is
GENERIC(N: integer := 4);
PORT(input, threshold: IN std_logic_vector(N-1 downto 0); is_equal: OUT std_logic);
END comparator;

ARCHITECTURE behavioral OF comparator IS
BEGIN

PROCESS(input, threshold)
BEGIN
if(input = threshold) then
	is_equal <= '1';
else
	is_equal <= '0';
end if;
END PROCESS;
END behavioral;
