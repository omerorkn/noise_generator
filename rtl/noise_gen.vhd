---------------------------------------------------------------------------------------------------------------------------------
-- File Name: noise_gen.vhd
-- Title & Purpose: Pseudo Random Noise Generator
-- Author/Engineer: omerorkn
-- Date of Creation: 02.02.2023
-- Version: 01
-- Description: 
-- Pseudo-Random Noise Generation with LFSR
-- Module works at 100 MHz system clock
-- Module generates minimum 2-bit and maximum 24-bit noise
--
-- File history:
-- 00 : 02.02.2023 : File created.
-- 01 : 06.02.2023 : Comments added to code.
---------------------------------------------------------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity noise_gen is
	 generic (
		DATA_WIDTH 	: integer := 5;          								-- noise out bit width
		CLK_FREQ	: integer := 100_000_000;					                    	-- system clock frequency
		SHIFT_FREQ	: integer := 100						                  	-- shifting frequency
	 );                 
	 port (                 
		-- Input Ports                  
		clk 		: in std_logic;								                -- system clock input
		rst_n 		: in std_logic;							                    	-- active low reset	
		en 		: in std_logic;					    		                    	-- enable trigger
                                            
		-- Output Ports			                    
		noise_out 	: out std_logic_vector(DATA_WIDTH - 1 downto 0)						-- noise out port
	 );
end noise_gen;

architecture rtl of noise_gen is

	constant TIMER_LIM 	: integer := CLK_FREQ / SHIFT_FREQ;                                                     -- integer value for between different output values
	signal polynomial 	: std_logic_vector(DATA_WIDTH - 1 downto 0) := (DATA_WIDTH - 1 => '1', others => '0'); 	-- polynomial for maximum-length LFSR
	signal timer 		: integer range 0 to TIMER_LIM - 1 := 0;                                                -- integer counter for time between different output values
	signal data_reg 	: std_logic_vector(DATA_WIDTH - 1 downto 0);                                            -- register for feedback
	
begin

		data_2 : if (DATA_WIDTH = 2) generate
			polynomial <= "11";
		end generate data_2;

		data_3 : if (DATA_WIDTH = 3) generate
			polynomial <= "110";
		end generate data_3;
		
		data_4 : if (DATA_WIDTH = 4) generate
			polynomial <= "1100";
		end generate data_4;
		
		data_5 : if (DATA_WIDTH = 5) generate
			polynomial <= "10100";
		end generate data_5;
		
		data_6 : if (DATA_WIDTH = 6) generate
			polynomial <= "110000";
		end generate data_6;
		
		data_7 : if (DATA_WIDTH = 7) generate
			polynomial <= "1100000";
		end generate data_7;
		
		data_8 : if (DATA_WIDTH = 8) generate
			polynomial <= "10110100";
		end generate data_8;
	
		data_9 : if (DATA_WIDTH = 9) generate
			polynomial <= "100010000";
		end generate data_9;
		
		data_10 : if (DATA_WIDTH = 10) generate
			polynomial <= "1001000000";
		end generate data_10;
		
		data_11 : if (DATA_WIDTH = 11) generate
			polynomial <= "10100000000";
		end generate data_11;
		
		data_12 : if (DATA_WIDTH = 12) generate
			polynomial <= "111000001000";
		end generate data_12;
		
		data_13 : if (DATA_WIDTH = 13) generate
			polynomial <= "1110010000000";
		end generate data_13;
		
		data_14 : if (DATA_WIDTH = 14) generate
			polynomial <= "11100000000010";
		end generate data_14;
		
		data_15 : if (DATA_WIDTH = 15) generate
			polynomial <= "110000000000000";
		end generate data_15;
		
		data_16 : if (DATA_WIDTH = 16) generate
			polynomial <= "1101000000001000";
		end generate data_16;
		
		data_17 : if (DATA_WIDTH = 17) generate
			polynomial <= "10010000000000000";
		end generate data_17;
		
		data_18 : if (DATA_WIDTH = 18) generate
			polynomial <= "100000010000000000";
		end generate data_18;
		
		data_19 : if (DATA_WIDTH = 19) generate
			polynomial <= "1110010000000000000";
		end generate data_19;
		
		data_20 : if (DATA_WIDTH = 20) generate
			polynomial <= "10010000000000000000";
		end generate data_20;
		
		data_21 : if (DATA_WIDTH = 21) generate
			polynomial <= "101000000000000000000";
		end generate data_21;
		
        data_22 : if (DATA_WIDTH = 22) generate
			polynomial <= "1100000000000000000000";
		end generate data_22;
		
		data_23 : if (DATA_WIDTH = 23) generate
			polynomial <= "10000100000000000000000";
		end generate data_23;
		
        data_24 : if (DATA_WIDTH = 24) generate
			polynomial <= "111000010000000000000000";
		end generate data_24;
		
	main_p : process (clk, rst_n)
	begin
	
		if (rst_n = '0') then
			
			data_reg 	<= polynomial;
			noise_out 	<= (others => '0');
			timer		<= 0;
			
		elsif (rising_edge(clk)) then
		
			noise_out 	<= data_reg;
			if (en = '1') then
            
				if (timer = TIMER_LIM - 1) then
					data_reg(DATA_WIDTH - 1 downto 1) <= data_reg(DATA_WIDTH - 2 downto 0);
					if (DATA_WIDTH = 2) then
						data_reg(0) <= data_reg(0) xor data_reg(1);
					elsif (DATA_WIDTH = 3) then
						data_reg(0) <= data_reg(1) xor data_reg(2);
					elsif (DATA_WIDTH = 4) then
						data_reg(0) <= data_reg(2) xor data_reg(3);
					elsif (DATA_WIDTH = 5) then
						data_reg(0) <= data_reg(2) xor data_reg(4);
					elsif (DATA_WIDTH = 6) then
						data_reg(0) <= data_reg(4) xor data_reg(5);
					elsif (DATA_WIDTH = 7) then
						data_reg(0) <= data_reg(5) xor data_reg(6);
					elsif (DATA_WIDTH = 8) then
						data_reg(0) <= data_reg(3) xor data_reg(4) xor data_reg(5) xor data_reg(7);
					elsif (DATA_WIDTH = 9) then
						data_reg(0) <= data_reg(4) xor data_reg(8);
					elsif (DATA_WIDTH = 10) then
						data_reg(0) <= data_reg(6) xor data_reg(9);
					elsif (DATA_WIDTH = 11) then
						data_reg(0) <= data_reg(8) xor data_reg(10);
					elsif (DATA_WIDTH = 12) then
						data_reg(0) <= data_reg(3) xor data_reg(9) xor data_reg(10) xor data_reg(11);
					elsif (DATA_WIDTH = 13) then
						data_reg(0) <= data_reg(7) xor data_reg(10) xor data_reg(11) xor data_reg(12);
					elsif (DATA_WIDTH = 14) then
						data_reg(0) <= data_reg(1) xor data_reg(11) xor data_reg(12) xor data_reg(13);
					elsif (DATA_WIDTH = 15) then
						data_reg(0) <= data_reg(13) xor data_reg(14);
					elsif (DATA_WIDTH = 16) then
						data_reg(0) <= data_reg(3) xor data_reg(12) xor data_reg(14) xor data_reg(15);
					elsif (DATA_WIDTH = 17) then
						data_reg(0) <= data_reg(13) xor data_reg(16);
					elsif (DATA_WIDTH = 18) then
						data_reg(0) <= data_reg(10) xor data_reg(17);
					elsif (DATA_WIDTH = 19) then
						data_reg(0) <= data_reg(13) xor data_reg(16) xor data_reg(17) xor data_reg(18);
					elsif (DATA_WIDTH = 20) then
						data_reg(0) <= data_reg(16) xor data_reg(19);
					elsif (DATA_WIDTH = 21) then
						data_reg(0) <= data_reg(18) xor data_reg(20);
					elsif (DATA_WIDTH = 22) then
						data_reg(0) <= data_reg(20) xor data_reg(21);
					elsif (DATA_WIDTH = 23) then
						data_reg(0) <= data_reg(17) xor data_reg(22);
					elsif (DATA_WIDTH = 24) then
						data_reg(0) <= data_reg(16) xor data_reg(21) xor data_reg(22) xor data_reg(23);
					else
						null;
					
					end if;
					timer 		<= 0;
				else
					timer 		<= timer + 1;
				end if;
			end if;
		end if;
	end process;

end rtl;
