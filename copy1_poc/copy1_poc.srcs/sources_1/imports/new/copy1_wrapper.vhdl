library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity copy1_wrapper is
end copy1_wrapper;

architecture copy1_arch of copy1_wrapper is

  -- testbench constants
  constant clock_period : time := 10 ns;
  constant copy1_ram_width : natural := 16;
  constant copy1_ram_depth : natural := 1; --256

  -- signals
  signal clk : std_logic := '1';
  signal rst : std_logic := '1';
  
  signal copy1_in_ready : std_logic;
  signal copy1_in_valid : std_logic := '0';
  signal copy1_in_data : std_logic_vector(copy1_ram_width - 1 downto 0) := (others => '0');
  
  signal copy1_out_ready : std_logic := '0';
  signal copy1_out_valid : std_logic;
  signal copy1_out_data : std_logic_vector(copy1_ram_width - 1 downto 0);

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
    
    proc_sequencer : process is
    begin
    
        wait for 10 * clock_period;
        rst <= '0';
        --copy1_in_ready <= '1';
        copy1_in_valid <= '1';
        --wait until rising_edge(clk);
        
        report "Adding input...";
        copy1_in_data <= (others => '1');
        

        report "Writing data...";
        while copy1_in_ready = '1' loop
                copy1_in_data <= std_logic_vector(unsigned(copy1_in_data) + 1);  
        end loop;    
        --else 
        --    report "Not ready!";
        --    std.env.finish;
        --end if;
        wait for 10 * clock_period;
        copy1_in_valid <= '0';

        --copy1_in <= (others => 'X');


        report "Reading data...";
        
        wait for 10 * clock_period; --(test)
        
        --wait until rising_edge(clk);
        copy1_out_valid <= '1';
        while copy1_out_ready = '1' loop
            copy1_out_data <= std_logic_vector(unsigned(copy1_out_data) + 1);
        end loop;    
        --else
        --  report "Output not valid!";
        --end if;
        wait for 10 * clock_period;
        report "Test completed. Check waveform.";
        copy1_out_valid <= '0';
        
        report "Testbench completed.";
        --if copy1_out_valid = '1' then
        --   copy1_out_ready <= '0';
        --   report "Test completed. Check waveform.";
        --else
        --    report "Output not valid!";
        --end if;
        
    end process;

end architecture;
