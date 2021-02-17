library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity copy1 is
    generic (
        copy1_ram_width : natural;
        copy1_ram_depth : natural
        );
    port (
        clk : in std_logic;
        rst : in std_logic;
        copy1_in : in std_logic_vector(copy1_ram_width - 1 downto 0);
        copy1_out : out std_logic_vector(copy1_ram_width - 1 downto 0);

        copy1_in_ready : out std_logic;
        copy1_in_valid : in std_logic;

        copy1_out_ready : in std_logic;
        copy1_out_valid : out std_logic
    );
end;

architecture copy1_arch of copy1 is

    component entity_node is
        port (
            in_opening : in std_logic_vector(copy1_ram_width - 1 downto 0);
            out_opening : out std_logic_vector(copy1_ram_width - 1 downto 0)
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
            in_data : in std_logic_vector(copy1_ram_width - 1 downto 0);

            out_ready : in std_logic;
            out_valid : out std_logic;
            out_data : out std_logic_vector(copy1_ram_width - 1 downto 0)
        ); end component;

    --component exit_node is
    --    Port (
    --        in2 : in std_logic_vector(copy1_ram_width - 1 downto 0);
    --        out2 : out std_logic_vector(copy1_ram_width - 1 downto 0)
    --    ); end component;

    signal node_to_buffer, buffer_to_node : std_logic_vector(copy1_ram_width - 1 downto 0);

    begin

        entry_node : entity_node PORT MAP ( in_opening => copy1_in,
                                            out_opening => node_to_buffer
                                            );

        fifo : axi_fifo GENERIC MAP (copy1_ram_width => ram_width
                                                copy1_ram_depth => ram_depth,
                                                )
                                    port map    (clk => clk,
                                                rst => rst,
                                                in_ready => copy1_in_ready,
                                                in_valid =>  copy1_in_valid,
                                                in_data => node_to_buffer,

                                                out_ready => copy1_out_ready,
                                                out_valid => copy1_out_valid,
                                                out_data => buffer_to_node
                                                );

        exit_node : entity_node PORT MAP (  in_opening => buffer_to_node,
                                            out_opening => copy1_out
                                            );
        
end copy1_arch;