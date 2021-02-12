library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity entity_node is
    generic (
    ram_width : natural;
    ram_depth : natural
    );

    port (
        --inner_clk : in std_logic;
        --inner_rst : in std_logic;

        in_opening : in std_logic_vector(ram_width - 1 downto 0);
        out_opening : out std_logic_vector(ram_width - 1 downto 0)
    );
        
end entity_node;


architecture entity_node_arch of entity_node is

    begin

        out_opening <= in_opening;

    end architecture;