library ieee; 
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity prod is
    generic ( 
        prod_ram_width : natural; 
        prod_ram_depth : natural 
); 
    port ( 
        prod_clk : in std_logic; 
        prod_rst : in std_logic; 
 
        prod_in_ready : in std_logic; 
        prod_in_valid : in std_logic; 
        prod_in_data : in std_logic_vector; 
 
        prod_out_ready : out std_logic; 
        prod_out_valid : out std_logic; 
        prod_out_data : out std_logic_vector 
    ); 
end; 
 
architecture math_arch of prod is 
    component prod is 
        port ( 

            entity_clk : in std_logic; 
            entity_rst : in std_logic; 


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


 signal channel_0_real_vect_from_0x7fbf3be00080_to_buffer, channel_0_real_vect_from_buffer_to_in_channel_0_real_vect_data, channel_10_real_vect_from_0x7fbf3be00580_to_buffer, channel_10_real_vect_from_buffer_to_in_channel_10_real_vect_data, channel_11_real_vect_from_0x7fbf3be006f0_to_buffer, channel_11_real_vect_from_buffer_to_in_channel_11_real_vect_data, channel_12_real_vect_from_0x7fbf3be01fd0_to_buffer, channel_12_real_vect_from_buffer_to_in_channel_12_real_vect_data, channel_13_real_vect_from_0x7fbf3be029a0_to_buffer, channel_13_real_vect_from_buffer_to_in_channel_13_real_vect_data, channel_14_real_vect_from_0x7fbf3be02d20_to_buffer, channel_14_real_vect_from_buffer_to_in_channel_14_real_vect_data, channel_1_real_vect_from_0x7fbf3be00140_to_buffer, channel_1_real_vect_from_buffer_to_in_channel_1_real_vect_data, channel_2_real_vect_from_0x7fbf3be012c0_to_buffer, channel_2_real_vect_from_buffer_to_in_channel_2_real_vect_data, channel_3_real_vect_from_0x7fbf3be001d0_to_buffer, channel_3_real_vect_from_buffer_to_in_channel_3_real_vect_data, channel_4_real_vect_from_0x7fbf3be00290_to_buffer, channel_4_real_vect_from_buffer_to_in_channel_4_real_vect_data, channel_5_real_vect_from_0x7fbf3be017f0_to_buffer, channel_5_real_vect_from_buffer_to_in_channel_5_real_vect_data, channel_6_real_vect_from_0x7fbf3be02710_to_buffer, channel_6_real_vect_from_buffer_to_in_channel_6_real_vect_data, channel_7_real_vect_from_0x7fbf3be00350_to_buffer, channel_7_real_vect_from_buffer_to_in_channel_7_real_vect_data, channel_8_real_vect_from_0x7fbf3be004c0_to_buffer, channel_8_real_vect_from_buffer_to_in_channel_8_real_vect_data, channel_9_real_vect_from_0x7fbf3be01d10_to_buffer, channel_9_real_vect_from_buffer_to_in_channel_9_real_vect_data : std_logic_vector(copy1_ram_width - 1 downto 0); 
signal channel_0_real_vect_from_0x7fbf3be00080_to_buffer_ready, channel_0_real_vect_from_buffer_to_in_channel_0_real_vect_ready, channel_0_real_vect_from_0x7fbf3be00080_to_buffer_valid, channel_0_real_vect_from_buffer_to_in_channel_0_real_vect_valid, channel_10_real_vect_from_0x7fbf3be00580_to_buffer_ready, channel_10_real_vect_from_buffer_to_in_channel_10_real_vect_ready, channel_10_real_vect_from_0x7fbf3be00580_to_buffer_valid, channel_10_real_vect_from_buffer_to_in_channel_10_real_vect_valid, channel_11_real_vect_from_0x7fbf3be006f0_to_buffer_ready, channel_11_real_vect_from_buffer_to_in_channel_11_real_vect_ready, channel_11_real_vect_from_0x7fbf3be006f0_to_buffer_valid, channel_11_real_vect_from_buffer_to_in_channel_11_real_vect_valid, channel_12_real_vect_from_0x7fbf3be01fd0_to_buffer_ready, channel_12_real_vect_from_buffer_to_in_channel_12_real_vect_ready, channel_12_real_vect_from_0x7fbf3be01fd0_to_buffer_valid, channel_12_real_vect_from_buffer_to_in_channel_12_real_vect_valid, channel_13_real_vect_from_0x7fbf3be029a0_to_buffer_ready, channel_13_real_vect_from_buffer_to_in_channel_13_real_vect_ready, channel_13_real_vect_from_0x7fbf3be029a0_to_buffer_valid, channel_13_real_vect_from_buffer_to_in_channel_13_real_vect_valid, channel_14_real_vect_from_0x7fbf3be02d20_to_buffer_ready, channel_14_real_vect_from_buffer_to_in_channel_14_real_vect_ready, channel_14_real_vect_from_0x7fbf3be02d20_to_buffer_valid, channel_14_real_vect_from_buffer_to_in_channel_14_real_vect_valid, channel_1_real_vect_from_0x7fbf3be00140_to_buffer_ready, channel_1_real_vect_from_buffer_to_in_channel_1_real_vect_ready, channel_1_real_vect_from_0x7fbf3be00140_to_buffer_valid, channel_1_real_vect_from_buffer_to_in_channel_1_real_vect_valid, channel_2_real_vect_from_0x7fbf3be012c0_to_buffer_ready, channel_2_real_vect_from_buffer_to_in_channel_2_real_vect_ready, channel_2_real_vect_from_0x7fbf3be012c0_to_buffer_valid, channel_2_real_vect_from_buffer_to_in_channel_2_real_vect_valid, channel_3_real_vect_from_0x7fbf3be001d0_to_buffer_ready, channel_3_real_vect_from_buffer_to_in_channel_3_real_vect_ready, channel_3_real_vect_from_0x7fbf3be001d0_to_buffer_valid, channel_3_real_vect_from_buffer_to_in_channel_3_real_vect_valid, channel_4_real_vect_from_0x7fbf3be00290_to_buffer_ready, channel_4_real_vect_from_buffer_to_in_channel_4_real_vect_ready, channel_4_real_vect_from_0x7fbf3be00290_to_buffer_valid, channel_4_real_vect_from_buffer_to_in_channel_4_real_vect_valid, channel_5_real_vect_from_0x7fbf3be017f0_to_buffer_ready, channel_5_real_vect_from_buffer_to_in_channel_5_real_vect_ready, channel_5_real_vect_from_0x7fbf3be017f0_to_buffer_valid, channel_5_real_vect_from_buffer_to_in_channel_5_real_vect_valid, channel_6_real_vect_from_0x7fbf3be02710_to_buffer_ready, channel_6_real_vect_from_buffer_to_in_channel_6_real_vect_ready, channel_6_real_vect_from_0x7fbf3be02710_to_buffer_valid, channel_6_real_vect_from_buffer_to_in_channel_6_real_vect_valid, channel_7_real_vect_from_0x7fbf3be00350_to_buffer_ready, channel_7_real_vect_from_buffer_to_in_channel_7_real_vect_ready, channel_7_real_vect_from_0x7fbf3be00350_to_buffer_valid, channel_7_real_vect_from_buffer_to_in_channel_7_real_vect_valid, channel_8_real_vect_from_0x7fbf3be004c0_to_buffer_ready, channel_8_real_vect_from_buffer_to_in_channel_8_real_vect_ready, channel_8_real_vect_from_0x7fbf3be004c0_to_buffer_valid, channel_8_real_vect_from_buffer_to_in_channel_8_real_vect_valid, channel_9_real_vect_from_0x7fbf3be01d10_to_buffer_ready, channel_9_real_vect_from_buffer_to_in_channel_9_real_vect_ready, channel_9_real_vect_from_0x7fbf3be01d10_to_buffer_valid, channel_9_real_vect_from_buffer_to_in_channel_9_real_vect_valid : std_logic; 


begin 

prod_1 : entity_node PORT MAP (           entity_clk => prod_clk, 
                                            entity_rst => prod_rst, 

                                            entity_in_ready => channel_8_real_vect_from_buffer_to_in_channel_8_real_vect_ready, 
                                            entity_out_ready => channel_8_real_vect_from_0x7fbf3be004c0_to_buffer_ready, 

                                            entity_in_valid => channel_8_real_vect_from_buffer_to_in_channel_8_real_vect_valid, 
                                            entity_out_valid => channel_8_real_vect_from_0x7fbf3be004c0_to_buffer_valid, 

                                            entity_in_opening => channel_8_real_vect_from_buffer_to_in_channel_8_real_vect_data, 
                                            entity_out_opening => channel_8_real_vect_from_0x7fbf3be004c0_to_buffer, 

); 

fifo_15 : axi_fifo GENERIC MAP       (prod_ram_width, 
                                    prod_ram_depth 
                                    ) 
                    PORT MAP        (buf_clk => prod_clk, 
                                    buf_rst => prod_rst, 

                                    buf_in_ready => channel_9_real_vect_from_0x7fbf3be01d10_to_buffer_ready, 
                                    buf_out_ready => channel_9_real_vect_from_buffer_to_in_channel_9_real_vect_ready, 

                                    buf_in_valid => channel_9_real_vect_from_0x7fbf3be01d10_to_buffer_valid, 
                                    buf_out_valid => channel_9_real_vect_from_buffer_to_in_channel_9_real_vect_valid, 

                                    buf_in_data => channel_9_real_vect_from_0x7fbf3be01d10_to_buffer, 
                                    buf_out_data => channel_9_real_vect_from_buffer_to_in_channel_9_real_vect_data 
); 


 end math_arch; 
