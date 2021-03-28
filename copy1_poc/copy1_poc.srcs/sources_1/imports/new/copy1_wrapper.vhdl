library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use std.env.finish;

entity copy1_wrapper is
end copy1_wrapper;

architecture copy1_arch of copy1_wrapper is

  -- testbench constants
  constant clock_period : time := 10 ns;
  constant copy1_ram_width : natural := 16;
  constant copy1_ram_depth : natural := 3;

  -- signals
  signal clk : std_logic := '1';
  signal rst : std_logic := '1';
  
  signal copy1_in_ready : std_logic;
  signal copy1_in_valid : std_logic := '0';
  signal copy1_in_data : std_logic_vector(copy1_ram_width - 1 downto 0) := (others => '0');
  
  signal copy1_out_ready : std_logic := '0';
  signal copy1_out_valid : std_logic;
  signal copy1_out_data : std_logic_vector(copy1_ram_width - 1 downto 0);
  signal expected_copy1_out_data : std_logic_vector(copy1_ram_width - 1 downto 0) := (others => '0');


  component copy1 is
      generic (
          copy1_ram_width : natural;
          copy1_ram_depth : natural
          );
      port (
          copy1_clk : in std_logic;
          copy1_rst : in std_logic;
          
          copy1_in_ready : in std_logic;
          copy1_in_valid : in std_logic;
          copy1_in_data : in std_logic_vector(copy1_ram_width - 1 downto 0);

          copy1_out_ready : out std_logic;
          copy1_out_valid : out std_logic;
          copy1_out_data : out std_logic_vector(copy1_ram_width - 1 downto 0)
      ); end component;

      
begin

    -- clock ticking
    clk <= not clk after clock_period / 2;

    copy : copy1 GENERIC MAP   (copy1_ram_width,
                              copy1_ram_depth
                              )
                  PORT MAP    (
                              copy1_clk => clk,
                              copy1_rst => rst,

                              copy1_in_ready => copy1_in_ready,
                              copy1_in_valid => copy1_in_valid,
                              copy1_in_data => copy1_in_data,
    
                              copy1_out_ready => copy1_out_ready,
                              copy1_out_valid => copy1_out_valid,
                              copy1_out_data => copy1_out_data
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

        while unsigned(copy1_in_data) < 10 loop

            report "Writing one data iteration..."
            wait until rising_edge(clk);

            if copy1_in_valid = '1' and copy1_in_ready = '1' then
                copy1_in_data <= std_logic_vector(unsigned(copy1_in_data) + 1);
                copy1_in_valid <= '0';
            elsif copy1_in_valid = '0' then
                copy1_in_valid <= '1';
            end if;

        end loop;

        report "Writing completed..."
        finish;
    end process;


    receive_proc : process is
    begin

        -- Wait for the buffer to get full
        report "Wait for filling...";
        copy1_out_ready <= '0';
        wait for 10 * clock_period;

        -- Loop to start reading data

        report "Start reading data..."

        while unsigned(expected_copy1_out_data) < 10 loop

            report "Reading one data iteration..."
            wait until rising_edge(clk);

            if copy1_out_valid = '1' and copy1_out_ready = '1' then
                expected_copy1_out_data <= std_logic_vector(unsigned(expected_copy1_out_data) + 1);
                copy1_out_ready <= '0';
            elsif  copy1_out_ready = '0' then
                copy1_out_ready <= '1';
            end if;
        
        end loop;

        report "Test completed. Check waveform.";
        finish;
        
    end process;

end architecture;
