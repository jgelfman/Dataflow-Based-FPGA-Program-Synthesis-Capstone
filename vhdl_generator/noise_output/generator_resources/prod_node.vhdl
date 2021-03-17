library ieee; 
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity prod_node is 
port ( 
        prod_clk : in std_logic; 
        prod_rst : in std_logic; 


--Input1 
        prod_in1_ready : in std_logic; 

        prod_in1_valid : in std_logic; 

        prod_in1_opening : in std_logic_vector; 


--Input2 
        prod_in2_ready : in std_logic; 

        prod_in2_valid : in std_logic; 

        prod_in2_opening : in std_logic_vector; 


--Output 
        prod_out_ready : out std_logic; 

        prod_out_valid : out std_logic; 

        prod_out_opening : out std_logic_vector 
    );  

end prod_node; 

architecture noise_arch of prod_node is 

    begin 

--PLACEHOLDER: Input1 propagated, Input 2 ignored    prod_out_ready <= prod_in1_ready; 
    prod_out_valid <= prod_in1_valid; 
    prod_out_opening <= prod_in1_opening; 

end architecture; 
