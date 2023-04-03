LIBRARY IEEE;
use IEEE.std_logic_1164.all;

ENTITY OH_FSM IS
PORT(
    SW, KEY: IN STD_LOGIC_VECTOR(1 DOWNTO 0);
    LEDR: OUT STD_LOGIC_VECTOR(9 DOWNTO 0)
);
END OH_FSM;
-- SW1: w input --SW0: active low synch reset --KEY1: unused --KEY0: manual clock input
-- LEDR(8 DOWNTO 1): unused (turn them off)
ARCHITECTURE behaviour OF OH_FSM IS

TYPE seq_state IS (A, B, C, D, E, F, G, H, I);
SIGNAL curr_state, next_state: seq_state;

BEGIN 

PROCESS (SW, curr_state) -- state table 
BEGIN 
CASE curr_state IS 
    WHEN A => IF (SW(1) = '0') THEN next_state <= B; 
        ELSE next_state <= F; 
        END IF; 
    WHEN B => IF (SW(1) = '0') THEN next_state <= C; 
        ELSE next_state <= F; 
        END IF;
    WHEN C => IF (SW(1) = '0') THEN next_state <= D; 
        ELSE next_state <= F; 
        END IF;
    WHEN D => IF (SW(1) = '0') THEN next_state <= E; 
        ELSE next_state <= F; 
        END IF;
    WHEN E => IF (SW(1) = '0') THEN next_state <= E; 
        ELSE next_state <= F; 
        END IF;
    WHEN F => IF (SW(1) = '0') THEN next_state <= B; 
        ELSE next_state <= G; 
        END IF;
    WHEN G => IF (SW(1) = '0') THEN next_state <= B; 
        ELSE next_state <= H; 
        END IF;  
    WHEN H => IF (SW(1) = '0') THEN next_state <= B; 
        ELSE next_state <= I; 
        END IF;
    WHEN I => IF (SW(1) = '0') THEN next_state <= B; 
        ELSE next_state <= I; 
        END IF;
    WHEN others=> next_state <= A;           
END CASE; 
END PROCESS; -- state table 
 
PROCESS (KEY, SW) -- state flip-flops 
BEGIN
    IF (SW(0) = '0') THEN -- asynchronous reset
        curr_state <= A;
    ELSIF (KEY(0)'event AND KEY(0) ='1') THEN -- flipflop
        curr_state <= next_state;
    ELSE curr_state <= curr_state;
    END IF;
END PROCESS;

LEDR(9 DOWNTO 1)<=(OTHERS=>'0');

PROCESS(curr_state) -- PROCESS TO ASSIGN THE OUTPUT
BEGIN
    IF (curr_state = E) THEN LEDR(0) <= '1';
    ELSIF (curr_state = I) THEN LEDR(0) <= '1';
    ELSE LEDR(0) <= '0';
    END IF;
END PROCESS;

END behaviour;