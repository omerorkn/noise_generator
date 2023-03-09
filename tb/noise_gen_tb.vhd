--------------------------------------------------------------------------------------------------------------------------------------------------
-- File Name: noise_gen_tb.vhd
-- Title & Purpose: Pseudo Random Noise Generator Testbench
-- Author/Engineer: omerorkn
-- Date of Creation: 02.02.2023
-- Version: 02
-- Description: 
-- Testbench for Pseudo-Random Noise Generation with LFSR
-- Module works at 100 MHz system clock
--
-- File history:
-- 00   	: 02.02.2023 : File created.
-- 01 		: 06.02.2023 : Comments added to code.
-- 02    : 08.02.2023 : "textio" library used to write output data to a text file.
--
-- Note : If you would like to write all the noise data for create a line or histogram on excel, you can uncomment between line 94 - line 115 and
-- 		  you can use textio library for create an output text file. 
--------------------------------------------------------------------------------------------------------------------------------------------------
library IEEE;
library STD;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;
use IEEE.STD_LOGIC_TEXTIO.all;
use STD.TEXTIO.all;

entity noise_gen_tb is
  generic (
    DATA_WIDTH  : integer := 5;                                                         -- noise out bit width
    CLK_FREQ    : integer := 100_000_000;                                               -- system clock frequency
    SHIFT_FREQ  : integer := 100_000_000;                                               -- shifting frequency
    FILE_NAME   : string  := "./log_file.dat"                                           -- file name for output text file
  );
end noise_gen_tb;

architecture testbench of noise_gen_tb is

  component noise_gen is
    generic (
      DATA_WIDTH  : integer := 5;                                                       -- noise out bit width
      CLK_FREQ    : integer := 100_000_000;                                             -- system clock frequency
      SHIFT_FREQ  : integer := 100                                                      -- shifting frequency
    );
    port (
      -- Input Ports						
      clk         : in std_logic;                                                       -- system clock input
      rst_n       : in std_logic;                                                       -- active low reset	
      en          : in std_logic;                                                       -- enable trigger

      -- Output Ports		
      noise_out   : out std_logic_vector(DATA_WIDTH - 1 downto 0)                       -- noise out port
    );
  end component;

  constant CLK_PERIOD : time := 1000 ms / CLK_FREQ;

  signal clk            : std_logic := '1';                                             -- test signal for system clock source
  signal rst_n          : std_logic := '1';                                             -- test signal for active low reset
  signal en             : std_logic := '0';                                             -- test signal for module enable trigger
  signal noise_out      : std_logic_vector(DATA_WIDTH - 1 downto 0) := (others => '0'); -- test signal for generated noise out
  signal binary_counter : std_logic_vector(DATA_WIDTH - 1 downto 0) := (others => '0'); -- binary counter for observing maximal-length LFSR

begin

  clk_p : process
  begin
    clk <= '0';
    wait for CLK_PERIOD / 2;
    clk <= '1';
    wait for CLK_PERIOD / 2;

    if (rst_n = '0' or en = '0') then
      binary_counter <= (others => '0');
    elsif (rst_n = '1' and en = '1') then
      binary_counter <= binary_counter + '1';
    else
      null;
    end if;

  end process;

  test_p : process
  begin

    rst_n <= '0';
    wait for CLK_PERIOD * 5;
    rst_n <= '1';
    wait for CLK_PERIOD * 5;

    en <= '1';

    wait;
  end process;

  --    write_to_file_p : process (clk, rst_n)
  --    
  --    file test_vector    : text open write_mode is FILE_NAME;
  --    variable row        : line;
  --    
  --    
  --    begin
  --    
  --        if (rst_n = '0') then
  --        ----------------------------
  --        elsif (rising_edge(clk)) then
  --            if (en = '1') then
  --            
  --                write(row, noise_out, right, 15);
  --                write(row, conv_integer(noise_out), right, 15);
  --                hwrite(row, noise_out, right, 15);
  --                hwrite(row,"000000" & noise_out, right, 15);
  --                writeline(test_vector, row);
  --                
  --            end if;
  --        end if;
  --    end process;

  UUT : noise_gen
  generic map(
    DATA_WIDTH  => DATA_WIDTH,
    CLK_FREQ    => CLK_FREQ,
    SHIFT_FREQ  => SHIFT_FREQ
  )
  port map(
    clk         => clk,
    rst_n       => rst_n,
    en          => en,
    noise_out   => noise_out
  );

end testbench;
