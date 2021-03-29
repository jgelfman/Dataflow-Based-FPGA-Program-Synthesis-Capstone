library ieee; 
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity output_node is 
port ( 
        output_clk : in std_logic; 
        output_rst : in std_logic; 

        output_in_ready : out std_logic; 
        output_out_ready : in std_logic; 

        output_in_valid : in std_logic; 
        output_out_valid : out std_logic; 

        output_in_opening : in std_logic_vector; 
        output_out_opening : out std_logic_vector 
    );  

end output_node; 

architecture math_arch of output_node is 

    begin 

    output_in_ready <= output_out_ready; 
    output_out_valid <= output_in_valid; 
    output_out_opening <= output_in_opening; 

end architecture; 
