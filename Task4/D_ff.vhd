library IEEE;
use IEEE.std_logic_1164.all;

entity D_ff is
port (D,EN,RST,CLK: in std_logic;
Q: out std_logic);
end D_ff ;
architecture my_d_ff of D_ff is
SIGNAL tmp: std_logic := '1';
begin
dff: process(CLK,RST,EN)
Begin
if (CLK'EVENT and CLK = '1' and RST= '0') then
	tmp <= '1'; -- when reset everything is set to 1 so that all segments are off
elsif (rising_edge(CLK) and EN = '1') then
	tmp <= D;
end if;
end process dff;
Q <= tmp;
end my_d_ff;