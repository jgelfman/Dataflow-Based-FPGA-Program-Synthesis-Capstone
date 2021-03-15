library ieee; 
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity copy2_testbench is 
end copy2_testbench; 


architecture copy2_arch of copy2_testbench is 

  -- testbench constants 
  constant clock_period : time := 10 ns; 
  constant copy2_ram_width : natural := 16; 
  constant copy2_ram_depth : natural := 256; 

  -- signals 
  signal clk : std_logic := '1'; 
  signal rst : std_logic := '1'; 

  signal copy2_in0_ready : std_logic; 
  signal copy2_in0_valid : std_logic := '0'; 
  signal copy2_in0_data : std_logic_vector(copy2_ram_width - 1 downto 0);  
 
  signal copy2_in1_ready : std_logic; 
  signal copy2_in1_valid : std_logic := '0'; 
  signal copy2_in1_data : std_logic_vector(copy2_ram_width - 1 downto 0);  
 
  signal copy2_out0_ready : std_logic := '0'; 
  signal copy2_out0_valid : std_logic; 
  signal copy2_out0_data : std_logic_vector(copy2_ram_width - 1 downto 0); 

   signal copy2_out1_ready : std_logic := '0'; 
  signal copy2_out1_valid : std_logic; 
  signal copy2_out1_data : std_logic_vector(copy2_ram_width - 1 downto 0); 

 

  component copy2 is 
      generic ( 
          copy2_ram_width : natural; 
          copy2_ram_depth : natural 
      ); 
      port ( 
          copy2_clk : in std_logic; 
          copy2_rst : in std_logic; 

          copy2_in0_ready : in std_logic; 
          copy2_in0_valid : in std_logic; 
          copy2_in0_data : in std_logic_vector(copy2_ram_width - 1 downto 0); 
 
          copy2_in1_ready : in std_logic; 
          copy2_in1_valid : in std_logic; 
          copy2_in1_data : in std_logic_vector(copy2_ram_width - 1 downto 0); 
 
          copy2_out0_ready : out std_logic; 
          copy2_out0_valid : out std_logic; 
          copy2_out0_data : out std_logic_vector(copy2_ram_width - 1 downto 0) 
      ); end component; 


          copy2_out1_ready : out std_logic; 
          copy2_out1_valid : out std_logic; 
          copy2_out1_data : out std_logic_vector(copy2_ram_width - 1 downto 0) 
      ); end component; 


begin 

  clk <= not clk after clock_period / 2; 

  copy2_wrapper : copy2 GENERIC MAP (copy2_ram_width, 
                          copy2_ram_depth 
                          ) 
              PORT MAP    ( 
                          copy2_clk => clk, 
                          copy2_rst => rst, 
 
                          copy2_in0_ready => copy2_in0_ready, 
                          copy2_in0_valid => copy2_in0_valid, 
                          copy2_in0_data => copy2_in0_data, 
 
                          copy2_in1_ready => copy2_in1_ready, 
                          copy2_in1_valid => copy2_in1_valid, 
                          copy2_in1_data => copy2_in1_data, 
 
                          copy2_out0_ready => copy2_out0_ready, 
                          copy2_out0_valid => copy2_out0_valid, 
                          copy2_out0_data => copy2_out0_data 
                          copy2_out1_ready => copy2_out1_ready, 
                          copy2_out1_valid => copy2_out1_valid, 
                          copy2_out1_data => copy2_out1_data 
                          ); 

    TB_sequencer : process is 
    begin 

        wait for 10 * clock_period; 
        rst <= '0'; 
        copy2_in0_valid <= '1'; 
        copy2_in1_valid <= '1'; 


       report "Writing data..."; 
        copy2_in0_data <= (others => '1'); 
        copy2_in1_data <= (others => '1'); 


        report "Adding input..."; 
        while copy2_in0_ready = '1' loop 
                copy2_in0_data <= std_logic_vector(unsigned(copy2_in0_data) + 1); 
                wait for 10 * clock_period; 
        end loop; 
        wait for 10 * clock_period; 
        copy2_in0_valid <= '0'; 


        while copy2_in1_ready = '1' loop 
                copy2_in1_data <= std_logic_vector(unsigned(copy2_in1_data) + 1); 
                wait for 10 * clock_period; 
        end loop; 
        wait for 10 * clock_period; 
        copy2_in1_valid <= '0'; 


        report "Reading data..."; 

        wait for 10 * clock_period;        copy2_out0_ready <= '1'; 
        while copy2_out0_valid = '0' loop 
            copy2_out0_data <= std_logic_vector(unsigned(copy2_out0_data) + 1); 
        end loop;  
        wait for 10 * clock_period; 

        copy2_out1_ready <= '1'; 
        while copy2_out1_valid = '0' loop 
            copy2_out1_data <= std_logic_vector(unsigned(copy2_out1_data) + 1); 
        end loop;  
        wait for 10 * clock_period; 

        report "Test completed. Check waveform."; 
        copy2_out0_ready <= '0'; 
        copy2_out1_ready <= '0'; 


        report "Testbench completed."; 

    end process; 

end architecture;