library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity copy1 is
    generic (
    copy1_ram_width : natural;
    copy1_ram_depth : natural
    );
    port (
        copy1_in : in std_logic_vector(copy1_ram_width - 1 downto 0);
        copy1_out : out std_logic_vector(copy1_ram_width - 1 downto 0);

        copy1_in_ready : out std_logic;
        copy1_in_valid : in std_logic;

        copy1_out_ready : in std_logic;
        copy1_out_valid : out std_logic
    );
end;

architecture copy1_arch of copy1 is

    signal in1, out1, out_data, out2 : std_logic;

    component entry_node is
        Port (
            in1 : in std_logic_vector(ram_width - 1 downto 0);
            out1 : out std_logic_vector(ram_width - 1 downto 0)
        ); end component;

    component axi_fifo is
        generic (
            ram_width : natural;
            ram_depth : natural
        );
        Port (
            clk : in std_logic;
            rst : in std_logic;

            in_ready : out std_logic;
            in_valid : in std_logic;
            in_data : in std_logic_vector(ram_width - 1 downto 0);

            out_ready : in std_logic;
            out_valid : out std_logic;
            out_data : out std_logic_vector(ram_width - 1 downto 0)
        ); end component;

    component exit_node is
        Port (
            in2 : in std_logic_vector(ram_width - 1 downto 0);
            out2 : out std_logic_vector(ram_width - 1 downto 0)
        ); end component;


    begin

        entry_node : entity_node PORT MAP ( copy1_in  => in1,
                                            out1 => out1
                                            );

        axi_fifo : axi_fifo GENERIC MAP (   copy1_ram_width => ram_width,
                                            copy1_ram_depth => ram_depth
                                            )
                            PORT MAP (      clk => clk,
                                            rst => rst,

                                            copy1_in_ready => in_ready,
                                            copy1_in_valid => in_valid,
                                            out1 => in_data,

                                            out_ready => copy1_out_ready,
                                            out_valid => copy1_out_valid,
                                            out_data => out_data
                                            );

        exit_node : entity_node PORT MAP (  out_data => in2,
                                            out2 => copy1_out
                                            );

end copy1_arch;