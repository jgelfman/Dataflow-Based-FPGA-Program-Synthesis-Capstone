library ieee; 
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity entity_node is 
port ( 
        entity_clk : in std_logic; 
        entity_rst : in std_logic; 

        entity_in_ready : in std_logic; 
        entity_out_ready : out std_logic; 

        entity_in_valid : in std_logic; 
        entity_out_valid : out std_logic; 

        entity_in_opening : in std_logic_vector; 
        entity_out_opening : out std_logic_vector 
    );  

end entity_node; 

architecture math_arch of entity_node is 

    begin 

    entity_out_ready <= entity_in_ready; 
    entity_out_valid <= entity_in_valid; 
    entity_out_opening <= entity_in_opening; 

end architecture; 
