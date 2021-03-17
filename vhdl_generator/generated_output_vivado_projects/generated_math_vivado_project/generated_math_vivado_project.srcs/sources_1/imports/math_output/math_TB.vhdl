library ieee; 
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity math_testbench is 
end math_testbench; 


architecture math_arch of math_testbench is 

  -- testbench constants 
  constant clock_period : time := 10 ns; 
  constant math_ram_width : natural := 16; 
  constant math_ram_depth : natural := 256; 

  -- signals 
  signal clk : std_logic := '1'; 
  signal rst : std_logic := '1'; 

  signal math_in0_ready : std_logic; 
  signal math_in0_valid : std_logic := '0'; 
  signal math_in0_data : std_logic_vector(math_ram_width - 1 downto 0);  

  signal math_in1_ready : std_logic; 
  signal math_in1_valid : std_logic := '0'; 
  signal math_in1_data : std_logic_vector(math_ram_width - 1 downto 0);  

  signal math_in2_ready : std_logic; 
  signal math_in2_valid : std_logic := '0'; 
  signal math_in2_data : std_logic_vector(math_ram_width - 1 downto 0);  

  signal math_in3_ready : std_logic; 
  signal math_in3_valid : std_logic := '0'; 
  signal math_in3_data : std_logic_vector(math_ram_width - 1 downto 0);  

  signal math_in4_ready : std_logic; 
  signal math_in4_valid : std_logic := '0'; 
  signal math_in4_data : std_logic_vector(math_ram_width - 1 downto 0);  

  signal math_in5_ready : std_logic; 
  signal math_in5_valid : std_logic := '0'; 
  signal math_in5_data : std_logic_vector(math_ram_width - 1 downto 0);  

  signal math_in6_ready : std_logic; 
  signal math_in6_valid : std_logic := '0'; 
  signal math_in6_data : std_logic_vector(math_ram_width - 1 downto 0);  

  signal math_in7_ready : std_logic; 
  signal math_in7_valid : std_logic := '0'; 
  signal math_in7_data : std_logic_vector(math_ram_width - 1 downto 0);  

  signal math_out0_ready : std_logic := '0'; 
  signal math_out0_valid : std_logic; 
  signal math_out0_data : std_logic_vector(math_ram_width - 1 downto 0); 

 

  component math is 
      generic ( 
          math_ram_width : natural; 
          math_ram_depth : natural 
      ); 
      port ( 
          math_clk : in std_logic; 
          math_rst : in std_logic; 

          math_in0_ready : in std_logic; 
          math_in0_valid : in std_logic; 
          math_in0_data : in std_logic_vector(math_ram_width - 1 downto 0); 
 
          math_in1_ready : in std_logic; 
          math_in1_valid : in std_logic; 
          math_in1_data : in std_logic_vector(math_ram_width - 1 downto 0); 
 
          math_in2_ready : in std_logic; 
          math_in2_valid : in std_logic; 
          math_in2_data : in std_logic_vector(math_ram_width - 1 downto 0); 
 
          math_in3_ready : in std_logic; 
          math_in3_valid : in std_logic; 
          math_in3_data : in std_logic_vector(math_ram_width - 1 downto 0); 
 
          math_in4_ready : in std_logic; 
          math_in4_valid : in std_logic; 
          math_in4_data : in std_logic_vector(math_ram_width - 1 downto 0); 
 
          math_in5_ready : in std_logic; 
          math_in5_valid : in std_logic; 
          math_in5_data : in std_logic_vector(math_ram_width - 1 downto 0); 
 
          math_in6_ready : in std_logic; 
          math_in6_valid : in std_logic; 
          math_in6_data : in std_logic_vector(math_ram_width - 1 downto 0); 
 
          math_in7_ready : in std_logic; 
          math_in7_valid : in std_logic; 
          math_in7_data : in std_logic_vector(math_ram_width - 1 downto 0); 
 
          math_out0_ready : out std_logic; 
          math_out0_valid : out std_logic; 
          math_out0_data : out std_logic_vector(math_ram_width - 1 downto 0) 
      ); end component; 


begin 

  clk <= not clk after clock_period / 2; 

  math_wrapper : math GENERIC MAP (math_ram_width, 
                          math_ram_depth 
                          ) 
              PORT MAP    ( 
                          math_clk => clk, 
                          math_rst => rst, 
 
                          math_in0_ready => math_in0_ready, 
                          math_in0_valid => math_in0_valid, 
                          math_in0_data => math_in0_data, 
 
                          math_in1_ready => math_in1_ready, 
                          math_in1_valid => math_in1_valid, 
                          math_in1_data => math_in1_data, 
 
                          math_in2_ready => math_in2_ready, 
                          math_in2_valid => math_in2_valid, 
                          math_in2_data => math_in2_data, 
 
                          math_in3_ready => math_in3_ready, 
                          math_in3_valid => math_in3_valid, 
                          math_in3_data => math_in3_data, 
 
                          math_in4_ready => math_in4_ready, 
                          math_in4_valid => math_in4_valid, 
                          math_in4_data => math_in4_data, 
 
                          math_in5_ready => math_in5_ready, 
                          math_in5_valid => math_in5_valid, 
                          math_in5_data => math_in5_data, 
 
                          math_in6_ready => math_in6_ready, 
                          math_in6_valid => math_in6_valid, 
                          math_in6_data => math_in6_data, 
 
                          math_in7_ready => math_in7_ready, 
                          math_in7_valid => math_in7_valid, 
                          math_in7_data => math_in7_data, 
 
                          math_out0_ready => math_out0_ready, 
                          math_out0_valid => math_out0_valid, 
                          math_out0_data => math_out0_data
                          ); 


    TB_sequencer : process is 
    begin 

        wait for 10 * clock_period; 
        rst <= '0'; 
        math_in0_valid <= '1'; 
        math_in1_valid <= '1'; 
        math_in2_valid <= '1'; 
        math_in3_valid <= '1'; 
        math_in4_valid <= '1'; 
        math_in5_valid <= '1'; 
        math_in6_valid <= '1'; 
        math_in7_valid <= '1'; 


       report "Writing data..."; 
        math_in0_data <= (others => '1'); 
        math_in1_data <= (others => '1'); 
        math_in2_data <= (others => '1'); 
        math_in3_data <= (others => '1'); 
        math_in4_data <= (others => '1'); 
        math_in5_data <= (others => '1'); 
        math_in6_data <= (others => '1'); 
        math_in7_data <= (others => '1'); 


        report "Adding input..."; 
        --Currently broken and needs to get fixed 
        --while math_in0_ready = '1' loop 
        math_in0_data <= std_logic_vector(unsigned(math_in0_data) + 1); 
        --wait for 10 * clock_period; 
        --end loop; 
        wait for 10 * clock_period; 
        math_in0_valid <= '0'; 


        --Currently broken and needs to get fixed 
        --while math_in1_ready = '1' loop 
        math_in1_data <= std_logic_vector(unsigned(math_in1_data) + 1); 
        --wait for 10 * clock_period; 
        --end loop; 
        wait for 10 * clock_period; 
        math_in1_valid <= '0'; 


        --Currently broken and needs to get fixed 
        --while math_in2_ready = '1' loop 
        math_in2_data <= std_logic_vector(unsigned(math_in2_data) + 1); 
        --wait for 10 * clock_period; 
        --end loop; 
        wait for 10 * clock_period; 
        math_in2_valid <= '0'; 


        --Currently broken and needs to get fixed 
        --while math_in3_ready = '1' loop 
        math_in3_data <= std_logic_vector(unsigned(math_in3_data) + 1); 
        --wait for 10 * clock_period; 
        --end loop; 
        wait for 10 * clock_period; 
        math_in3_valid <= '0'; 


        --Currently broken and needs to get fixed 
        --while math_in4_ready = '1' loop 
        math_in4_data <= std_logic_vector(unsigned(math_in4_data) + 1); 
        --wait for 10 * clock_period; 
        --end loop; 
        wait for 10 * clock_period; 
        math_in4_valid <= '0'; 


        --Currently broken and needs to get fixed 
        --while math_in5_ready = '1' loop 
        math_in5_data <= std_logic_vector(unsigned(math_in5_data) + 1); 
        --wait for 10 * clock_period; 
        --end loop; 
        wait for 10 * clock_period; 
        math_in5_valid <= '0'; 


        --Currently broken and needs to get fixed 
        --while math_in6_ready = '1' loop 
        math_in6_data <= std_logic_vector(unsigned(math_in6_data) + 1); 
        --wait for 10 * clock_period; 
        --end loop; 
        wait for 10 * clock_period; 
        math_in6_valid <= '0'; 


        --Currently broken and needs to get fixed 
        --while math_in7_ready = '1' loop 
        math_in7_data <= std_logic_vector(unsigned(math_in7_data) + 1); 
        --wait for 10 * clock_period; 
        --end loop; 
        wait for 10 * clock_period; 
        math_in7_valid <= '0'; 


        report "Reading data..."; 

        wait for 10 * clock_period;math_out0_ready <= '1'; 
        --Currently broken and needs to get fixed 
        --while math_out0_valid = '0' loop 
        math_out0_data <= std_logic_vector(unsigned(math_out0_data) + 1); 
        --end loop;  
        wait for 10 * clock_period; 

        report "Test completed. Check waveform."; 
        math_out0_ready <= '0'; 


        report "Testbench completed."; 

    end process; 

end architecture;