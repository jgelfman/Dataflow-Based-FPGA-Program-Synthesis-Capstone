library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity copy1 is
    generic (
        copy1_ram_width : natural;
        copy1_ram_depth : natural
        );
    port (
        copy1_clk : in std_logic;
        copy1_rst : in std_logic;

        copy1_in_ready : out std_logic;
        copy1_in_valid : in std_logic;
        copy1_in_data : in std_logic_vector;

        copy1_out_ready : in std_logic;
        copy1_out_valid : out std_logic;
        copy1_out_data : out std_logic_vector
    );
end;

architecture copy1_arch of copy1 is

    component entity_node is
        port (
            entity_clk : in std_logic;
            entity_rst : in std_logic;
            
            entity_in_ready : out std_logic;
            entity_out_ready : in std_logic;

            entity_in_valid : in std_logic;
            entity_out_valid : out std_logic;
            
            entity_in_opening : in std_logic_vector(copy1_ram_width - 1 downto 0);
            entity_out_opening : out std_logic_vector(copy1_ram_width - 1 downto 0)
        ); end component;

    component axi_fifo is
        generic (
            ram_width : natural;
            ram_depth : natural
        );
        Port (
            buf_clk : in std_logic;
            buf_rst : in std_logic;

            buf_in_ready : out std_logic;
            buf_in_valid : in std_logic;
            buf_in_data : in std_logic_vector(copy1_ram_width - 1 downto 0);

            buf_out_ready : in std_logic;
            buf_out_valid : out std_logic;
            buf_out_data : out std_logic_vector(copy1_ram_width - 1 downto 0)
        ); end component;

    signal node_to_buffer_data, buffer_to_node_data : std_logic_vector(copy1_ram_width - 1 downto 0);
    signal node_to_buffer_ready, node_to_buffer_valid, buffer_to_node_ready, buffer_to_node_valid : std_logic;

    begin

        entry_node : entity_node PORT MAP ( entity_clk => copy1_clk,
                                            entity_rst => copy1_rst,
                                            
                                            entity_in_ready => copy1_in_ready,
                                            entity_out_ready => node_to_buffer_ready,

                                            entity_in_valid => copy1_in_valid,
                                            entity_out_valid => node_to_buffer_valid,

                                            entity_in_opening => copy1_in_data,
                                            entity_out_opening => node_to_buffer_data
                                            );

        fifo : axi_fifo GENERIC MAP         (copy1_ram_width,
                                            copy1_ram_depth
                                            )
                                PORT MAP    (buf_clk => copy1_clk,
                                            buf_rst => copy1_rst,
                                            
                                            buf_in_ready => node_to_buffer_ready,
                                            buf_in_valid => node_to_buffer_valid,
                                            buf_in_data => node_to_buffer_data,
        
                                            buf_out_ready => buffer_to_node_ready,
                                            buf_out_valid => buffer_to_node_valid,
                                            buf_out_data => buffer_to_node_data
                                        );

        exit_node : entity_node PORT MAP (  entity_clk => copy1_clk,
                                            entity_rst => copy1_rst,
                                            
                                            entity_in_ready => buffer_to_node_ready,
                                            entity_out_ready => copy1_out_ready,
                                         
                                            entity_in_valid => buffer_to_node_valid,
                                            entity_out_valid => copy1_out_valid,
                                            
                                            entity_in_opening => buffer_to_node_data,
                                            entity_out_opening => copy1_out_data
                                            );

        
end copy1_arch;