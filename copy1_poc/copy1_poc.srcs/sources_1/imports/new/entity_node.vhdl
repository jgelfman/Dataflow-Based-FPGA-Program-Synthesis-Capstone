library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity entity_node is
   port (
        entity_clk : in std_logic;
        entity_rst : in std_logic;

        entity_in_ready : out std_logic;
        entity_out_ready : in std_logic;
        
        entity_in_opening : in std_logic_vector;
        entity_out_opening : out std_logic_vector
    ); 
        
end entity_node;


architecture copy1_arch of entity_node is

    begin
        
        entity_out_opening <= entity_in_opening;
        --entity_out_ready => entity_in_ready;

    end architecture;