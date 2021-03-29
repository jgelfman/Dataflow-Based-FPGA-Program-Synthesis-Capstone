library ieee; 
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity input_node is 
port ( 
        input_clk : in std_logic; 
        input_rst : in std_logic; 

        input_in_ready : out std_logic; 
        input_out_ready : in std_logic; 

        input_in_valid : in std_logic; 
        input_out_valid : out std_logic; 

        input_in_opening : in std_logic_vector; 
        input_out_opening : out std_logic_vector 
    );  

end input_node; 

architecture copy1_arch of input_node is 

    begin 

    input_in_ready <= input_out_ready; 
    input_out_valid <= input_in_valid; 
    input_out_opening <= input_in_opening; 

end architecture; 
