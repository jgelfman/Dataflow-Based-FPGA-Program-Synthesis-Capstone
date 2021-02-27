library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity copy1_wrapper is
end copy1_wrapper;

architecture copy1_arch of copy1_wrapper is

  -- testbench constants
  constant clock_period : time := 10 ns;
  constant copy1_ram_width : natural := 16;
  constant copy1_ram_depth : natural := 256;

  -- signals
  signal clk : std_logic := '1';
  signal rst : std_logic := '1';
  signal copy1_in_ready : std_logic;
  signal copy1_in_valid : std_logic := '0';
  signal copy1_in : std_logic_vector(copy1_ram_width - 1 downto 0) := (others => '0');
  signal copy1_out : std_logic_vector(copy1_ram_width - 1 downto 0) := (others => '0');
  signal copy1_out_ready : std_logic := '0';
  signal copy1_out_valid : std_logic;

  component copy1 is
      generic (
          copy1_ram_width : natural;
          copy1_ram_depth : natural
          );
      port (
          copy1_clk : in std_logic;
          copy1_rst : in std_logic;
          copy1_in : in std_logic_vector(copy1_ram_width - 1 downto 0);
          copy1_out : out std_logic_vector(copy1_ram_width - 1 downto 0);

          copy1_in_ready : out std_logic;
          copy1_in_valid : in std_logic;

          copy1_out_ready : in std_logic;
          copy1_out_valid : out std_logic
      ); end component;

begin

  clk <= not clk after clock_period / 2;

  copy : copy1 GENERIC MAP   (copy1_ram_width,
                              copy1_ram_depth
                              )
                  PORT MAP    (
                              copy1_clk => clk,
                              copy1_rst => rst,
                              copy1_in => copy1_in,
                              copy1_out => copy1_out,
    
                              copy1_in_ready => copy1_in_ready,
                              copy1_in_valid => copy1_in_valid,
    
                              copy1_out_ready => copy1_out_ready,
                              copy1_out_valid => copy1_out_valid
                              );
    
    proc_sequencer : process is
    begin
    
        wait for 10 * clock_period;
        rst <= '0';
        wait until rising_edge(clk);

        report "Starting to write into input node..."; -- write until full
        if copy1_in_ready = '1' then
                copy1_in_valid <= '1';
                copy1_in <= std_logic_vector(unsigned(copy1_in) + 1);      
        else 
            report "Not ready!";
            std.env.finish;
         end if;
        wait for 10 * clock_period;
        copy1_in_valid <= '0';

        --copy1_in <= (others => 'X');


        report "Reading from the output node..."; -- read until empty
        copy1_out_ready <= '1';
        
        wait for 10 * clock_period;
        
        if copy1_out_valid = '1' then
           copy1_out_ready <= '0';
           report "Test completed. Check waveform.";
        else
            report "Output not valid!";
        end if;
        
    end process;

end architecture;
