library ieee; 
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use std.env.finish;
entity copy2_testbench is 
end copy2_testbench; 


architecture copy2_arch of copy2_testbench is 

  -- testbench constants 
  constant clock_period : time := 10 ns; 
  constant copy2_ram_width : natural := 16; 
  constant copy2_ram_depth : natural := 3; 

  -- signals 
  signal clk : std_logic := '1'; 
  signal rst : std_logic := '1'; 

  signal copy2_in0_ready : std_logic; 
  signal copy2_in0_valid : std_logic := '0'; 
  signal copy2_in0_data : std_logic_vector(copy2_ram_width - 1 downto 0) := (others => '0');  

  signal copy2_in1_ready : std_logic; 
  signal copy2_in1_valid : std_logic := '0'; 
  signal copy2_in1_data : std_logic_vector(copy2_ram_width - 1 downto 0) := (others => '0');  

  signal copy2_out0_ready : std_logic := '0'; 
  signal copy2_out0_valid : std_logic; 
  signal copy2_out0_data : std_logic_vector(copy2_ram_width - 1 downto 0); 
  signal expected_copy2_out0_data : std_logic_vector(copy2_ram_width - 1 downto 0) := (others => '0'); 

  signal copy2_out1_ready : std_logic := '0'; 
  signal copy2_out1_valid : std_logic; 
  signal copy2_out1_data : std_logic_vector(copy2_ram_width - 1 downto 0); 
  signal expected_copy2_out1_data : std_logic_vector(copy2_ram_width - 1 downto 0) := (others => '0'); 



begin 

    -- clock ticking 
  clk <= not clk after clock_period / 2; 

    -- Instantiate the wrapper to be tested  copy2_wrapper : entity work.copy2(copy2_arch) GENERIC MAP (copy2_ram_width, 
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
                          copy2_out0_data => copy2_out0_data, 

                          copy2_out1_ready => copy2_out1_ready, 
                          copy2_out1_valid => copy2_out1_valid, 
                          copy2_out1_data => copy2_out1_data
                          ); 


    -- Sequential test process    send_proc : process is 
    begin 

        -- Reset system 
        rst <= '1'; 
        wait until rising_edge(clk); 

        rst <= '0'; 
        wait until rising_edge(clk); 

        report "Adding input..."; 

        -- Loop to start writing inside 10 values 

        while unsigned(copy2_in0_data) < 10 loop 

            report "Writing one data iteration to INPUT_copy2...";            wait until rising_edge(clk); 

            if copy2_in0_valid = '1' and copy2_in0_ready = '1' then 
                copy2_in0_data <= std_logic_vector(unsigned(copy2_in0_data) + 1); 
                copy2_in0_valid <= '0';            elsif copy2_in0_valid = '0' then 
                copy2_in0_valid <= '1'; 
            end if; 

        end loop; 

        while unsigned(copy2_in1_data) < 10 loop 

            report "Writing one data iteration to INPUT_copy2...";            wait until rising_edge(clk); 

            if copy2_in1_valid = '1' and copy2_in1_ready = '1' then 
                copy2_in1_data <= std_logic_vector(unsigned(copy2_in1_data) + 1); 
                copy2_in1_valid <= '0';            elsif copy2_in1_valid = '0' then 
                copy2_in1_valid <= '1'; 
            end if; 

        end loop; 

        report "Writing completed..."; 
        finish;

    end process; 


    receive_proc : process is 
    begin 

        -- Wait for the buffer to get full 
        report "Wait for filling..."; 
        copy2_out0_ready <= '0'; 
        copy2_out1_ready <= '0'; 
        wait for 10 * clock_period; 

        -- Loop to start reading data 

        report "Start reading data...";        while unsigned(expected_copy2_out0_data) < 10 loop 

        while unsigned(expected_copy2_out1_data) < 10 loop 

        while unsigned(copy2_in0_data) < 3 loop 

            report "Reading from OUTPUT_0...";            report "Writing one data iteration to input copy2...";            wait until rising_edge(clk); 

            if copy2_out0_valid = '1' and copy2_out0_ready = '1' then 
                 expected_copy2_out0_data <= std_logic_vector(unsigned(expected_copy2_out0_data) + 1); 
                copy2_out0_ready <= '0'; 
            elsif  copy2_out0_ready = '0' then                copy2_out0_ready <= '1'; 
            end if; 

        end loop; 

        while unsigned(copy2_in1_data) < 3 loop 

            report "Reading from OUTPUT_1...";            report "Writing one data iteration to input copy2...";            wait until rising_edge(clk); 

            if copy2_out1_valid = '1' and copy2_out1_ready = '1' then 
                 expected_copy2_out1_data <= std_logic_vector(unsigned(expected_copy2_out1_data) + 1); 
                copy2_out1_ready <= '0'; 
            elsif  copy2_out1_ready = '0' then                copy2_out1_ready <= '1'; 
            end if; 

        end loop; 

        report "Test completed. Check waveform."; 
        finish; 

    end process; 

end architecture; 
