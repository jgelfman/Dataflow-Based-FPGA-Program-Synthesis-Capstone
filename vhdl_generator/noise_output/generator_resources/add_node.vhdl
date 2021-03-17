library ieee; 
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity add_node is 
port ( 
        add_clk : in std_logic; 
        add_rst : in std_logic; 


--Input0 
        add_in0_ready : in std_logic; 

        add_in0_valid : in std_logic; 

        add_in0_opening : in std_logic_vector; 


--Input1 
        add_in1_ready : in std_logic; 

        add_in1_valid : in std_logic; 

        add_in1_opening : in std_logic_vector; 


--Output 
        add_out_ready : out std_logic; 

        add_out_valid : out std_logic; 

        add_out_opening : out std_logic_vector 
    );  

end add_node; 

architecture noise_arch of add_node is 

    begin 

--PLACEHOLDER: Input1 propagated, Input 2 ignored 
    add_out_ready <= add_in1_ready; 
    add_out_valid <= add_in1_valid; 
    add_out_opening <= add_in1_opening; 

end architecture; 
