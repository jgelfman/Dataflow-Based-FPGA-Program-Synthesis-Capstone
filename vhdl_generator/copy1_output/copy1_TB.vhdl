library ieee; 
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use std.env.finish;
entity copy1_testbench is 
end copy1_testbench; 


architecture copy1_arch of copy1_testbench is 

  -- testbench constants 
  constant clock_period : time := 10 ns; 
  constant copy1_ram_width : natural := 16; 
  constant copy1_ram_depth : natural := 2; 

  -- signals 
  signal clk : std_logic := '1'; 
  signal rst : std_logic := '1'; 

  signal copy1_in0_ready : std_logic; 
  signal copy1_in0_valid : std_logic := '0'; 
  signal copy1_in0_data : std_logic_vector(copy1_ram_width - 1 downto 0) := (others => '0');  

  signal copy1_out0_ready : std_logic := '0'; 
  signal copy1_out0_valid : std_logic; 
  signal copy1_out0_data : std_logic_vector(copy1_ram_width - 1 downto 0); 
  signal expected_copy1_out0_data : std_logic_vector(copy1_ram_width - 1 downto 0) := (others => '0'); 



begin 

    -- clock ticking 
  clk <= not clk after clock_period / 2; 

    -- Instantiate the wrapper to be tested
  copy1_wrapper : entity work.copy1(copy1_arch) 
              GENERIC MAP (copy1_ram_width, 
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


    -- Sequential test process    send_proc : process is 
    begin 

        -- Reset system 
        rst <= '1'; 
        wait until rising_edge(clk); 

        rst <= '0'; 
        wait until rising_edge(clk); 

        report "Adding input..."; 

        -- Loop to start writing inside 10 values 

        while unsigned(copy1_in0_data) < 10 loop 

            report "Writing one data iteration to INPUT_0..."; 
            wait until rising_edge(clk); 

            if copy1_in0_valid = '1' and copy1_in0_ready = '1' then 
                copy1_in0_data <= std_logic_vector(unsigned(copy1_in0_data) + 1); 
                copy1_in0_valid <= '0'; 
            elsif copy1_in0_valid = '0' then 
                copy1_in0_valid <= '1'; 
            end if; 

        end loop; 

        report "Writing completed..."; 
        finish;

    end process; 


    receive_proc : process is 
    begin 

        -- Wait for the buffer to get full 
        report "Wait for filling..."; 
        copy1_out0_ready <= '0'; 
        wait for 10 * clock_period; 

        -- Loop to start reading data 

        report "Start reading data...";        while unsigned(expected_copy1_out0_data) < 10 loop 

        while unsigned(copy1_in0_data) < 2 loop 

            report "Reading from OUTPUT_0...";            report "Writing one data iteration to input copy1..."; 
            wait until rising_edge(clk); 

            if copy1_out0_valid = '1' and copy1_out0_ready = '1' then 
                 expected_copy1_out0_data <= std_logic_vector(unsigned(expected_copy1_out0_data) + 1); 
                copy1_out0_ready <= '0'; 
            elsif  copy1_out0_ready = '0' then                copy1_out0_ready <= '1'; 
            end if; 

        end loop; 

        report "Test completed. Check waveform."; 
        finish; 

    end process; 

end architecture; 
