library ieee; 
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity math is
    generic ( 
        math_ram_width : natural; 
        math_ram_depth : natural 
); 
    port ( 
        math_clk : in std_logic; 
        math_rst : in std_logic; 
 
        math_in0_ready : in std_logic; 
        math_in0_valid : in std_logic; 
        math_in0_data : in std_logic_vector; 
 
        math_in1_ready : in std_logic; 
        math_in1_valid : in std_logic; 
        math_in1_data : in std_logic_vector; 
 
        math_in2_ready : in std_logic; 
        math_in2_valid : in std_logic; 
        math_in2_data : in std_logic_vector; 
 
        math_in3_ready : in std_logic; 
        math_in3_valid : in std_logic; 
        math_in3_data : in std_logic_vector; 
 
        math_in4_ready : in std_logic; 
        math_in4_valid : in std_logic; 
        math_in4_data : in std_logic_vector; 
 
        math_in5_ready : in std_logic; 
        math_in5_valid : in std_logic; 
        math_in5_data : in std_logic_vector; 
 
        math_in6_ready : in std_logic; 
        math_in6_valid : in std_logic; 
        math_in6_data : in std_logic_vector; 
 
        math_in7_ready : in std_logic; 
        math_in7_valid : in std_logic; 
        math_in7_data : in std_logic_vector; 
 
        math_out0_ready : out std_logic; 
        math_out0_valid : out std_logic; 
        math_out0_data : out std_logic_vector 
    ); 
end; 
 
architecture math_arch of math is 


    component INPUT_node is 
        port ( 

            INPUT_clk : in std_logic; 
            INPUT_rst : in std_logic; 


            input_in_ready : in std_logic; 
            input_out_ready : out std_logic; 

            input_in_valid : in std_logic; 
            input_out_valid : out std_logic; 

            input_in_opening : in std_logic_vector(math_ram_width - 1 downto 0); 
            input_out_opening : out std_logic_vector(math_ram_width - 1 downto 0) 
    ); end component; 

    component add_node is 
        port ( 

            add_clk : in std_logic; 
            add_rst : in std_logic; 

            --Input1 
            add_in1_ready : in std_logic; 

            add_in1_valid : in std_logic; 

            add_in1_opening : in std_logic_vector(math_ram_width - 1 downto 0); 


            --Input2 
            add_in2_ready : in std_logic; 

            add_in2_valid : in std_logic; 

            add_in2_opening : in std_logic_vector(math_ram_width - 1 downto 0); 


            --Output 
            add_out_ready : out std_logic; 

            add_out_valid : out std_logic; 

            add_out_opening : out std_logic_vector(math_ram_width - 1 downto 0) 
    ); end component; 

    component prod_node is 
        port ( 

            prod_clk : in std_logic; 
            prod_rst : in std_logic; 

            --Input1 
            prod_in1_ready : in std_logic; 

            prod_in1_valid : in std_logic; 

            prod_in1_opening : in std_logic_vector(math_ram_width - 1 downto 0); 


            --Input2 
            prod_in2_ready : in std_logic; 

            prod_in2_valid : in std_logic; 

            prod_in2_opening : in std_logic_vector(math_ram_width - 1 downto 0); 


            --Output 
            prod_out_ready : out std_logic; 

            prod_out_valid : out std_logic; 

            prod_out_opening : out std_logic_vector(math_ram_width - 1 downto 0) 
    ); end component; 

    component div_node is 
        port ( 

            div_clk : in std_logic; 
            div_rst : in std_logic; 

            --Input1 
            div_in1_ready : in std_logic; 

            div_in1_valid : in std_logic; 

            div_in1_opening : in std_logic_vector(math_ram_width - 1 downto 0); 


            --Input2 
            div_in2_ready : in std_logic; 

            div_in2_valid : in std_logic; 

            div_in2_opening : in std_logic_vector(math_ram_width - 1 downto 0); 


            --Output 
            div_out_ready : out std_logic; 

            div_out_valid : out std_logic; 

            div_out_opening : out std_logic_vector(math_ram_width - 1 downto 0) 
    ); end component; 

    component OUTPUT_node is 
        port ( 

            OUTPUT_clk : in std_logic; 
            OUTPUT_rst : in std_logic; 


            output_in_ready : in std_logic; 
            output_out_ready : out std_logic; 

            output_in_valid : in std_logic; 
            output_out_valid : out std_logic; 

            output_in_opening : in std_logic_vector(math_ram_width - 1 downto 0); 
            output_out_opening : out std_logic_vector(math_ram_width - 1 downto 0) 
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
            buf_in_data : in std_logic_vector(math_ram_width - 1 downto 0); 
 
            buf_out_ready : in std_logic; 
            buf_out_valid : out std_logic; 
            buf_out_data : out std_logic_vector(math_ram_width - 1 downto 0) 
        ); end component;


 signal channel_0_real_vect-FROM-0x7fbf3be00080-TO_BUFFER-DATA, channel_0_real_vect-FROM_BUFFER_TO-0x7fbf3be012c0-DATA, channel_10_real_vect-FROM-0x7fbf3be00580-TO_BUFFER-DATA, channel_10_real_vect-FROM_BUFFER_TO-0x7fbf3be01fd0-DATA, channel_11_real_vect-FROM-0x7fbf3be006f0-TO_BUFFER-DATA, channel_11_real_vect-FROM_BUFFER_TO-0x7fbf3be01fd0-DATA, channel_12_real_vect-FROM-0x7fbf3be01fd0-TO_BUFFER-DATA, channel_12_real_vect-FROM_BUFFER_TO-0x7fbf3be029a0-DATA, channel_13_real_vect-FROM-0x7fbf3be029a0-TO_BUFFER-DATA, channel_13_real_vect-FROM_BUFFER_TO-0x7fbf3be02d20-DATA, channel_14_real_vect-FROM-0x7fbf3be02d20-TO_BUFFER-DATA, channel_14_real_vect-FROM_BUFFER_TO-OUTPUT_0-DATA, channel_1_real_vect-FROM-0x7fbf3be00140-TO_BUFFER-DATA, channel_1_real_vect-FROM_BUFFER_TO-0x7fbf3be012c0-DATA, channel_2_real_vect-FROM-0x7fbf3be012c0-TO_BUFFER-DATA, channel_2_real_vect-FROM_BUFFER_TO-0x7fbf3be02710-DATA, channel_3_real_vect-FROM-0x7fbf3be001d0-TO_BUFFER-DATA, channel_3_real_vect-FROM_BUFFER_TO-0x7fbf3be017f0-DATA, channel_4_real_vect-FROM-0x7fbf3be00290-TO_BUFFER-DATA, channel_4_real_vect-FROM_BUFFER_TO-0x7fbf3be017f0-DATA, channel_5_real_vect-FROM-0x7fbf3be017f0-TO_BUFFER-DATA, channel_5_real_vect-FROM_BUFFER_TO-0x7fbf3be02710-DATA, channel_6_real_vect-FROM-0x7fbf3be02710-TO_BUFFER-DATA, channel_6_real_vect-FROM_BUFFER_TO-0x7fbf3be02d20-DATA, channel_7_real_vect-FROM-0x7fbf3be00350-TO_BUFFER-DATA, channel_7_real_vect-FROM_BUFFER_TO-0x7fbf3be01d10-DATA, channel_8_real_vect-FROM-0x7fbf3be004c0-TO_BUFFER-DATA, channel_8_real_vect-FROM_BUFFER_TO-0x7fbf3be01d10-DATA, channel_9_real_vect-FROM-0x7fbf3be01d10-TO_BUFFER-DATA, channel_9_real_vect-FROM_BUFFER_TO-0x7fbf3be029a0-DATA : std_logic_vector(math_ram_width - 1 downto 0); 
signal channel_0_real_vect-FROM-0x7fbf3be00080-TO_BUFFER-READY, channel_0_real_vect-FROM_BUFFER_TO-0x7fbf3be012c0-READY, channel_0_real_vect-FROM-0x7fbf3be00080-TO_BUFFER-VALID, channel_0_real_vect-FROM_BUFFER_TO-0x7fbf3be012c0-VALID, channel_10_real_vect-FROM-0x7fbf3be00580-TO_BUFFER-READY, channel_10_real_vect-FROM_BUFFER_TO-0x7fbf3be01fd0-READY, channel_10_real_vect-FROM-0x7fbf3be00580-TO_BUFFER-VALID, channel_10_real_vect-FROM_BUFFER_TO-0x7fbf3be01fd0-VALID, channel_11_real_vect-FROM-0x7fbf3be006f0-TO_BUFFER-READY, channel_11_real_vect-FROM_BUFFER_TO-0x7fbf3be01fd0-READY, channel_11_real_vect-FROM-0x7fbf3be006f0-TO_BUFFER-VALID, channel_11_real_vect-FROM_BUFFER_TO-0x7fbf3be01fd0-VALID, channel_12_real_vect-FROM-0x7fbf3be01fd0-TO_BUFFER-READY, channel_12_real_vect-FROM_BUFFER_TO-0x7fbf3be029a0-READY, channel_12_real_vect-FROM-0x7fbf3be01fd0-TO_BUFFER-VALID, channel_12_real_vect-FROM_BUFFER_TO-0x7fbf3be029a0-VALID, channel_13_real_vect-FROM-0x7fbf3be029a0-TO_BUFFER-READY, channel_13_real_vect-FROM_BUFFER_TO-0x7fbf3be02d20-READY, channel_13_real_vect-FROM-0x7fbf3be029a0-TO_BUFFER-VALID, channel_13_real_vect-FROM_BUFFER_TO-0x7fbf3be02d20-VALID, channel_14_real_vect-FROM-0x7fbf3be02d20-TO_BUFFER-READY, channel_14_real_vect-FROM_BUFFER_TO-OUTPUT_0-READY, channel_14_real_vect-FROM-0x7fbf3be02d20-TO_BUFFER-VALID, channel_14_real_vect-FROM_BUFFER_TO-OUTPUT_0-VALID, channel_1_real_vect-FROM-0x7fbf3be00140-TO_BUFFER-READY, channel_1_real_vect-FROM_BUFFER_TO-0x7fbf3be012c0-READY, channel_1_real_vect-FROM-0x7fbf3be00140-TO_BUFFER-VALID, channel_1_real_vect-FROM_BUFFER_TO-0x7fbf3be012c0-VALID, channel_2_real_vect-FROM-0x7fbf3be012c0-TO_BUFFER-READY, channel_2_real_vect-FROM_BUFFER_TO-0x7fbf3be02710-READY, channel_2_real_vect-FROM-0x7fbf3be012c0-TO_BUFFER-VALID, channel_2_real_vect-FROM_BUFFER_TO-0x7fbf3be02710-VALID, channel_3_real_vect-FROM-0x7fbf3be001d0-TO_BUFFER-READY, channel_3_real_vect-FROM_BUFFER_TO-0x7fbf3be017f0-READY, channel_3_real_vect-FROM-0x7fbf3be001d0-TO_BUFFER-VALID, channel_3_real_vect-FROM_BUFFER_TO-0x7fbf3be017f0-VALID, channel_4_real_vect-FROM-0x7fbf3be00290-TO_BUFFER-READY, channel_4_real_vect-FROM_BUFFER_TO-0x7fbf3be017f0-READY, channel_4_real_vect-FROM-0x7fbf3be00290-TO_BUFFER-VALID, channel_4_real_vect-FROM_BUFFER_TO-0x7fbf3be017f0-VALID, channel_5_real_vect-FROM-0x7fbf3be017f0-TO_BUFFER-READY, channel_5_real_vect-FROM_BUFFER_TO-0x7fbf3be02710-READY, channel_5_real_vect-FROM-0x7fbf3be017f0-TO_BUFFER-VALID, channel_5_real_vect-FROM_BUFFER_TO-0x7fbf3be02710-VALID, channel_6_real_vect-FROM-0x7fbf3be02710-TO_BUFFER-READY, channel_6_real_vect-FROM_BUFFER_TO-0x7fbf3be02d20-READY, channel_6_real_vect-FROM-0x7fbf3be02710-TO_BUFFER-VALID, channel_6_real_vect-FROM_BUFFER_TO-0x7fbf3be02d20-VALID, channel_7_real_vect-FROM-0x7fbf3be00350-TO_BUFFER-READY, channel_7_real_vect-FROM_BUFFER_TO-0x7fbf3be01d10-READY, channel_7_real_vect-FROM-0x7fbf3be00350-TO_BUFFER-VALID, channel_7_real_vect-FROM_BUFFER_TO-0x7fbf3be01d10-VALID, channel_8_real_vect-FROM-0x7fbf3be004c0-TO_BUFFER-READY, channel_8_real_vect-FROM_BUFFER_TO-0x7fbf3be01d10-READY, channel_8_real_vect-FROM-0x7fbf3be004c0-TO_BUFFER-VALID, channel_8_real_vect-FROM_BUFFER_TO-0x7fbf3be01d10-VALID, channel_9_real_vect-FROM-0x7fbf3be01d10-TO_BUFFER-READY, channel_9_real_vect-FROM_BUFFER_TO-0x7fbf3be029a0-READY, channel_9_real_vect-FROM-0x7fbf3be01d10-TO_BUFFER-VALID, channel_9_real_vect-FROM_BUFFER_TO-0x7fbf3be029a0-VALID : std_logic; 


begin 

INPUT_0 : INPUT_node PORT MAP (         INPUT_clk => math_clk, 
                                        INPUT_rst => math_rst, 

                                        INPUT_in0_ready => math_0_in_ready, 
                                        math_out_ready => channel_0_real_vect-FROM-0x7fbf3be00080-TO_BUFFER-READY, 

                                        INPUT_in0_valid => math_0_in_valid, 
                                        math_out_valid => channel_0_real_vect-FROM-0x7fbf3be00080-TO_BUFFER-VALID, 

                                        INPUT_in0_opening => math_0_in_data, 
                                        math_out_opening => channel_0_real_vect-FROM-0x7fbf3be00080-TO_BUFFER-DATA 
); 

fifo_0 : axi_fifo GENERIC MAP       (math_ram_width, 
                                    math_ram_depth 
                                    ) 
                    PORT MAP        (buf_clk => math_clk, 
                                    buf_rst => math_rst, 

                                    buf_in_ready => channel_0_real_vect-FROM-0x7fbf3be00080-TO_BUFFER-READY, 
                                    buf_out_ready => channel_0_real_vect-FROM_BUFFER_TO-0x7fbf3be012c0-READY, 

                                    buf_in_valid => channel_0_real_vect-FROM-0x7fbf3be00080-TO_BUFFER-VALID, 
                                    buf_out_valid => channel_0_real_vect-FROM_BUFFER_TO-0x7fbf3be012c0-VALID, 

                                    buf_in_data => channel_0_real_vect-FROM-0x7fbf3be00080-TO_BUFFER-DATA, 
                                    buf_out_data => channel_0_real_vect-FROM_BUFFER_TO-0x7fbf3be012c0-DATA 
); 

INPUT_1 : INPUT_node PORT MAP (         INPUT_clk => math_clk, 
                                        INPUT_rst => math_rst, 

                                        INPUT_in1_ready => math_1_in_ready, 
                                        math_out_ready => channel_1_real_vect-FROM-0x7fbf3be00140-TO_BUFFER-READY, 

                                        INPUT_in1_valid => math_1_in_valid, 
                                        math_out_valid => channel_1_real_vect-FROM-0x7fbf3be00140-TO_BUFFER-VALID, 

                                        INPUT_in1_opening => math_1_in_data, 
                                        math_out_opening => channel_1_real_vect-FROM-0x7fbf3be00140-TO_BUFFER-DATA 
); 

fifo_1 : axi_fifo GENERIC MAP       (math_ram_width, 
                                    math_ram_depth 
                                    ) 
                    PORT MAP        (buf_clk => math_clk, 
                                    buf_rst => math_rst, 

                                    buf_in_ready => channel_10_real_vect-FROM-0x7fbf3be00580-TO_BUFFER-READY, 
                                    buf_out_ready => channel_10_real_vect-FROM_BUFFER_TO-0x7fbf3be01fd0-READY, 

                                    buf_in_valid => channel_10_real_vect-FROM-0x7fbf3be00580-TO_BUFFER-VALID, 
                                    buf_out_valid => channel_10_real_vect-FROM_BUFFER_TO-0x7fbf3be01fd0-VALID, 

                                    buf_in_data => channel_10_real_vect-FROM-0x7fbf3be00580-TO_BUFFER-DATA, 
                                    buf_out_data => channel_10_real_vect-FROM_BUFFER_TO-0x7fbf3be01fd0-DATA 
); 

INPUT_2 : INPUT_node PORT MAP (         INPUT_clk => math_clk, 
                                        INPUT_rst => math_rst, 

                                        INPUT_in2_ready => math_2_in_ready, 
                                        math_out_ready => channel_3_real_vect-FROM-0x7fbf3be001d0-TO_BUFFER-READY, 

                                        INPUT_in2_valid => math_2_in_valid, 
                                        math_out_valid => channel_3_real_vect-FROM-0x7fbf3be001d0-TO_BUFFER-VALID, 

                                        INPUT_in2_opening => math_2_in_data, 
                                        math_out_opening => channel_3_real_vect-FROM-0x7fbf3be001d0-TO_BUFFER-DATA 
); 

fifo_2 : axi_fifo GENERIC MAP       (math_ram_width, 
                                    math_ram_depth 
                                    ) 
                    PORT MAP        (buf_clk => math_clk, 
                                    buf_rst => math_rst, 

                                    buf_in_ready => channel_11_real_vect-FROM-0x7fbf3be006f0-TO_BUFFER-READY, 
                                    buf_out_ready => channel_11_real_vect-FROM_BUFFER_TO-0x7fbf3be01fd0-READY, 

                                    buf_in_valid => channel_11_real_vect-FROM-0x7fbf3be006f0-TO_BUFFER-VALID, 
                                    buf_out_valid => channel_11_real_vect-FROM_BUFFER_TO-0x7fbf3be01fd0-VALID, 

                                    buf_in_data => channel_11_real_vect-FROM-0x7fbf3be006f0-TO_BUFFER-DATA, 
                                    buf_out_data => channel_11_real_vect-FROM_BUFFER_TO-0x7fbf3be01fd0-DATA 
); 

INPUT_3 : INPUT_node PORT MAP (         INPUT_clk => math_clk, 
                                        INPUT_rst => math_rst, 

                                        INPUT_in3_ready => math_3_in_ready, 
                                        math_out_ready => channel_4_real_vect-FROM-0x7fbf3be00290-TO_BUFFER-READY, 

                                        INPUT_in3_valid => math_3_in_valid, 
                                        math_out_valid => channel_4_real_vect-FROM-0x7fbf3be00290-TO_BUFFER-VALID, 

                                        INPUT_in3_opening => math_3_in_data, 
                                        math_out_opening => channel_4_real_vect-FROM-0x7fbf3be00290-TO_BUFFER-DATA 
); 

fifo_3 : axi_fifo GENERIC MAP       (math_ram_width, 
                                    math_ram_depth 
                                    ) 
                    PORT MAP        (buf_clk => math_clk, 
                                    buf_rst => math_rst, 

                                    buf_in_ready => channel_12_real_vect-FROM-0x7fbf3be01fd0-TO_BUFFER-READY, 
                                    buf_out_ready => channel_12_real_vect-FROM_BUFFER_TO-0x7fbf3be029a0-READY, 

                                    buf_in_valid => channel_12_real_vect-FROM-0x7fbf3be01fd0-TO_BUFFER-VALID, 
                                    buf_out_valid => channel_12_real_vect-FROM_BUFFER_TO-0x7fbf3be029a0-VALID, 

                                    buf_in_data => channel_12_real_vect-FROM-0x7fbf3be01fd0-TO_BUFFER-DATA, 
                                    buf_out_data => channel_12_real_vect-FROM_BUFFER_TO-0x7fbf3be029a0-DATA 
); 

INPUT_4 : INPUT_node PORT MAP (         INPUT_clk => math_clk, 
                                        INPUT_rst => math_rst, 

                                        INPUT_in4_ready => math_4_in_ready, 
                                        math_out_ready => channel_7_real_vect-FROM-0x7fbf3be00350-TO_BUFFER-READY, 

                                        INPUT_in4_valid => math_4_in_valid, 
                                        math_out_valid => channel_7_real_vect-FROM-0x7fbf3be00350-TO_BUFFER-VALID, 

                                        INPUT_in4_opening => math_4_in_data, 
                                        math_out_opening => channel_7_real_vect-FROM-0x7fbf3be00350-TO_BUFFER-DATA 
); 

fifo_4 : axi_fifo GENERIC MAP       (math_ram_width, 
                                    math_ram_depth 
                                    ) 
                    PORT MAP        (buf_clk => math_clk, 
                                    buf_rst => math_rst, 

                                    buf_in_ready => channel_13_real_vect-FROM-0x7fbf3be029a0-TO_BUFFER-READY, 
                                    buf_out_ready => channel_13_real_vect-FROM_BUFFER_TO-0x7fbf3be02d20-READY, 

                                    buf_in_valid => channel_13_real_vect-FROM-0x7fbf3be029a0-TO_BUFFER-VALID, 
                                    buf_out_valid => channel_13_real_vect-FROM_BUFFER_TO-0x7fbf3be02d20-VALID, 

                                    buf_in_data => channel_13_real_vect-FROM-0x7fbf3be029a0-TO_BUFFER-DATA, 
                                    buf_out_data => channel_13_real_vect-FROM_BUFFER_TO-0x7fbf3be02d20-DATA 
); 

INPUT_5 : INPUT_node PORT MAP (         INPUT_clk => math_clk, 
                                        INPUT_rst => math_rst, 

                                        INPUT_in5_ready => math_5_in_ready, 
                                        math_out_ready => channel_8_real_vect-FROM-0x7fbf3be004c0-TO_BUFFER-READY, 

                                        INPUT_in5_valid => math_5_in_valid, 
                                        math_out_valid => channel_8_real_vect-FROM-0x7fbf3be004c0-TO_BUFFER-VALID, 

                                        INPUT_in5_opening => math_5_in_data, 
                                        math_out_opening => channel_8_real_vect-FROM-0x7fbf3be004c0-TO_BUFFER-DATA 
); 

fifo_5 : axi_fifo GENERIC MAP       (math_ram_width, 
                                    math_ram_depth 
                                    ) 
                    PORT MAP        (buf_clk => math_clk, 
                                    buf_rst => math_rst, 

                                    buf_in_ready => channel_14_real_vect-FROM-0x7fbf3be02d20-TO_BUFFER-READY, 
                                    buf_out_ready => channel_14_real_vect-FROM_BUFFER_TO-OUTPUT_0-READY, 

                                    buf_in_valid => channel_14_real_vect-FROM-0x7fbf3be02d20-TO_BUFFER-VALID, 
                                    buf_out_valid => channel_14_real_vect-FROM_BUFFER_TO-OUTPUT_0-VALID, 

                                    buf_in_data => channel_14_real_vect-FROM-0x7fbf3be02d20-TO_BUFFER-DATA, 
                                    buf_out_data => channel_14_real_vect-FROM_BUFFER_TO-OUTPUT_0-DATA 
); 

INPUT_6 : INPUT_node PORT MAP (         INPUT_clk => math_clk, 
                                        INPUT_rst => math_rst, 

                                        INPUT_in6_ready => math_6_in_ready, 
                                        math_out_ready => channel_10_real_vect-FROM-0x7fbf3be00580-TO_BUFFER-READY, 

                                        INPUT_in6_valid => math_6_in_valid, 
                                        math_out_valid => channel_10_real_vect-FROM-0x7fbf3be00580-TO_BUFFER-VALID, 

                                        INPUT_in6_opening => math_6_in_data, 
                                        math_out_opening => channel_10_real_vect-FROM-0x7fbf3be00580-TO_BUFFER-DATA 
); 

fifo_6 : axi_fifo GENERIC MAP       (math_ram_width, 
                                    math_ram_depth 
                                    ) 
                    PORT MAP        (buf_clk => math_clk, 
                                    buf_rst => math_rst, 

                                    buf_in_ready => channel_1_real_vect-FROM-0x7fbf3be00140-TO_BUFFER-READY, 
                                    buf_out_ready => channel_1_real_vect-FROM_BUFFER_TO-0x7fbf3be012c0-READY, 

                                    buf_in_valid => channel_1_real_vect-FROM-0x7fbf3be00140-TO_BUFFER-VALID, 
                                    buf_out_valid => channel_1_real_vect-FROM_BUFFER_TO-0x7fbf3be012c0-VALID, 

                                    buf_in_data => channel_1_real_vect-FROM-0x7fbf3be00140-TO_BUFFER-DATA, 
                                    buf_out_data => channel_1_real_vect-FROM_BUFFER_TO-0x7fbf3be012c0-DATA 
); 

INPUT_7 : INPUT_node PORT MAP (         INPUT_clk => math_clk, 
                                        INPUT_rst => math_rst, 

                                        INPUT_in7_ready => math_7_in_ready, 
                                        math_out_ready => channel_11_real_vect-FROM-0x7fbf3be006f0-TO_BUFFER-READY, 

                                        INPUT_in7_valid => math_7_in_valid, 
                                        math_out_valid => channel_11_real_vect-FROM-0x7fbf3be006f0-TO_BUFFER-VALID, 

                                        INPUT_in7_opening => math_7_in_data, 
                                        math_out_opening => channel_11_real_vect-FROM-0x7fbf3be006f0-TO_BUFFER-DATA 
); 

fifo_7 : axi_fifo GENERIC MAP       (math_ram_width, 
                                    math_ram_depth 
                                    ) 
                    PORT MAP        (buf_clk => math_clk, 
                                    buf_rst => math_rst, 

                                    buf_in_ready => channel_2_real_vect-FROM-0x7fbf3be012c0-TO_BUFFER-READY, 
                                    buf_out_ready => channel_2_real_vect-FROM_BUFFER_TO-0x7fbf3be02710-READY, 

                                    buf_in_valid => channel_2_real_vect-FROM-0x7fbf3be012c0-TO_BUFFER-VALID, 
                                    buf_out_valid => channel_2_real_vect-FROM_BUFFER_TO-0x7fbf3be02710-VALID, 

                                    buf_in_data => channel_2_real_vect-FROM-0x7fbf3be012c0-TO_BUFFER-DATA, 
                                    buf_out_data => channel_2_real_vect-FROM_BUFFER_TO-0x7fbf3be02710-DATA 
); 

add_0 : add_node PORT MAP (           math_clk => add_clk, 
                                            math_rst => add_rst, 

                                            add_in0_ready => channel_0_real_vect-FROM_BUFFER_TO-0x7fbf3be012c0-READY, 
                                            add_in0_valid => channel_0_real_vect-FROM_BUFFER_TO-0x7fbf3be012c0-VALID, 
                                            add_in0_opening => channel_0_real_vect-FROM_BUFFER_TO-0x7fbf3be012c0-DATA, 

                                            add_in1_ready => channel_1_real_vect-FROM_BUFFER_TO-0x7fbf3be012c0-READY, 
                                            add_in1_valid => channel_1_real_vect-FROM_BUFFER_TO-0x7fbf3be012c0-VALID, 
                                            add_in1_opening => channel_1_real_vect-FROM_BUFFER_TO-0x7fbf3be012c0-DATA, 

                                            add_out0_ready => channel_9_real_vect-FROM-0x7fbf3be01d10-TO_BUFFER-READY, 
                                            add_out0_valid => channel_2_real_vect-FROM-0x7fbf3be012c0-TO_BUFFER-VALID, 
                                            add_out0_opening => channel_2_real_vect-FROM-0x7fbf3be012c0-TO_BUFFER-DATA 
); 

fifo_8 : axi_fifo GENERIC MAP       (math_ram_width, 
                                    math_ram_depth 
                                    ) 
                    PORT MAP        (buf_clk => math_clk, 
                                    buf_rst => math_rst, 

                                    buf_in_ready => channel_9_real_vect-FROM-0x7fbf3be01d10-TO_BUFFER-READY, 
                                    buf_out_ready => channel_2_real_vect-FROM_BUFFER_TO-0x7fbf3be02710-READY, 

                                    buf_in_valid => channel_2_real_vect-FROM-0x7fbf3be012c0-TO_BUFFER-VALID, 
                                    buf_out_valid => channel_2_real_vect-FROM_BUFFER_TO-0x7fbf3be02710-VALID, 

                                    buf_in_data => channel_2_real_vect-FROM-0x7fbf3be012c0-TO_BUFFER-DATA, 
                                    buf_out_data => channel_2_real_vect-FROM_BUFFER_TO-0x7fbf3be02710-DATA 
); 

add_1 : add_node PORT MAP (           math_clk => add_clk, 
                                            math_rst => add_rst, 

                                            add_in0_ready => channel_3_real_vect-FROM_BUFFER_TO-0x7fbf3be017f0-READY, 
                                            add_in0_valid => channel_3_real_vect-FROM_BUFFER_TO-0x7fbf3be017f0-VALID, 
                                            add_in0_opening => channel_3_real_vect-FROM_BUFFER_TO-0x7fbf3be017f0-DATA, 

                                            add_in1_ready => channel_4_real_vect-FROM_BUFFER_TO-0x7fbf3be017f0-READY, 
                                            add_in1_valid => channel_4_real_vect-FROM_BUFFER_TO-0x7fbf3be017f0-VALID, 
                                            add_in1_opening => channel_4_real_vect-FROM_BUFFER_TO-0x7fbf3be017f0-DATA, 

                                            add_out0_ready => channel_9_real_vect-FROM-0x7fbf3be01d10-TO_BUFFER-READY, 
                                            add_out0_valid => channel_5_real_vect-FROM-0x7fbf3be017f0-TO_BUFFER-VALID, 
                                            add_out0_opening => channel_5_real_vect-FROM-0x7fbf3be017f0-TO_BUFFER-DATA 
); 

fifo_9 : axi_fifo GENERIC MAP       (math_ram_width, 
                                    math_ram_depth 
                                    ) 
                    PORT MAP        (buf_clk => math_clk, 
                                    buf_rst => math_rst, 

                                    buf_in_ready => channel_9_real_vect-FROM-0x7fbf3be01d10-TO_BUFFER-READY, 
                                    buf_out_ready => channel_5_real_vect-FROM_BUFFER_TO-0x7fbf3be02710-READY, 

                                    buf_in_valid => channel_5_real_vect-FROM-0x7fbf3be017f0-TO_BUFFER-VALID, 
                                    buf_out_valid => channel_5_real_vect-FROM_BUFFER_TO-0x7fbf3be02710-VALID, 

                                    buf_in_data => channel_5_real_vect-FROM-0x7fbf3be017f0-TO_BUFFER-DATA, 
                                    buf_out_data => channel_5_real_vect-FROM_BUFFER_TO-0x7fbf3be02710-DATA 
); 

add_2 : add_node PORT MAP (           math_clk => add_clk, 
                                            math_rst => add_rst, 

                                            add_in0_ready => channel_7_real_vect-FROM_BUFFER_TO-0x7fbf3be01d10-READY, 
                                            add_in0_valid => channel_7_real_vect-FROM_BUFFER_TO-0x7fbf3be01d10-VALID, 
                                            add_in0_opening => channel_7_real_vect-FROM_BUFFER_TO-0x7fbf3be01d10-DATA, 

                                            add_in1_ready => channel_8_real_vect-FROM_BUFFER_TO-0x7fbf3be01d10-READY, 
                                            add_in1_valid => channel_8_real_vect-FROM_BUFFER_TO-0x7fbf3be01d10-VALID, 
                                            add_in1_opening => channel_8_real_vect-FROM_BUFFER_TO-0x7fbf3be01d10-DATA, 

                                            add_out0_ready => channel_9_real_vect-FROM-0x7fbf3be01d10-TO_BUFFER-READY, 
                                            add_out0_valid => channel_9_real_vect-FROM-0x7fbf3be01d10-TO_BUFFER-VALID, 
                                            add_out0_opening => channel_9_real_vect-FROM-0x7fbf3be01d10-TO_BUFFER-DATA 
); 

fifo_10 : axi_fifo GENERIC MAP       (math_ram_width, 
                                    math_ram_depth 
                                    ) 
                    PORT MAP        (buf_clk => math_clk, 
                                    buf_rst => math_rst, 

                                    buf_in_ready => channel_9_real_vect-FROM-0x7fbf3be01d10-TO_BUFFER-READY, 
                                    buf_out_ready => channel_9_real_vect-FROM_BUFFER_TO-0x7fbf3be029a0-READY, 

                                    buf_in_valid => channel_9_real_vect-FROM-0x7fbf3be01d10-TO_BUFFER-VALID, 
                                    buf_out_valid => channel_9_real_vect-FROM_BUFFER_TO-0x7fbf3be029a0-VALID, 

                                    buf_in_data => channel_9_real_vect-FROM-0x7fbf3be01d10-TO_BUFFER-DATA, 
                                    buf_out_data => channel_9_real_vect-FROM_BUFFER_TO-0x7fbf3be029a0-DATA 
); 

add_3 : add_node PORT MAP (           math_clk => add_clk, 
                                            math_rst => add_rst, 

                                            add_in0_ready => channel_10_real_vect-FROM_BUFFER_TO-0x7fbf3be01fd0-READY, 
                                            add_in0_valid => channel_10_real_vect-FROM_BUFFER_TO-0x7fbf3be01fd0-VALID, 
                                            add_in0_opening => channel_10_real_vect-FROM_BUFFER_TO-0x7fbf3be01fd0-DATA, 

                                            add_in1_ready => channel_11_real_vect-FROM_BUFFER_TO-0x7fbf3be01fd0-READY, 
                                            add_in1_valid => channel_11_real_vect-FROM_BUFFER_TO-0x7fbf3be01fd0-VALID, 
                                            add_in1_opening => channel_11_real_vect-FROM_BUFFER_TO-0x7fbf3be01fd0-DATA, 

                                            add_out0_ready => channel_9_real_vect-FROM-0x7fbf3be01d10-TO_BUFFER-READY, 
                                            add_out0_valid => channel_12_real_vect-FROM-0x7fbf3be01fd0-TO_BUFFER-VALID, 
                                            add_out0_opening => channel_12_real_vect-FROM-0x7fbf3be01fd0-TO_BUFFER-DATA 
); 

fifo_11 : axi_fifo GENERIC MAP       (math_ram_width, 
                                    math_ram_depth 
                                    ) 
                    PORT MAP        (buf_clk => math_clk, 
                                    buf_rst => math_rst, 

                                    buf_in_ready => channel_9_real_vect-FROM-0x7fbf3be01d10-TO_BUFFER-READY, 
                                    buf_out_ready => channel_12_real_vect-FROM_BUFFER_TO-0x7fbf3be029a0-READY, 

                                    buf_in_valid => channel_12_real_vect-FROM-0x7fbf3be01fd0-TO_BUFFER-VALID, 
                                    buf_out_valid => channel_12_real_vect-FROM_BUFFER_TO-0x7fbf3be029a0-VALID, 

                                    buf_in_data => channel_12_real_vect-FROM-0x7fbf3be01fd0-TO_BUFFER-DATA, 
                                    buf_out_data => channel_12_real_vect-FROM_BUFFER_TO-0x7fbf3be029a0-DATA 
); 

prod_0 : prod_node PORT MAP (           math_clk => prod_clk, 
                                            math_rst => prod_rst, 

                                            prod_in0_ready => channel_2_real_vect-FROM_BUFFER_TO-0x7fbf3be02710-READY, 
                                            prod_in0_valid => channel_2_real_vect-FROM_BUFFER_TO-0x7fbf3be02710-VALID, 
                                            prod_in0_opening => channel_2_real_vect-FROM_BUFFER_TO-0x7fbf3be02710-DATA, 

                                            prod_in1_ready => channel_5_real_vect-FROM_BUFFER_TO-0x7fbf3be02710-READY, 
                                            prod_in1_valid => channel_5_real_vect-FROM_BUFFER_TO-0x7fbf3be02710-VALID, 
                                            prod_in1_opening => channel_5_real_vect-FROM_BUFFER_TO-0x7fbf3be02710-DATA, 

                                            prod_out0_ready => channel_6_real_vect-FROM-0x7fbf3be02710-TO_BUFFER-READY, 
                                            prod_out0_valid => channel_6_real_vect-FROM-0x7fbf3be02710-TO_BUFFER-VALID, 
                                            prod_out0_opening => channel_6_real_vect-FROM-0x7fbf3be02710-TO_BUFFER-DATA 
); 

fifo_12 : axi_fifo GENERIC MAP       (math_ram_width, 
                                    math_ram_depth 
                                    ) 
                    PORT MAP        (buf_clk => math_clk, 
                                    buf_rst => math_rst, 

                                    buf_in_ready => channel_6_real_vect-FROM-0x7fbf3be02710-TO_BUFFER-READY, 
                                    buf_out_ready => channel_6_real_vect-FROM_BUFFER_TO-0x7fbf3be02d20-READY, 

                                    buf_in_valid => channel_6_real_vect-FROM-0x7fbf3be02710-TO_BUFFER-VALID, 
                                    buf_out_valid => channel_6_real_vect-FROM_BUFFER_TO-0x7fbf3be02d20-VALID, 

                                    buf_in_data => channel_6_real_vect-FROM-0x7fbf3be02710-TO_BUFFER-DATA, 
                                    buf_out_data => channel_6_real_vect-FROM_BUFFER_TO-0x7fbf3be02d20-DATA 
); 

prod_1 : prod_node PORT MAP (           math_clk => prod_clk, 
                                            math_rst => prod_rst, 

                                            prod_in0_ready => channel_12_real_vect-FROM_BUFFER_TO-0x7fbf3be029a0-READY, 
                                            prod_in0_valid => channel_12_real_vect-FROM_BUFFER_TO-0x7fbf3be029a0-VALID, 
                                            prod_in0_opening => channel_12_real_vect-FROM_BUFFER_TO-0x7fbf3be029a0-DATA, 

                                            prod_in1_ready => channel_9_real_vect-FROM_BUFFER_TO-0x7fbf3be029a0-READY, 
                                            prod_in1_valid => channel_9_real_vect-FROM_BUFFER_TO-0x7fbf3be029a0-VALID, 
                                            prod_in1_opening => channel_9_real_vect-FROM_BUFFER_TO-0x7fbf3be029a0-DATA, 

                                            prod_out0_ready => channel_13_real_vect-FROM-0x7fbf3be029a0-TO_BUFFER-READY, 
                                            prod_out0_valid => channel_13_real_vect-FROM-0x7fbf3be029a0-TO_BUFFER-VALID, 
                                            prod_out0_opening => channel_13_real_vect-FROM-0x7fbf3be029a0-TO_BUFFER-DATA 
); 

fifo_13 : axi_fifo GENERIC MAP       (math_ram_width, 
                                    math_ram_depth 
                                    ) 
                    PORT MAP        (buf_clk => math_clk, 
                                    buf_rst => math_rst, 

                                    buf_in_ready => channel_13_real_vect-FROM-0x7fbf3be029a0-TO_BUFFER-READY, 
                                    buf_out_ready => channel_13_real_vect-FROM_BUFFER_TO-0x7fbf3be02d20-READY, 

                                    buf_in_valid => channel_13_real_vect-FROM-0x7fbf3be029a0-TO_BUFFER-VALID, 
                                    buf_out_valid => channel_13_real_vect-FROM_BUFFER_TO-0x7fbf3be02d20-VALID, 

                                    buf_in_data => channel_13_real_vect-FROM-0x7fbf3be029a0-TO_BUFFER-DATA, 
                                    buf_out_data => channel_13_real_vect-FROM_BUFFER_TO-0x7fbf3be02d20-DATA 
); 

div_0 : div_node PORT MAP (           math_clk => div_clk, 
                                            math_rst => div_rst, 

                                            div_in0_ready => channel_13_real_vect-FROM_BUFFER_TO-0x7fbf3be02d20-READY, 
                                            div_in0_valid => channel_13_real_vect-FROM_BUFFER_TO-0x7fbf3be02d20-VALID, 
                                            div_in0_opening => channel_13_real_vect-FROM_BUFFER_TO-0x7fbf3be02d20-DATA, 

                                            div_in1_ready => channel_6_real_vect-FROM_BUFFER_TO-0x7fbf3be02d20-READY, 
                                            div_in1_valid => channel_6_real_vect-FROM_BUFFER_TO-0x7fbf3be02d20-VALID, 
                                            div_in1_opening => channel_6_real_vect-FROM_BUFFER_TO-0x7fbf3be02d20-DATA, 

                                            div_out0_ready => channel_14_real_vect-FROM-0x7fbf3be02d20-TO_BUFFER-READY, 
                                            div_out0_valid => channel_14_real_vect-FROM-0x7fbf3be02d20-TO_BUFFER-VALID, 
                                            div_out0_opening => channel_14_real_vect-FROM-0x7fbf3be02d20-TO_BUFFER-DATA 
); 

fifo_14 : axi_fifo GENERIC MAP       (math_ram_width, 
                                    math_ram_depth 
                                    ) 
                    PORT MAP        (buf_clk => math_clk, 
                                    buf_rst => math_rst, 

                                    buf_in_ready => channel_14_real_vect-FROM-0x7fbf3be02d20-TO_BUFFER-READY, 
                                    buf_out_ready => channel_14_real_vect-FROM_BUFFER_TO-OUTPUT_0-READY, 

                                    buf_in_valid => channel_14_real_vect-FROM-0x7fbf3be02d20-TO_BUFFER-VALID, 
                                    buf_out_valid => channel_14_real_vect-FROM_BUFFER_TO-OUTPUT_0-VALID, 

                                    buf_in_data => channel_14_real_vect-FROM-0x7fbf3be02d20-TO_BUFFER-DATA, 
                                    buf_out_data => channel_14_real_vect-FROM_BUFFER_TO-OUTPUT_0-DATA 
); 

OUTPUT_0 : OUTPUT_node PORT MAP (           OUTPUT_clk => math_clk, 
                                            OUTPUT_rst => math_rst, 

                                            OUTPUT_in_ready => channel_14_real_vect-FROM_BUFFER_TO-OUTPUT_0-READY, 
                                            OUTPUT_out_ready => math_out_ready, 

                                            OUTPUT_in_valid => channel_14_real_vect-FROM_BUFFER_TO-OUTPUT_0-VALID, 
                                            OUTPUT_out_valid => math_out_valid, 

                                            OUTPUT_in_opening => channel_14_real_vect-FROM_BUFFER_TO-OUTPUT_0-READY, 
                                            OUTPUT_out_opening => math_out_data 
); 


 end math_arch; 
