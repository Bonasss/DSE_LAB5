LIBRARY IEEE;
use IEEE.std_logic_1164.all;

ENTITY cc1_ohs IS 
PORT (
    w, resetn: IN STD_LOGIC;
    y: IN STD_LOGIC_VECTOR(8 DOWNTO 0);
    x: OUT STD_LOGIC_VECTOR(8 DOWNTO 0)
);
END cc1_ohs;

ARCHITECTURE dataflow OF cc1_ohs IS
BEGIN
x(0) <= NOT resetn;
x(1) <= (NOT w) AND (y(0) OR y(5) OR y(6) OR y(7) OR y(8)) AND resetn;
x(2) <= (NOT w) AND y(1) AND resetn;
x(3) <= (NOT w) AND y(2) AND resetn;
x(4) <= (NOT w) AND (y(3) OR y(4)) AND resetn;
x(5) <= w AND (y(0) OR y(1) OR y(2) OR y(3) OR y(4)) AND resetn;
x(6) <= w AND y(5) AND resetn;
x(7) <= w AND y(6) AND resetn;
x(8) <= w AND (y(7) OR y(8)) AND resetn;
END dataflow;
