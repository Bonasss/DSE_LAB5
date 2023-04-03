library IEEE;
use IEEE.std_logic_1164.all;

ENTITY my_fsm_hello IS
PORT(w: IN std_logic_vector(2 downto 0); 
	  CLK,RESET: IN std_logic;
	  Z: OUT std_logic_vector(2 downto 0));
END my_fsm_hello;

ARCHITECTURE beh OF my_fsm_hello IS

TYPE state_type IS (H,E,L,O,BLANK,GO_ON_L, GO_ON_R);
SIGNAL ps, fs: state_type; -- ps: present state; fs: future state;

BEGIN
memory: PROCESS(CLK, fs, RESET) IS
BEGIN
if(CLK'EVENT and CLK = '1' and RESET = '0') then
	ps <= H;
elsif(CLK'EVENT and CLK = '1') then
	ps <= fs;
end if;
END PROCESS memory;

comb_c1: PROCESS(ps, w) IS
BEGIN
case ps is
	when H => 
	if (w = "000") then
		fs <= H;
	elsif(w = "001" ) then
		fs <= E;
	else
		fs <= H;
	end if;
	
	when E =>
	if (w = "001") then
		fs <= E;
	elsif(w = "010" ) then
		fs <= L;
	else
		fs <= H;
	end if;
	
	when L =>
	if (w = "010" or w="011") then
		fs <= L;
	elsif(w = "100" ) then
		fs <= O;
	else
		fs <= H;
	end if;
	
	when O =>
	if (w = "100") then
		fs <= O;
	elsif (w = "101") then
		fs <= BLANK;
	else
		fs <= H;
	end if;
	
	when BLANK =>
		if(w = "101") then
			fs <= BLANK;
		elsif (w = "110") then
			fs <= GO_ON_L;
		else
			fs <= H;
		end if;
		
	when GO_ON_L =>
		if (w = "110") then
			fs <= GO_ON_R;
		else
			fs <= GO_ON_L;
		end if;
	
	when GO_ON_R =>
		if(w = "110") then
			fs <= GO_ON_L;
		else
			fs <= GO_ON_r;
		end if;
		
	when others => fs <= H;
end case;
END PROCESS comb_c1;

comb_c2: PROCESS(ps)
BEGIN

case ps is
	when H => Z <= "000";
	when E => Z <= "001";
	when L => Z <= "010";
	when O => Z <= "011";
	when BLANK => Z <= "100";
	when GO_ON_L => Z <= "101";
	when GO_ON_R => Z <= "110";
	when others => z <= "000";
end case;
END PROCESS comb_c2;
END beh;
