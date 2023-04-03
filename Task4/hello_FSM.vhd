LIBRARY ieee; 
USE ieee.std_logic_1164.all; 
USE ieee.numeric_std.all;

ENTITY hello_FSM IS 
PORT(CLOCK_50: IN std_logic;
     KEY: IN std_logic_vector(1 downto 0);
     HEX0, HEX1, HEX2, HEX3, HEX4, HEX5: OUT std_logic_vector(6 downto 0));
END hello_FSM;

ARCHITECTURE structural OF hello_FSM IS

COMPONENT synchronous_counter IS
GENERIC(N: INTEGER:= 16);
PORT (enable, clock, clear: IN STD_LOGIC;
Q: OUT UNSIGNED(N-1 DOWNTO 0));
END component;

COMPONENT my_register IS
GENERIC(N: integer := 7);
PORT(input_s: IN std_logic_vector(N-1 downto 0); 
	clock, reset,enable: IN std_logic; 
	output_s: OUT std_logic_vector(N-1 downto 0));
END component;

COMPONENT MUX_7to1 IS
GENERIC(n_in: integer := 7);  
PORT(in6, in7: IN std_logic_vector(n_in -1 downto 0);
     sel: IN std_logic_vector(2 downto 0);
	  output: OUT std_logic_vector(n_in -1 downto 0));
END component;

COMPONENT comparator IS
GENERIC(N: integer := 4);
PORT(input, threshold: IN std_logic_vector(N-1 downto 0); is_equal: OUT std_logic);
END component;

COMPONENT my_fsm_hello IS
PORT(w: IN std_logic_vector(2 downto 0); 
	  CLK,RESET: IN std_logic;
	  Z: OUT std_logic_vector(2 downto 0));
END component;

COMPONENT MUX_2to1 IS
PORT(in1, in2: IN std_logic_vector(6 downto 0);
     seln: IN std_logic_vector(2 downto 0); 
     output: OUT std_logic_vector(6 downto 0));
END component;

SIGNAL en1,rst1,rst2: std_logic; --enable of the seconds counter, reset seconds counter, resets up counter
SIGNAL out1: std_logic_vector(25 downto 0); -- output of the seconds counter
SIGNAL out2: std_logic_vector(2 downto 0); -- output of the 3 bit up counter
SIGNAL is_equal1, is_equal2: std_logic; -- output of the comparator 1, output of comparator 2
SIGNAL thresh1: std_logic_vector(25 downto 0); -- threshold od the first comparator
SIGNAL thresh2: std_logic_vector(2 downto 0); -- threshold of the second comparator
SIGNAL in_comp: std_logic_vector(2 downto 0); -- input of the second comparator
SIGNAL out_fsm: std_logic_vector(2 downto 0); -- output of the FSM
SIGNAL reg_out0, reg_out1, reg_out2, reg_out3, reg_out4, reg_out5: std_logic_vector(6 downto 0); -- output of registers
SIGNAL reg_in0, reg_in1, reg_in2, reg_in3, reg_in4, reg_in5: std_logic_vector(6 downto 0); -- input register
SIGNAL out1u: unsigned(25 downto 0);
SIGNAL out2u: unsigned(2 downto 0);
BEGIN
thresh1 <= "10111110101111000010000000";
thresh2 <= "110";
en1 <= '1';
rst1 <= NOT(is_equal1) AND KEY(0);
rst2 <= NOT(is_equal2) AND KEY(0); 
out1 <= std_logic_vector(out1u);
out2 <= std_logic_vector(out2u);
s_counter: synchronous_counter GENERIC MAP(N => 26)
                               PORT MAP(enable => '1', clock => CLOCK_50, clear => rst1, Q => out1u);
comp1: comparator GENERIC MAP(N => 26)
                  PORT MAP(input => out1, threshold => thresh1, is_equal => is_equal1);
--reg_comp: my_register GENERIC MAP(N => 3)
--                      PORT MAP(input_s => out2, clock => CLOCK_50, reset => KEY(0), enable => is_equal1, output_s => in_comp);
comp2: comparator GENERIC MAP(N => 3)
                  PORT MAP(input => out2, threshold => thresh2, is_equal => is_equal2);
up_counter: synchronous_counter GENERIC MAP(N => 3)
                                PORT MAP(enable => is_equal1, clock => CLOCK_50, clear => rst2, Q => out2u);
fsm: my_fsm_hello PORT MAP(w => out2, CLK => CLOCK_50, RESET => KEY(0), Z => out_fsm);

mux0: MUX_7to1 GENERIC MAP(n_in => 7)
               PORT MAP(in6 => reg_out5, in7 => reg_out1, sel => out_fsm, output => reg_in0);
mux5: MUX_2to1 PORT MAP(in1 => reg_out4, in2 => reg_out0, seln => out_fsm, output => reg_in5);
mux1: MUX_2to1 PORT MAP(in1 => reg_out0, in2 => reg_out2, seln => out_fsm, output => reg_in1);
mux2: MUX_2to1 PORT MAP(in1 => reg_out1, in2 => reg_out3, seln => out_fsm, output => reg_in2);
mux3: MUX_2to1 PORT MAP(in1 => reg_out2, in2 => reg_out4, seln => out_fsm, output => reg_in3);
mux4: MUX_2to1 PORT MAP(in1 => reg_out3, in2 => reg_out5, seln => out_fsm, output => reg_in4);
reg0: my_register GENERIC MAP(N => 7)
                   PORT MAP(input_s => reg_in0, clock => CLOCK_50, enable => is_equal1, reset => KEY(0), output_s => reg_out0);
reg1: my_register GENERIC MAP(N => 7)
                   PORT MAP(input_s => reg_in1, clock => CLOCK_50, enable => is_equal1, reset => KEY(0), output_s => reg_out1);
reg2: my_register GENERIC MAP(N => 7)
                   PORT MAP(input_s => reg_in2, clock => CLOCK_50, enable => is_equal1, reset => KEY(0), output_s => reg_out2);
reg3: my_register GENERIC MAP(N => 7)
                   PORT MAP(input_s => reg_in3, clock => CLOCK_50, enable => is_equal1, reset => KEY(0), output_s => reg_out3);
reg4: my_register GENERIC MAP(N => 7)
                   PORT MAP(input_s => reg_in4, clock => CLOCK_50, enable => is_equal1, reset => KEY(0), output_s => reg_out4);
reg5: my_register GENERIC MAP(N => 7)
                   PORT MAP(input_s => reg_in5, clock => CLOCK_50, enable => is_equal1, reset => KEY(0), output_s => reg_out5);

HEX0 <= reg_out0;
HEX1 <= reg_out1;
HEX2 <= reg_out2;
HEX3 <= reg_out3;
HEX4 <= reg_out4;
HEX5 <= reg_out5;
END structural;


