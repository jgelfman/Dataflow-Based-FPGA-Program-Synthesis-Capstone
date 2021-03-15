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
 
        math_in_ready : in std_logic; 
        math_in_valid : in std_logic; 
        math_in_data : in std_logic_vector; 
 
        math_out_ready : out std_logic; 
        math_out_valid : out std_logic; 
        math_out_data : out std_logic_vector 
    ); 
end; 
 
architecture math_arch of math is 


    component INPUT_node is 
        port ( 

            input_in_ready : in std_logic; 
            input_out_ready : out std_logic; 

            input_in_valid : in std_logic; 
            input_out_valid : out std_logic; 

            input_in_opening : in std_logic_vector(math_ram_width - 1 downto 0); 
            input_out_opening : out std_logic_vector(math_ram_width - 1 downto 0) 
    ); end component; 

    component add_node is 
        port ( 
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


 signal channel_0_real_vect__FROM__0x7fbf3be00080__TO_BUFFER__DATA, channel_0_real_vect__FROM_BUFFER_TO__0x7fbf3be012c0__DATA, channel_10_real_vect__FROM__0x7fbf3be00580__TO_BUFFER__DATA, channel_10_real_vect__FROM_BUFFER_TO__0x7fbf3be01fd0__DATA, channel_11_real_vect__FROM__0x7fbf3be006f0__TO_BUFFER__DATA, channel_11_real_vect__FROM_BUFFER_TO__0x7fbf3be01fd0__DATA, channel_12_real_vect__FROM__0x7fbf3be01fd0__TO_BUFFER__DATA, channel_12_real_vect__FROM_BUFFER_TO__0x7fbf3be029a0__DATA, channel_13_real_vect__FROM__0x7fbf3be029a0__TO_BUFFER__DATA, channel_13_real_vect__FROM_BUFFER_TO__0x7fbf3be02d20__DATA, channel_14_real_vect__FROM__0x7fbf3be02d20__TO_BUFFER__DATA, channel_14_real_vect__FROM_BUFFER_TO__OUTPUT_0__DATA, channel_1_real_vect__FROM__0x7fbf3be00140__TO_BUFFER__DATA, channel_1_real_vect__FROM_BUFFER_TO__0x7fbf3be012c0__DATA, channel_2_real_vect__FROM__0x7fbf3be012c0__TO_BUFFER__DATA, channel_2_real_vect__FROM_BUFFER_TO__0x7fbf3be02710__DATA, channel_3_real_vect__FROM__0x7fbf3be001d0__TO_BUFFER__DATA, channel_3_real_vect__FROM_BUFFER_TO__0x7fbf3be017f0__DATA, channel_4_real_vect__FROM__0x7fbf3be00290__TO_BUFFER__DATA, channel_4_real_vect__FROM_BUFFER_TO__0x7fbf3be017f0__DATA, channel_5_real_vect__FROM__0x7fbf3be017f0__TO_BUFFER__DATA, channel_5_real_vect__FROM_BUFFER_TO__0x7fbf3be02710__DATA, channel_6_real_vect__FROM__0x7fbf3be02710__TO_BUFFER__DATA, channel_6_real_vect__FROM_BUFFER_TO__0x7fbf3be02d20__DATA, channel_7_real_vect__FROM__0x7fbf3be00350__TO_BUFFER__DATA, channel_7_real_vect__FROM_BUFFER_TO__0x7fbf3be01d10__DATA, channel_8_real_vect__FROM__0x7fbf3be004c0__TO_BUFFER__DATA, channel_8_real_vect__FROM_BUFFER_TO__0x7fbf3be01d10__DATA, channel_9_real_vect__FROM__0x7fbf3be01d10__TO_BUFFER__DATA, channel_9_real_vect__FROM_BUFFER_TO__0x7fbf3be029a0__DATA : std_logic_vector(math_ram_width - 1 downto 0); 
signal channel_0_real_vect__FROM__0x7fbf3be00080__TO_BUFFER__READY, channel_0_real_vect__FROM_BUFFER_TO__0x7fbf3be012c0__READY, channel_0_real_vect__FROM__0x7fbf3be00080__TO_BUFFER__VALID, channel_0_real_vect__FROM_BUFFER_TO__0x7fbf3be012c0__VALID, channel_10_real_vect__FROM__0x7fbf3be00580__TO_BUFFER__READY, channel_10_real_vect__FROM_BUFFER_TO__0x7fbf3be01fd0__READY, channel_10_real_vect__FROM__0x7fbf3be00580__TO_BUFFER__VALID, channel_10_real_vect__FROM_BUFFER_TO__0x7fbf3be01fd0__VALID, channel_11_real_vect__FROM__0x7fbf3be006f0__TO_BUFFER__READY, channel_11_real_vect__FROM_BUFFER_TO__0x7fbf3be01fd0__READY, channel_11_real_vect__FROM__0x7fbf3be006f0__TO_BUFFER__VALID, channel_11_real_vect__FROM_BUFFER_TO__0x7fbf3be01fd0__VALID, channel_12_real_vect__FROM__0x7fbf3be01fd0__TO_BUFFER__READY, channel_12_real_vect__FROM_BUFFER_TO__0x7fbf3be029a0__READY, channel_12_real_vect__FROM__0x7fbf3be01fd0__TO_BUFFER__VALID, channel_12_real_vect__FROM_BUFFER_TO__0x7fbf3be029a0__VALID, channel_13_real_vect__FROM__0x7fbf3be029a0__TO_BUFFER__READY, channel_13_real_vect__FROM_BUFFER_TO__0x7fbf3be02d20__READY, channel_13_real_vect__FROM__0x7fbf3be029a0__TO_BUFFER__VALID, channel_13_real_vect__FROM_BUFFER_TO__0x7fbf3be02d20__VALID, channel_14_real_vect__FROM__0x7fbf3be02d20__TO_BUFFER__READY, channel_14_real_vect__FROM_BUFFER_TO__OUTPUT_0__READY, channel_14_real_vect__FROM__0x7fbf3be02d20__TO_BUFFER__VALID, channel_14_real_vect__FROM_BUFFER_TO__OUTPUT_0__VALID, channel_1_real_vect__FROM__0x7fbf3be00140__TO_BUFFER__READY, channel_1_real_vect__FROM_BUFFER_TO__0x7fbf3be012c0__READY, channel_1_real_vect__FROM__0x7fbf3be00140__TO_BUFFER__VALID, channel_1_real_vect__FROM_BUFFER_TO__0x7fbf3be012c0__VALID, channel_2_real_vect__FROM__0x7fbf3be012c0__TO_BUFFER__READY, channel_2_real_vect__FROM_BUFFER_TO__0x7fbf3be02710__READY, channel_2_real_vect__FROM__0x7fbf3be012c0__TO_BUFFER__VALID, channel_2_real_vect__FROM_BUFFER_TO__0x7fbf3be02710__VALID, channel_3_real_vect__FROM__0x7fbf3be001d0__TO_BUFFER__READY, channel_3_real_vect__FROM_BUFFER_TO__0x7fbf3be017f0__READY, channel_3_real_vect__FROM__0x7fbf3be001d0__TO_BUFFER__VALID, channel_3_real_vect__FROM_BUFFER_TO__0x7fbf3be017f0__VALID, channel_4_real_vect__FROM__0x7fbf3be00290__TO_BUFFER__READY, channel_4_real_vect__FROM_BUFFER_TO__0x7fbf3be017f0__READY, channel_4_real_vect__FROM__0x7fbf3be00290__TO_BUFFER__VALID, channel_4_real_vect__FROM_BUFFER_TO__0x7fbf3be017f0__VALID, channel_5_real_vect__FROM__0x7fbf3be017f0__TO_BUFFER__READY, channel_5_real_vect__FROM_BUFFER_TO__0x7fbf3be02710__READY, channel_5_real_vect__FROM__0x7fbf3be017f0__TO_BUFFER__VALID, channel_5_real_vect__FROM_BUFFER_TO__0x7fbf3be02710__VALID, channel_6_real_vect__FROM__0x7fbf3be02710__TO_BUFFER__READY, channel_6_real_vect__FROM_BUFFER_TO__0x7fbf3be02d20__READY, channel_6_real_vect__FROM__0x7fbf3be02710__TO_BUFFER__VALID, channel_6_real_vect__FROM_BUFFER_TO__0x7fbf3be02d20__VALID, channel_7_real_vect__FROM__0x7fbf3be00350__TO_BUFFER__READY, channel_7_real_vect__FROM_BUFFER_TO__0x7fbf3be01d10__READY, channel_7_real_vect__FROM__0x7fbf3be00350__TO_BUFFER__VALID, channel_7_real_vect__FROM_BUFFER_TO__0x7fbf3be01d10__VALID, channel_8_real_vect__FROM__0x7fbf3be004c0__TO_BUFFER__READY, channel_8_real_vect__FROM_BUFFER_TO__0x7fbf3be01d10__READY, channel_8_real_vect__FROM__0x7fbf3be004c0__TO_BUFFER__VALID, channel_8_real_vect__FROM_BUFFER_TO__0x7fbf3be01d10__VALID, channel_9_real_vect__FROM__0x7fbf3be01d10__TO_BUFFER__READY, channel_9_real_vect__FROM_BUFFER_TO__0x7fbf3be029a0__READY, channel_9_real_vect__FROM__0x7fbf3be01d10__TO_BUFFER__VALID, channel_9_real_vect__FROM_BUFFER_TO__0x7fbf3be029a0__VALID : std_logic; 


begin 

INPUT_0 : INPUT_node PORT MAP (           math_clk => INPUT_clk, 
                                            math_rst => INPUT_rst, 

                                            INPUT_in_ready => math_in_ready, 
                                            INPUT_out_ready => channel_0_real_vect__FROM__0x7fbf3be00080__TO_BUFFER__READY, 

                                            INPUT_in_valid => math_in_valid, 
                                            INPUT_out_valid => channel_0_real_vect__FROM__0x7fbf3be00080__TO_BUFFER__VALID, 

                                            INPUT_in_opening => math_in_data, 
                                            INPUT_out_opening => channel_0_real_vect__FROM__0x7fbf3be00080__TO_BUFFER__DATA 
); 

fifo_0 : axi_fifo GENERIC MAP       (math_ram_width, 
                                    math_ram_depth 
                                    ) 
                    PORT MAP        (buf_clk => math_clk, 
                                    buf_rst => math_rst, 

                                    buf_in_ready => channel_0_real_vect__FROM__0x7fbf3be00080__TO_BUFFER__READY, 
                                    buf_out_ready => channel_0_real_vect__FROM_BUFFER_TO__0x7fbf3be012c0__READY, 

                                    buf_in_valid => channel_0_real_vect__FROM__0x7fbf3be00080__TO_BUFFER__VALID, 
                                    buf_out_valid => channel_0_real_vect__FROM_BUFFER_TO__0x7fbf3be012c0__VALID, 

                                    buf_in_data => channel_0_real_vect__FROM__0x7fbf3be00080__TO_BUFFER__DATA, 
                                    buf_out_data => channel_0_real_vect__FROM_BUFFER_TO__0x7fbf3be012c0__DATA 
); 

INPUT_1 : INPUT_node PORT MAP (           math_clk => INPUT_clk, 
                                            math_rst => INPUT_rst, 

                                            INPUT_in_ready => math_in_ready, 
                                            INPUT_out_ready => channel_10_real_vect__FROM__0x7fbf3be00580__TO_BUFFER__READY, 

                                            INPUT_in_valid => math_in_valid, 
                                            INPUT_out_valid => channel_10_real_vect__FROM__0x7fbf3be00580__TO_BUFFER__VALID, 

                                            INPUT_in_opening => math_in_data, 
                                            INPUT_out_opening => channel_10_real_vect__FROM__0x7fbf3be00580__TO_BUFFER__DATA 
); 

fifo_1 : axi_fifo GENERIC MAP       (math_ram_width, 
                                    math_ram_depth 
                                    ) 
                    PORT MAP        (buf_clk => math_clk, 
                                    buf_rst => math_rst, 

                                    buf_in_ready => channel_10_real_vect__FROM__0x7fbf3be00580__TO_BUFFER__READY, 
                                    buf_out_ready => channel_10_real_vect__FROM_BUFFER_TO__0x7fbf3be01fd0__READY, 

                                    buf_in_valid => channel_10_real_vect__FROM__0x7fbf3be00580__TO_BUFFER__VALID, 
                                    buf_out_valid => channel_10_real_vect__FROM_BUFFER_TO__0x7fbf3be01fd0__VALID, 

                                    buf_in_data => channel_10_real_vect__FROM__0x7fbf3be00580__TO_BUFFER__DATA, 
                                    buf_out_data => channel_10_real_vect__FROM_BUFFER_TO__0x7fbf3be01fd0__DATA 
); 

INPUT_2 : INPUT_node PORT MAP (           math_clk => INPUT_clk, 
                                            math_rst => INPUT_rst, 

                                            INPUT_in_ready => math_in_ready, 
                                            INPUT_out_ready => channel_11_real_vect__FROM__0x7fbf3be006f0__TO_BUFFER__READY, 

                                            INPUT_in_valid => math_in_valid, 
                                            INPUT_out_valid => channel_11_real_vect__FROM__0x7fbf3be006f0__TO_BUFFER__VALID, 

                                            INPUT_in_opening => math_in_data, 
                                            INPUT_out_opening => channel_11_real_vect__FROM__0x7fbf3be006f0__TO_BUFFER__DATA 
); 

fifo_2 : axi_fifo GENERIC MAP       (math_ram_width, 
                                    math_ram_depth 
                                    ) 
                    PORT MAP        (buf_clk => math_clk, 
                                    buf_rst => math_rst, 

                                    buf_in_ready => channel_11_real_vect__FROM__0x7fbf3be006f0__TO_BUFFER__READY, 
                                    buf_out_ready => channel_11_real_vect__FROM_BUFFER_TO__0x7fbf3be01fd0__READY, 

                                    buf_in_valid => channel_11_real_vect__FROM__0x7fbf3be006f0__TO_BUFFER__VALID, 
                                    buf_out_valid => channel_11_real_vect__FROM_BUFFER_TO__0x7fbf3be01fd0__VALID, 

                                    buf_in_data => channel_11_real_vect__FROM__0x7fbf3be006f0__TO_BUFFER__DATA, 
                                    buf_out_data => channel_11_real_vect__FROM_BUFFER_TO__0x7fbf3be01fd0__DATA 
); 

INPUT_3 : INPUT_node PORT MAP (           math_clk => INPUT_clk, 
                                            math_rst => INPUT_rst, 

                                            INPUT_in_ready => math_in_ready, 
                                            INPUT_out_ready => channel_12_real_vect__FROM__0x7fbf3be01fd0__TO_BUFFER__READY, 

                                            INPUT_in_valid => math_in_valid, 
                                            INPUT_out_valid => channel_12_real_vect__FROM__0x7fbf3be01fd0__TO_BUFFER__VALID, 

                                            INPUT_in_opening => math_in_data, 
                                            INPUT_out_opening => channel_12_real_vect__FROM__0x7fbf3be01fd0__TO_BUFFER__DATA 
); 

fifo_3 : axi_fifo GENERIC MAP       (math_ram_width, 
                                    math_ram_depth 
                                    ) 
                    PORT MAP        (buf_clk => math_clk, 
                                    buf_rst => math_rst, 

                                    buf_in_ready => channel_12_real_vect__FROM__0x7fbf3be01fd0__TO_BUFFER__READY, 
                                    buf_out_ready => channel_12_real_vect__FROM_BUFFER_TO__0x7fbf3be029a0__READY, 

                                    buf_in_valid => channel_12_real_vect__FROM__0x7fbf3be01fd0__TO_BUFFER__VALID, 
                                    buf_out_valid => channel_12_real_vect__FROM_BUFFER_TO__0x7fbf3be029a0__VALID, 

                                    buf_in_data => channel_12_real_vect__FROM__0x7fbf3be01fd0__TO_BUFFER__DATA, 
                                    buf_out_data => channel_12_real_vect__FROM_BUFFER_TO__0x7fbf3be029a0__DATA 
); 

INPUT_4 : INPUT_node PORT MAP (           math_clk => INPUT_clk, 
                                            math_rst => INPUT_rst, 

                                            INPUT_in_ready => math_in_ready, 
                                            INPUT_out_ready => channel_13_real_vect__FROM__0x7fbf3be029a0__TO_BUFFER__READY, 

                                            INPUT_in_valid => math_in_valid, 
                                            INPUT_out_valid => channel_13_real_vect__FROM__0x7fbf3be029a0__TO_BUFFER__VALID, 

                                            INPUT_in_opening => math_in_data, 
                                            INPUT_out_opening => channel_13_real_vect__FROM__0x7fbf3be029a0__TO_BUFFER__DATA 
); 

fifo_4 : axi_fifo GENERIC MAP       (math_ram_width, 
                                    math_ram_depth 
                                    ) 
                    PORT MAP        (buf_clk => math_clk, 
                                    buf_rst => math_rst, 

                                    buf_in_ready => channel_13_real_vect__FROM__0x7fbf3be029a0__TO_BUFFER__READY, 
                                    buf_out_ready => channel_13_real_vect__FROM_BUFFER_TO__0x7fbf3be02d20__READY, 

                                    buf_in_valid => channel_13_real_vect__FROM__0x7fbf3be029a0__TO_BUFFER__VALID, 
                                    buf_out_valid => channel_13_real_vect__FROM_BUFFER_TO__0x7fbf3be02d20__VALID, 

                                    buf_in_data => channel_13_real_vect__FROM__0x7fbf3be029a0__TO_BUFFER__DATA, 
                                    buf_out_data => channel_13_real_vect__FROM_BUFFER_TO__0x7fbf3be02d20__DATA 
); 

INPUT_5 : INPUT_node PORT MAP (           math_clk => INPUT_clk, 
                                            math_rst => INPUT_rst, 

                                            INPUT_in_ready => math_in_ready, 
                                            INPUT_out_ready => channel_14_real_vect__FROM__0x7fbf3be02d20__TO_BUFFER__READY, 

                                            INPUT_in_valid => math_in_valid, 
                                            INPUT_out_valid => channel_14_real_vect__FROM__0x7fbf3be02d20__TO_BUFFER__VALID, 

                                            INPUT_in_opening => math_in_data, 
                                            INPUT_out_opening => channel_14_real_vect__FROM__0x7fbf3be02d20__TO_BUFFER__DATA 
); 

fifo_5 : axi_fifo GENERIC MAP       (math_ram_width, 
                                    math_ram_depth 
                                    ) 
                    PORT MAP        (buf_clk => math_clk, 
                                    buf_rst => math_rst, 

                                    buf_in_ready => channel_14_real_vect__FROM__0x7fbf3be02d20__TO_BUFFER__READY, 
                                    buf_out_ready => channel_14_real_vect__FROM_BUFFER_TO__OUTPUT_0__READY, 

                                    buf_in_valid => channel_14_real_vect__FROM__0x7fbf3be02d20__TO_BUFFER__VALID, 
                                    buf_out_valid => channel_14_real_vect__FROM_BUFFER_TO__OUTPUT_0__VALID, 

                                    buf_in_data => channel_14_real_vect__FROM__0x7fbf3be02d20__TO_BUFFER__DATA, 
                                    buf_out_data => channel_14_real_vect__FROM_BUFFER_TO__OUTPUT_0__DATA 
); 

INPUT_6 : INPUT_node PORT MAP (           math_clk => INPUT_clk, 
                                            math_rst => INPUT_rst, 

                                            INPUT_in_ready => math_in_ready, 
                                            INPUT_out_ready => channel_1_real_vect__FROM__0x7fbf3be00140__TO_BUFFER__READY, 

                                            INPUT_in_valid => math_in_valid, 
                                            INPUT_out_valid => channel_1_real_vect__FROM__0x7fbf3be00140__TO_BUFFER__VALID, 

                                            INPUT_in_opening => math_in_data, 
                                            INPUT_out_opening => channel_1_real_vect__FROM__0x7fbf3be00140__TO_BUFFER__DATA 
); 

fifo_6 : axi_fifo GENERIC MAP       (math_ram_width, 
                                    math_ram_depth 
                                    ) 
                    PORT MAP        (buf_clk => math_clk, 
                                    buf_rst => math_rst, 

                                    buf_in_ready => channel_1_real_vect__FROM__0x7fbf3be00140__TO_BUFFER__READY, 
                                    buf_out_ready => channel_1_real_vect__FROM_BUFFER_TO__0x7fbf3be012c0__READY, 

                                    buf_in_valid => channel_1_real_vect__FROM__0x7fbf3be00140__TO_BUFFER__VALID, 
                                    buf_out_valid => channel_1_real_vect__FROM_BUFFER_TO__0x7fbf3be012c0__VALID, 

                                    buf_in_data => channel_1_real_vect__FROM__0x7fbf3be00140__TO_BUFFER__DATA, 
                                    buf_out_data => channel_1_real_vect__FROM_BUFFER_TO__0x7fbf3be012c0__DATA 
); 

INPUT_7 : INPUT_node PORT MAP (           math_clk => INPUT_clk, 
                                            math_rst => INPUT_rst, 

                                            INPUT_in_ready => math_in_ready, 
                                            INPUT_out_ready => channel_2_real_vect__FROM__0x7fbf3be012c0__TO_BUFFER__READY, 

                                            INPUT_in_valid => math_in_valid, 
                                            INPUT_out_valid => channel_2_real_vect__FROM__0x7fbf3be012c0__TO_BUFFER__VALID, 

                                            INPUT_in_opening => math_in_data, 
                                            INPUT_out_opening => channel_2_real_vect__FROM__0x7fbf3be012c0__TO_BUFFER__DATA 
); 

fifo_7 : axi_fifo GENERIC MAP       (math_ram_width, 
                                    math_ram_depth 
                                    ) 
                    PORT MAP        (buf_clk => math_clk, 
                                    buf_rst => math_rst, 

                                    buf_in_ready => channel_2_real_vect__FROM__0x7fbf3be012c0__TO_BUFFER__READY, 
                                    buf_out_ready => channel_2_real_vect__FROM_BUFFER_TO__0x7fbf3be02710__READY, 

                                    buf_in_valid => channel_2_real_vect__FROM__0x7fbf3be012c0__TO_BUFFER__VALID, 
                                    buf_out_valid => channel_2_real_vect__FROM_BUFFER_TO__0x7fbf3be02710__VALID, 

                                    buf_in_data => channel_2_real_vect__FROM__0x7fbf3be012c0__TO_BUFFER__DATA, 
                                    buf_out_data => channel_2_real_vect__FROM_BUFFER_TO__0x7fbf3be02710__DATA 
); 

add_0 : add_node PORT MAP (           add_clk => math_clk, 
                                            add_rst => math_rst, 

                                            add_in0_ready => channel_0_real_vect__FROM_BUFFER_TO__0x7fbf3be012c0__READY, 
                                            add_in0_valid => channel_0_real_vect__FROM_BUFFER_TO__0x7fbf3be012c0__VALID, 
                                            add_in0_opening => channel_0_real_vect__FROM_BUFFER_TO__0x7fbf3be012c0__DATA, 

                                            add_in1_ready => channel_1_real_vect__FROM_BUFFER_TO__0x7fbf3be012c0__READY, 
                                            add_in1_valid => channel_1_real_vect__FROM_BUFFER_TO__0x7fbf3be012c0__VALID, 
                                            add_in1_opening => channel_1_real_vect__FROM_BUFFER_TO__0x7fbf3be012c0__DATA, 

                                            add_out0_ready => channel_2_real_vect__FROM__0x7fbf3be012c0__TO_BUFFER__READY, 
                                            add_out0_valid => channel_2_real_vect__FROM__0x7fbf3be012c0__TO_BUFFER__VALID, 
                                            add_out0_opening => channel_2_real_vect__FROM__0x7fbf3be012c0__TO_BUFFER__DATA 
); 

fifo_8 : axi_fifo GENERIC MAP       (math_ram_width, 
                                    math_ram_depth 
                                    ) 
                    PORT MAP        (buf_clk => math_clk, 
                                    buf_rst => math_rst, 

                                    buf_in_ready => channel_2_real_vect__FROM__0x7fbf3be012c0__TO_BUFFER__READY, 
                                    buf_out_ready => channel_2_real_vect__FROM_BUFFER_TO__0x7fbf3be02710__READY, 

                                    buf_in_valid => channel_2_real_vect__FROM__0x7fbf3be012c0__TO_BUFFER__VALID, 
                                    buf_out_valid => channel_2_real_vect__FROM_BUFFER_TO__0x7fbf3be02710__VALID, 

                                    buf_in_data => channel_2_real_vect__FROM__0x7fbf3be012c0__TO_BUFFER__DATA, 
                                    buf_out_data => channel_2_real_vect__FROM_BUFFER_TO__0x7fbf3be02710__DATA 
); 

add_1 : add_node PORT MAP (           add_clk => math_clk, 
                                            add_rst => math_rst, 

                                            add_in0_ready => channel_3_real_vect__FROM_BUFFER_TO__0x7fbf3be017f0__READY, 
                                            add_in0_valid => channel_3_real_vect__FROM_BUFFER_TO__0x7fbf3be017f0__VALID, 
                                            add_in0_opening => channel_3_real_vect__FROM_BUFFER_TO__0x7fbf3be017f0__DATA, 

                                            add_in1_ready => channel_4_real_vect__FROM_BUFFER_TO__0x7fbf3be017f0__READY, 
                                            add_in1_valid => channel_4_real_vect__FROM_BUFFER_TO__0x7fbf3be017f0__VALID, 
                                            add_in1_opening => channel_4_real_vect__FROM_BUFFER_TO__0x7fbf3be017f0__DATA, 

                                            add_out0_ready => channel_5_real_vect__FROM__0x7fbf3be017f0__TO_BUFFER__READY, 
                                            add_out0_valid => channel_5_real_vect__FROM__0x7fbf3be017f0__TO_BUFFER__VALID, 
                                            add_out0_opening => channel_5_real_vect__FROM__0x7fbf3be017f0__TO_BUFFER__DATA 
); 

fifo_9 : axi_fifo GENERIC MAP       (math_ram_width, 
                                    math_ram_depth 
                                    ) 
                    PORT MAP        (buf_clk => math_clk, 
                                    buf_rst => math_rst, 

                                    buf_in_ready => channel_5_real_vect__FROM__0x7fbf3be017f0__TO_BUFFER__READY, 
                                    buf_out_ready => channel_5_real_vect__FROM_BUFFER_TO__0x7fbf3be02710__READY, 

                                    buf_in_valid => channel_5_real_vect__FROM__0x7fbf3be017f0__TO_BUFFER__VALID, 
                                    buf_out_valid => channel_5_real_vect__FROM_BUFFER_TO__0x7fbf3be02710__VALID, 

                                    buf_in_data => channel_5_real_vect__FROM__0x7fbf3be017f0__TO_BUFFER__DATA, 
                                    buf_out_data => channel_5_real_vect__FROM_BUFFER_TO__0x7fbf3be02710__DATA 
); 

add_2 : add_node PORT MAP (           add_clk => math_clk, 
                                            add_rst => math_rst, 

                                            add_in0_ready => channel_7_real_vect__FROM_BUFFER_TO__0x7fbf3be01d10__READY, 
                                            add_in0_valid => channel_7_real_vect__FROM_BUFFER_TO__0x7fbf3be01d10__VALID, 
                                            add_in0_opening => channel_7_real_vect__FROM_BUFFER_TO__0x7fbf3be01d10__DATA, 

                                            add_in1_ready => channel_8_real_vect__FROM_BUFFER_TO__0x7fbf3be01d10__READY, 
                                            add_in1_valid => channel_8_real_vect__FROM_BUFFER_TO__0x7fbf3be01d10__VALID, 
                                            add_in1_opening => channel_8_real_vect__FROM_BUFFER_TO__0x7fbf3be01d10__DATA, 

                                            add_out0_ready => channel_9_real_vect__FROM__0x7fbf3be01d10__TO_BUFFER__READY, 
                                            add_out0_valid => channel_9_real_vect__FROM__0x7fbf3be01d10__TO_BUFFER__VALID, 
                                            add_out0_opening => channel_9_real_vect__FROM__0x7fbf3be01d10__TO_BUFFER__DATA 
); 

fifo_10 : axi_fifo GENERIC MAP       (math_ram_width, 
                                    math_ram_depth 
                                    ) 
                    PORT MAP        (buf_clk => math_clk, 
                                    buf_rst => math_rst, 

                                    buf_in_ready => channel_9_real_vect__FROM__0x7fbf3be01d10__TO_BUFFER__READY, 
                                    buf_out_ready => channel_9_real_vect__FROM_BUFFER_TO__0x7fbf3be029a0__READY, 

                                    buf_in_valid => channel_9_real_vect__FROM__0x7fbf3be01d10__TO_BUFFER__VALID, 
                                    buf_out_valid => channel_9_real_vect__FROM_BUFFER_TO__0x7fbf3be029a0__VALID, 

                                    buf_in_data => channel_9_real_vect__FROM__0x7fbf3be01d10__TO_BUFFER__DATA, 
                                    buf_out_data => channel_9_real_vect__FROM_BUFFER_TO__0x7fbf3be029a0__DATA 
); 

add_3 : add_node PORT MAP (           add_clk => math_clk, 
                                            add_rst => math_rst, 

                                            add_in0_ready => channel_10_real_vect__FROM_BUFFER_TO__0x7fbf3be01fd0__READY, 
                                            add_in0_valid => channel_10_real_vect__FROM_BUFFER_TO__0x7fbf3be01fd0__VALID, 
                                            add_in0_opening => channel_10_real_vect__FROM_BUFFER_TO__0x7fbf3be01fd0__DATA, 

                                            add_in1_ready => channel_11_real_vect__FROM_BUFFER_TO__0x7fbf3be01fd0__READY, 
                                            add_in1_valid => channel_11_real_vect__FROM_BUFFER_TO__0x7fbf3be01fd0__VALID, 
                                            add_in1_opening => channel_11_real_vect__FROM_BUFFER_TO__0x7fbf3be01fd0__DATA, 

                                            add_out0_ready => channel_12_real_vect__FROM__0x7fbf3be01fd0__TO_BUFFER__READY, 
                                            add_out0_valid => channel_12_real_vect__FROM__0x7fbf3be01fd0__TO_BUFFER__VALID, 
                                            add_out0_opening => channel_12_real_vect__FROM__0x7fbf3be01fd0__TO_BUFFER__DATA 
); 

fifo_11 : axi_fifo GENERIC MAP       (math_ram_width, 
                                    math_ram_depth 
                                    ) 
                    PORT MAP        (buf_clk => math_clk, 
                                    buf_rst => math_rst, 

                                    buf_in_ready => channel_12_real_vect__FROM__0x7fbf3be01fd0__TO_BUFFER__READY, 
                                    buf_out_ready => channel_12_real_vect__FROM_BUFFER_TO__0x7fbf3be029a0__READY, 

                                    buf_in_valid => channel_12_real_vect__FROM__0x7fbf3be01fd0__TO_BUFFER__VALID, 
                                    buf_out_valid => channel_12_real_vect__FROM_BUFFER_TO__0x7fbf3be029a0__VALID, 

                                    buf_in_data => channel_12_real_vect__FROM__0x7fbf3be01fd0__TO_BUFFER__DATA, 
                                    buf_out_data => channel_12_real_vect__FROM_BUFFER_TO__0x7fbf3be029a0__DATA 
); 

prod_0 : prod_node PORT MAP (           prod_clk => math_clk, 
                                            prod_rst => math_rst, 

                                            prod_in0_ready => channel_2_real_vect__FROM_BUFFER_TO__0x7fbf3be02710__READY, 
                                            prod_in0_valid => channel_2_real_vect__FROM_BUFFER_TO__0x7fbf3be02710__VALID, 
                                            prod_in0_opening => channel_2_real_vect__FROM_BUFFER_TO__0x7fbf3be02710__DATA, 

                                            prod_in1_ready => channel_5_real_vect__FROM_BUFFER_TO__0x7fbf3be02710__READY, 
                                            prod_in1_valid => channel_5_real_vect__FROM_BUFFER_TO__0x7fbf3be02710__VALID, 
                                            prod_in1_opening => channel_5_real_vect__FROM_BUFFER_TO__0x7fbf3be02710__DATA, 

                                            prod_out0_ready => channel_6_real_vect__FROM__0x7fbf3be02710__TO_BUFFER__READY, 
                                            prod_out0_valid => channel_6_real_vect__FROM__0x7fbf3be02710__TO_BUFFER__VALID, 
                                            prod_out0_opening => channel_6_real_vect__FROM__0x7fbf3be02710__TO_BUFFER__DATA 
); 

fifo_12 : axi_fifo GENERIC MAP       (math_ram_width, 
                                    math_ram_depth 
                                    ) 
                    PORT MAP        (buf_clk => math_clk, 
                                    buf_rst => math_rst, 

                                    buf_in_ready => channel_6_real_vect__FROM__0x7fbf3be02710__TO_BUFFER__READY, 
                                    buf_out_ready => channel_6_real_vect__FROM_BUFFER_TO__0x7fbf3be02d20__READY, 

                                    buf_in_valid => channel_6_real_vect__FROM__0x7fbf3be02710__TO_BUFFER__VALID, 
                                    buf_out_valid => channel_6_real_vect__FROM_BUFFER_TO__0x7fbf3be02d20__VALID, 

                                    buf_in_data => channel_6_real_vect__FROM__0x7fbf3be02710__TO_BUFFER__DATA, 
                                    buf_out_data => channel_6_real_vect__FROM_BUFFER_TO__0x7fbf3be02d20__DATA 
); 

prod_1 : prod_node PORT MAP (           prod_clk => math_clk, 
                                            prod_rst => math_rst, 

                                            prod_in0_ready => channel_12_real_vect__FROM_BUFFER_TO__0x7fbf3be029a0__READY, 
                                            prod_in0_valid => channel_12_real_vect__FROM_BUFFER_TO__0x7fbf3be029a0__VALID, 
                                            prod_in0_opening => channel_12_real_vect__FROM_BUFFER_TO__0x7fbf3be029a0__DATA, 

                                            prod_in1_ready => channel_9_real_vect__FROM_BUFFER_TO__0x7fbf3be029a0__READY, 
                                            prod_in1_valid => channel_9_real_vect__FROM_BUFFER_TO__0x7fbf3be029a0__VALID, 
                                            prod_in1_opening => channel_9_real_vect__FROM_BUFFER_TO__0x7fbf3be029a0__DATA, 

                                            prod_out0_ready => channel_13_real_vect__FROM__0x7fbf3be029a0__TO_BUFFER__READY, 
                                            prod_out0_valid => channel_13_real_vect__FROM__0x7fbf3be029a0__TO_BUFFER__VALID, 
                                            prod_out0_opening => channel_13_real_vect__FROM__0x7fbf3be029a0__TO_BUFFER__DATA 
); 

fifo_13 : axi_fifo GENERIC MAP       (math_ram_width, 
                                    math_ram_depth 
                                    ) 
                    PORT MAP        (buf_clk => math_clk, 
                                    buf_rst => math_rst, 

                                    buf_in_ready => channel_13_real_vect__FROM__0x7fbf3be029a0__TO_BUFFER__READY, 
                                    buf_out_ready => channel_13_real_vect__FROM_BUFFER_TO__0x7fbf3be02d20__READY, 

                                    buf_in_valid => channel_13_real_vect__FROM__0x7fbf3be029a0__TO_BUFFER__VALID, 
                                    buf_out_valid => channel_13_real_vect__FROM_BUFFER_TO__0x7fbf3be02d20__VALID, 

                                    buf_in_data => channel_13_real_vect__FROM__0x7fbf3be029a0__TO_BUFFER__DATA, 
                                    buf_out_data => channel_13_real_vect__FROM_BUFFER_TO__0x7fbf3be02d20__DATA 
); 

div_0 : div_node PORT MAP (           div_clk => math_clk, 
                                            div_rst => math_rst, 

                                            div_in0_ready => channel_13_real_vect__FROM_BUFFER_TO__0x7fbf3be02d20__READY, 
                                            div_in0_valid => channel_13_real_vect__FROM_BUFFER_TO__0x7fbf3be02d20__VALID, 
                                            div_in0_opening => channel_13_real_vect__FROM_BUFFER_TO__0x7fbf3be02d20__DATA, 

                                            div_in1_ready => channel_6_real_vect__FROM_BUFFER_TO__0x7fbf3be02d20__READY, 
                                            div_in1_valid => channel_6_real_vect__FROM_BUFFER_TO__0x7fbf3be02d20__VALID, 
                                            div_in1_opening => channel_6_real_vect__FROM_BUFFER_TO__0x7fbf3be02d20__DATA, 

                                            div_out0_ready => channel_14_real_vect__FROM__0x7fbf3be02d20__TO_BUFFER__READY, 
                                            div_out0_valid => channel_14_real_vect__FROM__0x7fbf3be02d20__TO_BUFFER__VALID, 
                                            div_out0_opening => channel_14_real_vect__FROM__0x7fbf3be02d20__TO_BUFFER__DATA 
); 

fifo_14 : axi_fifo GENERIC MAP       (math_ram_width, 
                                    math_ram_depth 
                                    ) 
                    PORT MAP        (buf_clk => math_clk, 
                                    buf_rst => math_rst, 

                                    buf_in_ready => channel_14_real_vect__FROM__0x7fbf3be02d20__TO_BUFFER__READY, 
                                    buf_out_ready => channel_14_real_vect__FROM_BUFFER_TO__OUTPUT_0__READY, 

                                    buf_in_valid => channel_14_real_vect__FROM__0x7fbf3be02d20__TO_BUFFER__VALID, 
                                    buf_out_valid => channel_14_real_vect__FROM_BUFFER_TO__OUTPUT_0__VALID, 

                                    buf_in_data => channel_14_real_vect__FROM__0x7fbf3be02d20__TO_BUFFER__DATA, 
                                    buf_out_data => channel_14_real_vect__FROM_BUFFER_TO__OUTPUT_0__DATA 
); 

OUTPUT_0 : OUTPUT_node PORT MAP (           math_clk => OUTPUT_clk, 
                                            math_rst => OUTPUT_rst, 

                                            OUTPUT_in_ready => channel_14_real_vect__FROM_BUFFER_TO__OUTPUT_0__READY, 
                                            OUTPUT_out_ready => math_out_ready, 

                                            OUTPUT_in_valid => channel_14_real_vect__FROM_BUFFER_TO__OUTPUT_0__VALID, 
                                            OUTPUT_out_valid => math_out_valid, 

                                            OUTPUT_in_opening => channel_14_real_vect__FROM_BUFFER_TO__OUTPUT_0__READY, 
                                            OUTPUT_out_opening => math_out_data 
); 


 end math_arch; 
