library ieee; 
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity copy1_testbench is 
end copy1_testbench; 


architecture copy1_arch of copy1_testbench is 

  -- testbench constants 
  constant clock_period : time := 10 ns; 
  constant copy1_ram_width : natural := 16; 
  constant copy1_ram_depth : natural := 256; 

  -- signals 
  signal clk : std_logic := '1'; 
  signal rst : std_logic := '1'; 

  signal copy1_in0_ready : std_logic; 
  signal copy1_in0_valid : std_logic := '0'; 
  signal copy1_in0_data : std_logic_vector(copy1_ram_width - 1 downto 0);  
 
  signal copy1_out0_ready : std_logic := '0'; 
  signal copy1_out0_valid : std_logic; 
  signal copy1_out0_data : std_logic_vector(copy1_ram_width - 1 downto 0); 

 

  component copy1 is 
      generic ( 
          copy1_ram_width : natural; 
          copy1_ram_depth : natural 
      ); 
      port ( 
          copy1_clk : in std_logic; 
          copy1_rst : in std_logic; 

          copy1_in0_ready : in std_logic; 
          copy1_in0_valid : in std_logic; 
          copy1_in0_data : in std_logic_vector(copy1_ram_width - 1 downto 0); 
 
          copy1_out0_ready : out std_logic; 
          copy1_out0_valid : out std_logic; 
          copy1_out0_data : out std_logic_vector(copy1_ram_width - 1 downto 0) 
      ); end component; 


begin 

  clk <= not clk after clock_period / 2; 

  copy1_wrapper : copy1 GENERIC MAP (copy1_ram_width, 
                          copy1_ram_depth 
                          ) 
              PORT MAP    ( 
                          copy1_clk => clk, 
                          copy1_rst => rst, 
 
                          copy1_in0_ready => copy1_in0_ready, 
                          copy1_in0_valid => copy1_in0_valid, 
                          copy1_in0_data => copy1_in0_data, 
 
                          copy1_out0_ready => copy1_out0_ready, 
                          copy1_out0_valid => copy1_out0_valid, 
                          copy1_out0_data => copy1_out0_data 
                          ); 

    TB_sequencer : process is 
    begin 

        wait for 10 * clock_period; 
        rst <= '0'; 
        copy1_in0_valid <= '1'; 


       report "Writing data..."; 
        copy1_in0_data <= (others => '1'); 


        report "Adding input..."; 
        while copy1_in0_ready = '1' loop 
                copy1_in0_data <= std_logic_vector(unsigned(copy1_in0_data) + 1); 
                wait for 10 * clock_period; 
        end loop; 
        wait for 10 * clock_period; 
        copy1_in0_valid <= '0'; 


        report "Reading data..."; 

        wait for 10 * clock_period;        copy1_out0_ready <= '1'; 
        while copy1_out0_valid = '0' loop 
            copy1_out0_data <= std_logic_vector(unsigned(copy1_out0_data) + 1); 
        end loop;  
        wait for 10 * clock_period; 

        report "Test completed. Check waveform."; 
        copy1_out0_ready <= '0'; 


        report "Testbench completed."; 

    end process; 

end architecture;