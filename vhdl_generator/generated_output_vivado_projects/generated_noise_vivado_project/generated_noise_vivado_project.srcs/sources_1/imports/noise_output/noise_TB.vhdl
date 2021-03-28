library ieee; 
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity noise_testbench is 
end noise_testbench; 


architecture noise_arch of noise_testbench is 

  -- testbench constants 
  constant clock_period : time := 10 ns; 
  constant noise_ram_width : natural := 16; 
  constant noise_ram_depth : natural := 256; 

  -- signals 
  signal clk : std_logic := '1'; 
  signal rst : std_logic := '1'; 

  signal noise_out0_ready : std_logic := '0'; 
  signal noise_out0_valid : std_logic; 
  signal noise_out0_data : std_logic_vector(noise_ram_width - 1 downto 0); 

 

  component noise is 
      generic ( 
          noise_ram_width : natural; 
          noise_ram_depth : natural 
      ); 
      port ( 
          noise_clk : in std_logic; 
          noise_rst : in std_logic; 

          noise_out0_ready : out std_logic; 
          noise_out0_valid : out std_logic; 
          noise_out0_data : out std_logic_vector(noise_ram_width - 1 downto 0) 
      ); end component; 


begin 

  clk <= not clk after clock_period / 2; 

  noise_wrapper : noise GENERIC MAP (noise_ram_width, 
                          noise_ram_depth 
                          ) 
              PORT MAP    ( 
                          noise_clk => clk, 
                          noise_rst => rst, 
 
                          noise_out0_ready => noise_out0_ready, 
                          noise_out0_valid => noise_out0_valid, 
                          noise_out0_data => noise_out0_data
                          ); 


    TB_sequencer : process is 
    begin 

        wait for 10 * clock_period; 
        rst <= '0'; 


       report "Writing data..."; 


        report "Adding input..."; 
        report "Reading data..."; 

        wait for 10 * clock_period;noise_out0_ready <= '1'; 
        --Currently broken and needs to get fixed 
        --while noise_out0_valid = '0' loop 
        noise_out0_data <= std_logic_vector(unsigned(noise_out0_data) + 1); 
        --end loop;  
        wait for 10 * clock_period; 

        report "Test completed. Check waveform."; 
        noise_out0_ready <= '0'; 


        report "Testbench completed."; 

    end process; 

end architecture;