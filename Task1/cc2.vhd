LIBRARY IEEE;
use IEEE.std_logic_1164.all;

ENTITY cc2_ohs IS 
PORT (
    y: IN STD_LOGIC_VECTOR(8 DOWNTO 0);
    z: OUT STD_LOGIC
);
END cc2_ohs;

ARCHITECTURE behavior OF cc2_ohs IS
BEGIN
    z <= (y(4) XOR y(8)) AND NOT (y(0) OR y(1) OR y(2) OR y(3) OR y(5) OR y(6) OR y(7));
END behavior;