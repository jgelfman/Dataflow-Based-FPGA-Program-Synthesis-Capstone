library ieee; 
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity OUTPUT is
    generic ( 
        OUTPUT_ram_width : natural; 
        OUTPUT_ram_depth : natural 
); 
    port ( 
        OUTPUT_clk : in std_logic; 
        OUTPUT_rst : in std_logic; 
 
        OUTPUT_in_ready : in std_logic; 
        OUTPUT_in_valid : in std_logic; 
        OUTPUT_in_data : in std_logic_vector; 
 
        OUTPUT_out_ready : out std_logic; 
        OUTPUT_out_valid : out std_logic; 
        OUTPUT_out_data : out std_logic_vector 
    ); 
end; 
 
architecture copy1_arch of OUTPUT is 
    component OUTPUT is 
        port ( 

            entity_clk : in std_logic; 
            entity_rst : in std_logic; 

            entity_in_ready : in std_logic; 
            entity_out_ready : out std_logic; 

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
signal channel_0_real_vect_from_0x7f5f30004250_to_buffer, channel_0_real_vect_from_buffer_to_in_channel_0_real_vect_data : std_logic_vector(copy1_ram_width - 1 downto 0); 
signal channel_0_real_vect_from_0x7f5f30004250_to_buffer_ready, channel_0_real_vect_from_buffer_to_in_channel_0_real_vect_ready, channel_0_real_vect_from_0x7f5f30004250_to_buffer_valid, channel_0_real_vect_from_buffer_to_in_channel_0_real_vect_valid : std_logic; 


begin 

OUTPUT_0 : entity_node PORT MAP (           entity_clk => OUTPUT_clk, 
                                            entity_rst => OUTPUT_rst, 

                                            entity_in_ready => OUTPUT_in_ready, 
                                            entity_out_ready => channel_0_real_vect_from_0x7f5f30004250_to_buffer_ready, 

                                            entity_in_valid => OUTPUT_in_valid, 
                                            entity_out_valid => channel_0_real_vect_from_0x7f5f30004250_to_buffer_valid, 

                                            entity_in_opening => OUTPUT_in_data, 
                                            entity_out_opening => OUTPUT_out_data 
); 


 end copy1_arch; 
