library ieee; 
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.env.finish; 


entity math_testbench is 
end math_testbench; 


architecture math_arch of math_testbench is 

  -- testbench constants 
  constant clock_period : time := 10 ns; 
  constant math_ram_width : natural := 16; 
  constant math_ram_depth : natural := 3; 

  -- signals 
  signal clk : std_logic := '1'; 
  signal rst : std_logic := '1'; 

  signal math_in0_ready : std_logic; 
  signal math_in0_valid : std_logic := '0'; 
  signal math_in0_data : std_logic_vector(math_ram_width - 1 downto 0) := (others => '0');  

  signal math_in1_ready : std_logic; 
  signal math_in1_valid : std_logic := '0'; 
  signal math_in1_data : std_logic_vector(math_ram_width - 1 downto 0) := (others => '0');  

  signal math_in2_ready : std_logic; 
  signal math_in2_valid : std_logic := '0'; 
  signal math_in2_data : std_logic_vector(math_ram_width - 1 downto 0) := (others => '0');  

  signal math_in3_ready : std_logic; 
  signal math_in3_valid : std_logic := '0'; 
  signal math_in3_data : std_logic_vector(math_ram_width - 1 downto 0) := (others => '0');  

  signal math_in4_ready : std_logic; 
  signal math_in4_valid : std_logic := '0'; 
  signal math_in4_data : std_logic_vector(math_ram_width - 1 downto 0) := (others => '0');  

  signal math_in5_ready : std_logic; 
  signal math_in5_valid : std_logic := '0'; 
  signal math_in5_data : std_logic_vector(math_ram_width - 1 downto 0) := (others => '0');  

  signal math_in6_ready : std_logic; 
  signal math_in6_valid : std_logic := '0'; 
  signal math_in6_data : std_logic_vector(math_ram_width - 1 downto 0) := (others => '0');  

  signal math_in7_ready : std_logic; 
  signal math_in7_valid : std_logic := '0'; 
  signal math_in7_data : std_logic_vector(math_ram_width - 1 downto 0) := (others => '0');  

  signal math_out0_ready : std_logic := '0'; 
  signal math_out0_valid : std_logic; 
  signal math_out0_data : std_logic_vector(math_ram_width - 1 downto 0); 
  signal expected_math_out0_data : std_logic_vector(math_ram_width - 1 downto 0) := (others => '0'); 



begin 

    -- clock ticking 
  clk <= not clk after clock_period / 2; 

    -- Instantiate the wrapper to be tested
  math_wrapper : entity work.math(math_arch) 
              GENERIC MAP (math_ram_width, 
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


    -- Sequential test process 
    send_proc : process is 
    begin 

        -- Reset system 
        rst <= '1'; 
        wait until rising_edge(clk); 

        rst <= '0'; 
        wait until rising_edge(clk); 

        report "Adding input..."; 

        -- Loop to start writing inside 10 values 

        while unsigned(math_in0_data) < 10 loop 

            report "Writing one data iteration to INPUT_0..."; 
            wait until rising_edge(clk); 

            if math_in0_valid = '1' and math_in0_ready = '1' then 
                math_in0_data <= std_logic_vector(unsigned(math_in0_data) + 1); 
                math_in0_valid <= '0'; 
            elsif math_in0_valid = '0' then 
                math_in0_valid <= '1'; 
            end if; 

        end loop; 

        while unsigned(math_in1_data) < 10 loop 

            report "Writing one data iteration to INPUT_1..."; 
            wait until rising_edge(clk); 

            if math_in1_valid = '1' and math_in1_ready = '1' then 
                math_in1_data <= std_logic_vector(unsigned(math_in1_data) + 1); 
                math_in1_valid <= '0'; 
            elsif math_in1_valid = '0' then 
                math_in1_valid <= '1'; 
            end if; 

        end loop; 

        while unsigned(math_in2_data) < 10 loop 

            report "Writing one data iteration to INPUT_2..."; 
            wait until rising_edge(clk); 

            if math_in2_valid = '1' and math_in2_ready = '1' then 
                math_in2_data <= std_logic_vector(unsigned(math_in2_data) + 1); 
                math_in2_valid <= '0'; 
            elsif math_in2_valid = '0' then 
                math_in2_valid <= '1'; 
            end if; 

        end loop; 

        while unsigned(math_in3_data) < 10 loop 

            report "Writing one data iteration to INPUT_3..."; 
            wait until rising_edge(clk); 

            if math_in3_valid = '1' and math_in3_ready = '1' then 
                math_in3_data <= std_logic_vector(unsigned(math_in3_data) + 1); 
                math_in3_valid <= '0'; 
            elsif math_in3_valid = '0' then 
                math_in3_valid <= '1'; 
            end if; 

        end loop; 

        while unsigned(math_in4_data) < 10 loop 

            report "Writing one data iteration to INPUT_4..."; 
            wait until rising_edge(clk); 

            if math_in4_valid = '1' and math_in4_ready = '1' then 
                math_in4_data <= std_logic_vector(unsigned(math_in4_data) + 1); 
                math_in4_valid <= '0'; 
            elsif math_in4_valid = '0' then 
                math_in4_valid <= '1'; 
            end if; 

        end loop; 

        while unsigned(math_in5_data) < 10 loop 

            report "Writing one data iteration to INPUT_5..."; 
            wait until rising_edge(clk); 

            if math_in5_valid = '1' and math_in5_ready = '1' then 
                math_in5_data <= std_logic_vector(unsigned(math_in5_data) + 1); 
                math_in5_valid <= '0'; 
            elsif math_in5_valid = '0' then 
                math_in5_valid <= '1'; 
            end if; 

        end loop; 

        while unsigned(math_in6_data) < 10 loop 

            report "Writing one data iteration to INPUT_6..."; 
            wait until rising_edge(clk); 

            if math_in6_valid = '1' and math_in6_ready = '1' then 
                math_in6_data <= std_logic_vector(unsigned(math_in6_data) + 1); 
                math_in6_valid <= '0'; 
            elsif math_in6_valid = '0' then 
                math_in6_valid <= '1'; 
            end if; 

        end loop; 

        while unsigned(math_in7_data) < 10 loop 

            report "Writing one data iteration to INPUT_7..."; 
            wait until rising_edge(clk); 

            if math_in7_valid = '1' and math_in7_ready = '1' then 
                math_in7_data <= std_logic_vector(unsigned(math_in7_data) + 1); 
                math_in7_valid <= '0'; 
            elsif math_in7_valid = '0' then 
                math_in7_valid <= '1'; 
            end if; 

        end loop; 

        report "Writing completed..."; 
        finish;

    end process; 


    receive_proc : process is 
    begin 

        -- Wait for the buffer to get full 
        report "Wait for filling..."; 
        math_out0_ready <= '0'; 
        wait for 10 * clock_period; 

        -- Loop to start reading data 

        report "Start reading data..."; 

        while unsigned(math_in0_data) < 3 loop 

            report "Reading from OUTPUT_0..."; 
            wait until rising_edge(clk); 

            if math_out0_valid = '1' and math_out0_ready = '1' then 
                 expected_math_out0_data <= std_logic_vector(unsigned(expected_math_out0_data) + 1); 
                math_out0_ready <= '0'; 
            elsif  math_out0_ready = '0' then 
                math_out0_ready <= '1'; 
            end if; 

        end loop; 

        report "Test completed. Check waveform."; 
        finish; 

    end process; 

end architecture; 
