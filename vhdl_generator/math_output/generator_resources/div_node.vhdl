library ieee; 
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity div_node is 
port ( 
        div_clk : in std_logic; 
        div_rst : in std_logic; 


--Input1 
        div_in1_ready : in std_logic; 

        div_in1_valid : in std_logic; 

        div_in1_opening : in std_logic_vector; 


--Input2 
        div_in2_ready : in std_logic; 

        div_in2_valid : in std_logic; 

        div_in2_opening : in std_logic_vector; 


--Output 
        div_out_ready : out std_logic; 

        div_out_valid : out std_logic; 

        div_out_opening : out std_logic_vector 
    );  

end div_node; 

architecture math_arch of div_node is 

    begin 

--PLACEHOLDER: Input1 propagated, Input 2 ignored 
    div_out_ready <= div_in1_ready; 
    div_out_valid <= div_in1_valid; 
    div_out_opening <= div_in1_opening; 

end architecture; 
