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
 
        math_in0_ready : out std_logic; 
        math_in0_valid : in std_logic; 
        math_in0_data : in std_logic_vector; 
 
        math_in1_ready : out std_logic; 
        math_in1_valid : in std_logic; 
        math_in1_data : in std_logic_vector; 
 
        math_in2_ready : out std_logic; 
        math_in2_valid : in std_logic; 
        math_in2_data : in std_logic_vector; 
 
        math_in3_ready : out std_logic; 
        math_in3_valid : in std_logic; 
        math_in3_data : in std_logic_vector; 
 
        math_in4_ready : out std_logic; 
        math_in4_valid : in std_logic; 
        math_in4_data : in std_logic_vector; 
 
        math_in5_ready : out std_logic; 
        math_in5_valid : in std_logic; 
        math_in5_data : in std_logic_vector; 
 
        math_in6_ready : out std_logic; 
        math_in6_valid : in std_logic; 
        math_in6_data : in std_logic_vector; 
 
        math_in7_ready : out std_logic; 
        math_in7_valid : in std_logic; 
        math_in7_data : in std_logic_vector; 
 
        math_out0_ready : in std_logic; 
        math_out0_valid : out std_logic; 
        math_out0_data : out std_logic_vector 
    ); 
end; 
 
architecture math_arch of math is 


    component INPUT_node is 
        port ( 

            INPUT_clk : in std_logic; 
            INPUT_rst : in std_logic; 


            INPUT_in_ready : out std_logic; 
            INPUT_out_ready : in std_logic; 

            INPUT_in_valid : in std_logic; 
            INPUT_out_valid : out std_logic; 

            INPUT_in_opening : in std_logic_vector(math_ram_width - 1 downto 0); 
            INPUT_out_opening : out std_logic_vector(math_ram_width - 1 downto 0) 
    ); end component; 

    component add_node is 
        port ( 

            add_clk : in std_logic; 
            add_rst : in std_logic; 

            --Input1 
            add_in0_ready : out std_logic; 

            add_in0_valid : in std_logic; 

            add_in0_opening : in std_logic_vector(math_ram_width - 1 downto 0); 


            --Input2 
            add_in1_ready : out std_logic; 

            add_in1_valid : in std_logic; 

            add_in1_opening : in std_logic_vector(math_ram_width - 1 downto 0); 


            --Output 
            add_out_ready : in std_logic; 

            add_out_valid : out std_logic; 

            add_out_opening : out std_logic_vector(math_ram_width - 1 downto 0) 
    ); end component; 

    component prod_node is 
        port ( 

            prod_clk : in std_logic; 
            prod_rst : in std_logic; 

            --Input1 
            prod_in0_ready : out std_logic; 

            prod_in0_valid : in std_logic; 

            prod_in0_opening : in std_logic_vector(math_ram_width - 1 downto 0); 


            --Input2 
            prod_in1_ready : out std_logic; 

            prod_in1_valid : in std_logic; 

            prod_in1_opening : in std_logic_vector(math_ram_width - 1 downto 0); 


            --Output 
            prod_out_ready : in std_logic; 

            prod_out_valid : out std_logic; 

            prod_out_opening : out std_logic_vector(math_ram_width - 1 downto 0) 
    ); end component; 

    component div_node is 
        port ( 

            div_clk : in std_logic; 
            div_rst : in std_logic; 

            --Input1 
            div_in0_ready : out std_logic; 

            div_in0_valid : in std_logic; 

            div_in0_opening : in std_logic_vector(math_ram_width - 1 downto 0); 


            --Input2 
            div_in1_ready : out std_logic; 

            div_in1_valid : in std_logic; 

            div_in1_opening : in std_logic_vector(math_ram_width - 1 downto 0); 


            --Output 
            div_out_ready : in std_logic; 

            div_out_valid : out std_logic; 

            div_out_opening : out std_logic_vector(math_ram_width - 1 downto 0) 
    ); end component; 

    component OUTPUT_node is 
        port ( 

            OUTPUT_clk : in std_logic; 
            OUTPUT_rst : in std_logic; 


            OUTPUT_in_ready : out std_logic; 
            OUTPUT_out_ready : in std_logic; 

            OUTPUT_in_valid : in std_logic; 
            OUTPUT_out_valid : out std_logic; 

            OUTPUT_in_opening : in std_logic_vector(math_ram_width - 1 downto 0); 
            OUTPUT_out_opening : out std_logic_vector(math_ram_width - 1 downto 0) 
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


signal channel_0_real_vectoooFROMooo0x7fbf3be00080oooTO_BUFFERoooDATA, channel_0_real_vectoooFROM_BUFFER_TOooo0x7fbf3be012c0oooDATA, channel_10_real_vectoooFROMooo0x7fbf3be00580oooTO_BUFFERoooDATA, channel_10_real_vectoooFROM_BUFFER_TOooo0x7fbf3be01fd0oooDATA, channel_11_real_vectoooFROMooo0x7fbf3be006f0oooTO_BUFFERoooDATA, channel_11_real_vectoooFROM_BUFFER_TOooo0x7fbf3be01fd0oooDATA, channel_12_real_vectoooFROMooo0x7fbf3be01fd0oooTO_BUFFERoooDATA, channel_12_real_vectoooFROM_BUFFER_TOooo0x7fbf3be029a0oooDATA, channel_13_real_vectoooFROMooo0x7fbf3be029a0oooTO_BUFFERoooDATA, channel_13_real_vectoooFROM_BUFFER_TOooo0x7fbf3be02d20oooDATA, channel_14_real_vectoooFROMooo0x7fbf3be02d20oooTO_BUFFERoooDATA, channel_14_real_vectoooFROM_BUFFER_TOoooOUTPUT_0oooDATA, channel_1_real_vectoooFROMooo0x7fbf3be00140oooTO_BUFFERoooDATA, channel_1_real_vectoooFROM_BUFFER_TOooo0x7fbf3be012c0oooDATA, channel_2_real_vectoooFROMooo0x7fbf3be012c0oooTO_BUFFERoooDATA, channel_2_real_vectoooFROM_BUFFER_TOooo0x7fbf3be02710oooDATA, channel_3_real_vectoooFROMooo0x7fbf3be001d0oooTO_BUFFERoooDATA, channel_3_real_vectoooFROM_BUFFER_TOooo0x7fbf3be017f0oooDATA, channel_4_real_vectoooFROMooo0x7fbf3be00290oooTO_BUFFERoooDATA, channel_4_real_vectoooFROM_BUFFER_TOooo0x7fbf3be017f0oooDATA, channel_5_real_vectoooFROMooo0x7fbf3be017f0oooTO_BUFFERoooDATA, channel_5_real_vectoooFROM_BUFFER_TOooo0x7fbf3be02710oooDATA, channel_6_real_vectoooFROMooo0x7fbf3be02710oooTO_BUFFERoooDATA, channel_6_real_vectoooFROM_BUFFER_TOooo0x7fbf3be02d20oooDATA, channel_7_real_vectoooFROMooo0x7fbf3be00350oooTO_BUFFERoooDATA, channel_7_real_vectoooFROM_BUFFER_TOooo0x7fbf3be01d10oooDATA, channel_8_real_vectoooFROMooo0x7fbf3be004c0oooTO_BUFFERoooDATA, channel_8_real_vectoooFROM_BUFFER_TOooo0x7fbf3be01d10oooDATA, channel_9_real_vectoooFROMooo0x7fbf3be01d10oooTO_BUFFERoooDATA, channel_9_real_vectoooFROM_BUFFER_TOooo0x7fbf3be029a0oooDATA : std_logic_vector(math_ram_width - 1 downto 0); 
signal channel_0_real_vectoooFROMooo0x7fbf3be00080oooTO_BUFFERoooREADY, channel_0_real_vectoooFROM_BUFFER_TOooo0x7fbf3be012c0oooREADY, channel_0_real_vectoooFROMooo0x7fbf3be00080oooTO_BUFFERoooVALID, channel_0_real_vectoooFROM_BUFFER_TOooo0x7fbf3be012c0oooVALID, channel_10_real_vectoooFROMooo0x7fbf3be00580oooTO_BUFFERoooREADY, channel_10_real_vectoooFROM_BUFFER_TOooo0x7fbf3be01fd0oooREADY, channel_10_real_vectoooFROMooo0x7fbf3be00580oooTO_BUFFERoooVALID, channel_10_real_vectoooFROM_BUFFER_TOooo0x7fbf3be01fd0oooVALID, channel_11_real_vectoooFROMooo0x7fbf3be006f0oooTO_BUFFERoooREADY, channel_11_real_vectoooFROM_BUFFER_TOooo0x7fbf3be01fd0oooREADY, channel_11_real_vectoooFROMooo0x7fbf3be006f0oooTO_BUFFERoooVALID, channel_11_real_vectoooFROM_BUFFER_TOooo0x7fbf3be01fd0oooVALID, channel_12_real_vectoooFROMooo0x7fbf3be01fd0oooTO_BUFFERoooREADY, channel_12_real_vectoooFROM_BUFFER_TOooo0x7fbf3be029a0oooREADY, channel_12_real_vectoooFROMooo0x7fbf3be01fd0oooTO_BUFFERoooVALID, channel_12_real_vectoooFROM_BUFFER_TOooo0x7fbf3be029a0oooVALID, channel_13_real_vectoooFROMooo0x7fbf3be029a0oooTO_BUFFERoooREADY, channel_13_real_vectoooFROM_BUFFER_TOooo0x7fbf3be02d20oooREADY, channel_13_real_vectoooFROMooo0x7fbf3be029a0oooTO_BUFFERoooVALID, channel_13_real_vectoooFROM_BUFFER_TOooo0x7fbf3be02d20oooVALID, channel_14_real_vectoooFROMooo0x7fbf3be02d20oooTO_BUFFERoooREADY, channel_14_real_vectoooFROM_BUFFER_TOoooOUTPUT_0oooREADY, channel_14_real_vectoooFROMooo0x7fbf3be02d20oooTO_BUFFERoooVALID, channel_14_real_vectoooFROM_BUFFER_TOoooOUTPUT_0oooVALID, channel_1_real_vectoooFROMooo0x7fbf3be00140oooTO_BUFFERoooREADY, channel_1_real_vectoooFROM_BUFFER_TOooo0x7fbf3be012c0oooREADY, channel_1_real_vectoooFROMooo0x7fbf3be00140oooTO_BUFFERoooVALID, channel_1_real_vectoooFROM_BUFFER_TOooo0x7fbf3be012c0oooVALID, channel_2_real_vectoooFROMooo0x7fbf3be012c0oooTO_BUFFERoooREADY, channel_2_real_vectoooFROM_BUFFER_TOooo0x7fbf3be02710oooREADY, channel_2_real_vectoooFROMooo0x7fbf3be012c0oooTO_BUFFERoooVALID, channel_2_real_vectoooFROM_BUFFER_TOooo0x7fbf3be02710oooVALID, channel_3_real_vectoooFROMooo0x7fbf3be001d0oooTO_BUFFERoooREADY, channel_3_real_vectoooFROM_BUFFER_TOooo0x7fbf3be017f0oooREADY, channel_3_real_vectoooFROMooo0x7fbf3be001d0oooTO_BUFFERoooVALID, channel_3_real_vectoooFROM_BUFFER_TOooo0x7fbf3be017f0oooVALID, channel_4_real_vectoooFROMooo0x7fbf3be00290oooTO_BUFFERoooREADY, channel_4_real_vectoooFROM_BUFFER_TOooo0x7fbf3be017f0oooREADY, channel_4_real_vectoooFROMooo0x7fbf3be00290oooTO_BUFFERoooVALID, channel_4_real_vectoooFROM_BUFFER_TOooo0x7fbf3be017f0oooVALID, channel_5_real_vectoooFROMooo0x7fbf3be017f0oooTO_BUFFERoooREADY, channel_5_real_vectoooFROM_BUFFER_TOooo0x7fbf3be02710oooREADY, channel_5_real_vectoooFROMooo0x7fbf3be017f0oooTO_BUFFERoooVALID, channel_5_real_vectoooFROM_BUFFER_TOooo0x7fbf3be02710oooVALID, channel_6_real_vectoooFROMooo0x7fbf3be02710oooTO_BUFFERoooREADY, channel_6_real_vectoooFROM_BUFFER_TOooo0x7fbf3be02d20oooREADY, channel_6_real_vectoooFROMooo0x7fbf3be02710oooTO_BUFFERoooVALID, channel_6_real_vectoooFROM_BUFFER_TOooo0x7fbf3be02d20oooVALID, channel_7_real_vectoooFROMooo0x7fbf3be00350oooTO_BUFFERoooREADY, channel_7_real_vectoooFROM_BUFFER_TOooo0x7fbf3be01d10oooREADY, channel_7_real_vectoooFROMooo0x7fbf3be00350oooTO_BUFFERoooVALID, channel_7_real_vectoooFROM_BUFFER_TOooo0x7fbf3be01d10oooVALID, channel_8_real_vectoooFROMooo0x7fbf3be004c0oooTO_BUFFERoooREADY, channel_8_real_vectoooFROM_BUFFER_TOooo0x7fbf3be01d10oooREADY, channel_8_real_vectoooFROMooo0x7fbf3be004c0oooTO_BUFFERoooVALID, channel_8_real_vectoooFROM_BUFFER_TOooo0x7fbf3be01d10oooVALID, channel_9_real_vectoooFROMooo0x7fbf3be01d10oooTO_BUFFERoooREADY, channel_9_real_vectoooFROM_BUFFER_TOooo0x7fbf3be029a0oooREADY, channel_9_real_vectoooFROMooo0x7fbf3be01d10oooTO_BUFFERoooVALID, channel_9_real_vectoooFROM_BUFFER_TOooo0x7fbf3be029a0oooVALID : std_logic; 


begin 

INPUT_0 : INPUT_node PORT MAP (     INPUT_clk => math_clk, 
                                    INPUT_rst => math_rst, 

                                    INPUT_in_ready => math_in0_ready, 
                                    INPUT_out_ready => channel_0_real_vectoooFROMooo0x7fbf3be00080oooTO_BUFFERoooREADY, 

                                    INPUT_in_valid => math_in0_valid, 
                                    INPUT_out_valid => channel_0_real_vectoooFROMooo0x7fbf3be00080oooTO_BUFFERoooVALID, 

                                    INPUT_in_opening => math_in0_data, 
                                    INPUT_out_opening => channel_0_real_vectoooFROMooo0x7fbf3be00080oooTO_BUFFERoooDATA 
); 

fifo_0 : axi_fifo GENERIC MAP       (math_ram_width, 
                                    math_ram_depth 
                                    ) 
                    PORT MAP        (buf_clk => math_clk, 
                                    buf_rst => math_rst, 

                                    buf_in_ready => channel_0_real_vectoooFROMooo0x7fbf3be00080oooTO_BUFFERoooREADY, 
                                    buf_out_ready => channel_0_real_vectoooFROM_BUFFER_TOooo0x7fbf3be012c0oooREADY, 

                                    buf_in_valid => channel_0_real_vectoooFROMooo0x7fbf3be00080oooTO_BUFFERoooVALID, 
                                    buf_out_valid => channel_0_real_vectoooFROM_BUFFER_TOooo0x7fbf3be012c0oooVALID, 

                                    buf_in_data => channel_0_real_vectoooFROMooo0x7fbf3be00080oooTO_BUFFERoooDATA, 
                                    buf_out_data => channel_0_real_vectoooFROM_BUFFER_TOooo0x7fbf3be012c0oooDATA 
); 

INPUT_1 : INPUT_node PORT MAP (     INPUT_clk => math_clk, 
                                    INPUT_rst => math_rst, 

                                    INPUT_in_ready => math_in1_ready, 
                                    INPUT_out_ready => channel_1_real_vectoooFROMooo0x7fbf3be00140oooTO_BUFFERoooREADY, 

                                    INPUT_in_valid => math_in1_valid, 
                                    INPUT_out_valid => channel_1_real_vectoooFROMooo0x7fbf3be00140oooTO_BUFFERoooVALID, 

                                    INPUT_in_opening => math_in1_data, 
                                    INPUT_out_opening => channel_1_real_vectoooFROMooo0x7fbf3be00140oooTO_BUFFERoooDATA 
); 

fifo_1 : axi_fifo GENERIC MAP       (math_ram_width, 
                                    math_ram_depth 
                                    ) 
                    PORT MAP        (buf_clk => math_clk, 
                                    buf_rst => math_rst, 

                                    buf_in_ready => channel_1_real_vectoooFROMooo0x7fbf3be00140oooTO_BUFFERoooREADY, 
                                    buf_out_ready => channel_1_real_vectoooFROM_BUFFER_TOooo0x7fbf3be012c0oooREADY, 

                                    buf_in_valid => channel_1_real_vectoooFROMooo0x7fbf3be00140oooTO_BUFFERoooVALID, 
                                    buf_out_valid => channel_1_real_vectoooFROM_BUFFER_TOooo0x7fbf3be012c0oooVALID, 

                                    buf_in_data => channel_1_real_vectoooFROMooo0x7fbf3be00140oooTO_BUFFERoooDATA, 
                                    buf_out_data => channel_1_real_vectoooFROM_BUFFER_TOooo0x7fbf3be012c0oooDATA 
); 

INPUT_2 : INPUT_node PORT MAP (     INPUT_clk => math_clk, 
                                    INPUT_rst => math_rst, 

                                    INPUT_in_ready => math_in2_ready, 
                                    INPUT_out_ready => channel_3_real_vectoooFROMooo0x7fbf3be001d0oooTO_BUFFERoooREADY, 

                                    INPUT_in_valid => math_in2_valid, 
                                    INPUT_out_valid => channel_3_real_vectoooFROMooo0x7fbf3be001d0oooTO_BUFFERoooVALID, 

                                    INPUT_in_opening => math_in2_data, 
                                    INPUT_out_opening => channel_3_real_vectoooFROMooo0x7fbf3be001d0oooTO_BUFFERoooDATA 
); 

fifo_2 : axi_fifo GENERIC MAP       (math_ram_width, 
                                    math_ram_depth 
                                    ) 
                    PORT MAP        (buf_clk => math_clk, 
                                    buf_rst => math_rst, 

                                    buf_in_ready => channel_3_real_vectoooFROMooo0x7fbf3be001d0oooTO_BUFFERoooREADY, 
                                    buf_out_ready => channel_3_real_vectoooFROM_BUFFER_TOooo0x7fbf3be017f0oooREADY, 

                                    buf_in_valid => channel_3_real_vectoooFROMooo0x7fbf3be001d0oooTO_BUFFERoooVALID, 
                                    buf_out_valid => channel_3_real_vectoooFROM_BUFFER_TOooo0x7fbf3be017f0oooVALID, 

                                    buf_in_data => channel_3_real_vectoooFROMooo0x7fbf3be001d0oooTO_BUFFERoooDATA, 
                                    buf_out_data => channel_3_real_vectoooFROM_BUFFER_TOooo0x7fbf3be017f0oooDATA 
); 

INPUT_3 : INPUT_node PORT MAP (     INPUT_clk => math_clk, 
                                    INPUT_rst => math_rst, 

                                    INPUT_in_ready => math_in3_ready, 
                                    INPUT_out_ready => channel_4_real_vectoooFROMooo0x7fbf3be00290oooTO_BUFFERoooREADY, 

                                    INPUT_in_valid => math_in3_valid, 
                                    INPUT_out_valid => channel_4_real_vectoooFROMooo0x7fbf3be00290oooTO_BUFFERoooVALID, 

                                    INPUT_in_opening => math_in3_data, 
                                    INPUT_out_opening => channel_4_real_vectoooFROMooo0x7fbf3be00290oooTO_BUFFERoooDATA 
); 

fifo_3 : axi_fifo GENERIC MAP       (math_ram_width, 
                                    math_ram_depth 
                                    ) 
                    PORT MAP        (buf_clk => math_clk, 
                                    buf_rst => math_rst, 

                                    buf_in_ready => channel_4_real_vectoooFROMooo0x7fbf3be00290oooTO_BUFFERoooREADY, 
                                    buf_out_ready => channel_4_real_vectoooFROM_BUFFER_TOooo0x7fbf3be017f0oooREADY, 

                                    buf_in_valid => channel_4_real_vectoooFROMooo0x7fbf3be00290oooTO_BUFFERoooVALID, 
                                    buf_out_valid => channel_4_real_vectoooFROM_BUFFER_TOooo0x7fbf3be017f0oooVALID, 

                                    buf_in_data => channel_4_real_vectoooFROMooo0x7fbf3be00290oooTO_BUFFERoooDATA, 
                                    buf_out_data => channel_4_real_vectoooFROM_BUFFER_TOooo0x7fbf3be017f0oooDATA 
); 

INPUT_4 : INPUT_node PORT MAP (     INPUT_clk => math_clk, 
                                    INPUT_rst => math_rst, 

                                    INPUT_in_ready => math_in4_ready, 
                                    INPUT_out_ready => channel_7_real_vectoooFROMooo0x7fbf3be00350oooTO_BUFFERoooREADY, 

                                    INPUT_in_valid => math_in4_valid, 
                                    INPUT_out_valid => channel_7_real_vectoooFROMooo0x7fbf3be00350oooTO_BUFFERoooVALID, 

                                    INPUT_in_opening => math_in4_data, 
                                    INPUT_out_opening => channel_7_real_vectoooFROMooo0x7fbf3be00350oooTO_BUFFERoooDATA 
); 

fifo_4 : axi_fifo GENERIC MAP       (math_ram_width, 
                                    math_ram_depth 
                                    ) 
                    PORT MAP        (buf_clk => math_clk, 
                                    buf_rst => math_rst, 

                                    buf_in_ready => channel_7_real_vectoooFROMooo0x7fbf3be00350oooTO_BUFFERoooREADY, 
                                    buf_out_ready => channel_7_real_vectoooFROM_BUFFER_TOooo0x7fbf3be01d10oooREADY, 

                                    buf_in_valid => channel_7_real_vectoooFROMooo0x7fbf3be00350oooTO_BUFFERoooVALID, 
                                    buf_out_valid => channel_7_real_vectoooFROM_BUFFER_TOooo0x7fbf3be01d10oooVALID, 

                                    buf_in_data => channel_7_real_vectoooFROMooo0x7fbf3be00350oooTO_BUFFERoooDATA, 
                                    buf_out_data => channel_7_real_vectoooFROM_BUFFER_TOooo0x7fbf3be01d10oooDATA 
); 

INPUT_5 : INPUT_node PORT MAP (     INPUT_clk => math_clk, 
                                    INPUT_rst => math_rst, 

                                    INPUT_in_ready => math_in5_ready, 
                                    INPUT_out_ready => channel_8_real_vectoooFROMooo0x7fbf3be004c0oooTO_BUFFERoooREADY, 

                                    INPUT_in_valid => math_in5_valid, 
                                    INPUT_out_valid => channel_8_real_vectoooFROMooo0x7fbf3be004c0oooTO_BUFFERoooVALID, 

                                    INPUT_in_opening => math_in5_data, 
                                    INPUT_out_opening => channel_8_real_vectoooFROMooo0x7fbf3be004c0oooTO_BUFFERoooDATA 
); 

fifo_5 : axi_fifo GENERIC MAP       (math_ram_width, 
                                    math_ram_depth 
                                    ) 
                    PORT MAP        (buf_clk => math_clk, 
                                    buf_rst => math_rst, 

                                    buf_in_ready => channel_8_real_vectoooFROMooo0x7fbf3be004c0oooTO_BUFFERoooREADY, 
                                    buf_out_ready => channel_8_real_vectoooFROM_BUFFER_TOooo0x7fbf3be01d10oooREADY, 

                                    buf_in_valid => channel_8_real_vectoooFROMooo0x7fbf3be004c0oooTO_BUFFERoooVALID, 
                                    buf_out_valid => channel_8_real_vectoooFROM_BUFFER_TOooo0x7fbf3be01d10oooVALID, 

                                    buf_in_data => channel_8_real_vectoooFROMooo0x7fbf3be004c0oooTO_BUFFERoooDATA, 
                                    buf_out_data => channel_8_real_vectoooFROM_BUFFER_TOooo0x7fbf3be01d10oooDATA 
); 

INPUT_6 : INPUT_node PORT MAP (     INPUT_clk => math_clk, 
                                    INPUT_rst => math_rst, 

                                    INPUT_in_ready => math_in6_ready, 
                                    INPUT_out_ready => channel_10_real_vectoooFROMooo0x7fbf3be00580oooTO_BUFFERoooREADY, 

                                    INPUT_in_valid => math_in6_valid, 
                                    INPUT_out_valid => channel_10_real_vectoooFROMooo0x7fbf3be00580oooTO_BUFFERoooVALID, 

                                    INPUT_in_opening => math_in6_data, 
                                    INPUT_out_opening => channel_10_real_vectoooFROMooo0x7fbf3be00580oooTO_BUFFERoooDATA 
); 

fifo_6 : axi_fifo GENERIC MAP       (math_ram_width, 
                                    math_ram_depth 
                                    ) 
                    PORT MAP        (buf_clk => math_clk, 
                                    buf_rst => math_rst, 

                                    buf_in_ready => channel_10_real_vectoooFROMooo0x7fbf3be00580oooTO_BUFFERoooREADY, 
                                    buf_out_ready => channel_10_real_vectoooFROM_BUFFER_TOooo0x7fbf3be01fd0oooREADY, 

                                    buf_in_valid => channel_10_real_vectoooFROMooo0x7fbf3be00580oooTO_BUFFERoooVALID, 
                                    buf_out_valid => channel_10_real_vectoooFROM_BUFFER_TOooo0x7fbf3be01fd0oooVALID, 

                                    buf_in_data => channel_10_real_vectoooFROMooo0x7fbf3be00580oooTO_BUFFERoooDATA, 
                                    buf_out_data => channel_10_real_vectoooFROM_BUFFER_TOooo0x7fbf3be01fd0oooDATA 
); 

INPUT_7 : INPUT_node PORT MAP (     INPUT_clk => math_clk, 
                                    INPUT_rst => math_rst, 

                                    INPUT_in_ready => math_in7_ready, 
                                    INPUT_out_ready => channel_11_real_vectoooFROMooo0x7fbf3be006f0oooTO_BUFFERoooREADY, 

                                    INPUT_in_valid => math_in7_valid, 
                                    INPUT_out_valid => channel_11_real_vectoooFROMooo0x7fbf3be006f0oooTO_BUFFERoooVALID, 

                                    INPUT_in_opening => math_in7_data, 
                                    INPUT_out_opening => channel_11_real_vectoooFROMooo0x7fbf3be006f0oooTO_BUFFERoooDATA 
); 

fifo_7 : axi_fifo GENERIC MAP       (math_ram_width, 
                                    math_ram_depth 
                                    ) 
                    PORT MAP        (buf_clk => math_clk, 
                                    buf_rst => math_rst, 

                                    buf_in_ready => channel_11_real_vectoooFROMooo0x7fbf3be006f0oooTO_BUFFERoooREADY, 
                                    buf_out_ready => channel_11_real_vectoooFROM_BUFFER_TOooo0x7fbf3be01fd0oooREADY, 

                                    buf_in_valid => channel_11_real_vectoooFROMooo0x7fbf3be006f0oooTO_BUFFERoooVALID, 
                                    buf_out_valid => channel_11_real_vectoooFROM_BUFFER_TOooo0x7fbf3be01fd0oooVALID, 

                                    buf_in_data => channel_11_real_vectoooFROMooo0x7fbf3be006f0oooTO_BUFFERoooDATA, 
                                    buf_out_data => channel_11_real_vectoooFROM_BUFFER_TOooo0x7fbf3be01fd0oooDATA 
); 

add_0 : add_node PORT MAP (         add_clk => math_clk, 
                                    add_rst => math_rst, 

                                    add_in0_ready => channel_1_real_vectoooFROM_BUFFER_TOooo0x7fbf3be012c0oooREADY, 
                                    add_in0_valid => channel_1_real_vectoooFROM_BUFFER_TOooo0x7fbf3be012c0oooVALID, 
                                    add_in0_opening => channel_1_real_vectoooFROM_BUFFER_TOooo0x7fbf3be012c0oooDATA, 

                                    add_in1_ready => channel_0_real_vectoooFROM_BUFFER_TOooo0x7fbf3be012c0oooREADY, 
                                    add_in1_valid => channel_0_real_vectoooFROM_BUFFER_TOooo0x7fbf3be012c0oooVALID, 
                                    add_in1_opening => channel_0_real_vectoooFROM_BUFFER_TOooo0x7fbf3be012c0oooDATA, 

                                    add_out_ready => channel_0_real_vectoooFROMooo0x7fbf3be00080oooTO_BUFFERoooREADY, 
                                    add_out_valid => channel_2_real_vectoooFROMooo0x7fbf3be012c0oooTO_BUFFERoooVALID, 
                                    add_out_opening => channel_2_real_vectoooFROMooo0x7fbf3be012c0oooTO_BUFFERoooDATA 
); 

fifo_8 : axi_fifo GENERIC MAP       (math_ram_width, 
                                    math_ram_depth 
                                    ) 
                    PORT MAP        (buf_clk => math_clk, 
                                    buf_rst => math_rst, 

                                    buf_in_ready => channel_0_real_vectoooFROMooo0x7fbf3be00080oooTO_BUFFERoooREADY, 
                                    buf_out_ready => channel_2_real_vectoooFROM_BUFFER_TOooo0x7fbf3be02710oooREADY, 

                                    buf_in_valid => channel_2_real_vectoooFROMooo0x7fbf3be012c0oooTO_BUFFERoooVALID, 
                                    buf_out_valid => channel_2_real_vectoooFROM_BUFFER_TOooo0x7fbf3be02710oooVALID, 

                                    buf_in_data => channel_2_real_vectoooFROMooo0x7fbf3be012c0oooTO_BUFFERoooDATA, 
                                    buf_out_data => channel_2_real_vectoooFROM_BUFFER_TOooo0x7fbf3be02710oooDATA 
); 

add_1 : add_node PORT MAP (         add_clk => math_clk, 
                                    add_rst => math_rst, 

                                    add_in0_ready => channel_3_real_vectoooFROM_BUFFER_TOooo0x7fbf3be017f0oooREADY, 
                                    add_in0_valid => channel_3_real_vectoooFROM_BUFFER_TOooo0x7fbf3be017f0oooVALID, 
                                    add_in0_opening => channel_3_real_vectoooFROM_BUFFER_TOooo0x7fbf3be017f0oooDATA, 

                                    add_in1_ready => channel_4_real_vectoooFROM_BUFFER_TOooo0x7fbf3be017f0oooREADY, 
                                    add_in1_valid => channel_4_real_vectoooFROM_BUFFER_TOooo0x7fbf3be017f0oooVALID, 
                                    add_in1_opening => channel_4_real_vectoooFROM_BUFFER_TOooo0x7fbf3be017f0oooDATA, 

                                    add_out_ready => channel_0_real_vectoooFROMooo0x7fbf3be00080oooTO_BUFFERoooREADY, 
                                    add_out_valid => channel_5_real_vectoooFROMooo0x7fbf3be017f0oooTO_BUFFERoooVALID, 
                                    add_out_opening => channel_5_real_vectoooFROMooo0x7fbf3be017f0oooTO_BUFFERoooDATA 
); 

fifo_9 : axi_fifo GENERIC MAP       (math_ram_width, 
                                    math_ram_depth 
                                    ) 
                    PORT MAP        (buf_clk => math_clk, 
                                    buf_rst => math_rst, 

                                    buf_in_ready => channel_0_real_vectoooFROMooo0x7fbf3be00080oooTO_BUFFERoooREADY, 
                                    buf_out_ready => channel_5_real_vectoooFROM_BUFFER_TOooo0x7fbf3be02710oooREADY, 

                                    buf_in_valid => channel_5_real_vectoooFROMooo0x7fbf3be017f0oooTO_BUFFERoooVALID, 
                                    buf_out_valid => channel_5_real_vectoooFROM_BUFFER_TOooo0x7fbf3be02710oooVALID, 

                                    buf_in_data => channel_5_real_vectoooFROMooo0x7fbf3be017f0oooTO_BUFFERoooDATA, 
                                    buf_out_data => channel_5_real_vectoooFROM_BUFFER_TOooo0x7fbf3be02710oooDATA 
); 

add_2 : add_node PORT MAP (         add_clk => math_clk, 
                                    add_rst => math_rst, 

                                    add_in0_ready => channel_7_real_vectoooFROM_BUFFER_TOooo0x7fbf3be01d10oooREADY, 
                                    add_in0_valid => channel_7_real_vectoooFROM_BUFFER_TOooo0x7fbf3be01d10oooVALID, 
                                    add_in0_opening => channel_7_real_vectoooFROM_BUFFER_TOooo0x7fbf3be01d10oooDATA, 

                                    add_in1_ready => channel_8_real_vectoooFROM_BUFFER_TOooo0x7fbf3be01d10oooREADY, 
                                    add_in1_valid => channel_8_real_vectoooFROM_BUFFER_TOooo0x7fbf3be01d10oooVALID, 
                                    add_in1_opening => channel_8_real_vectoooFROM_BUFFER_TOooo0x7fbf3be01d10oooDATA, 

                                    add_out_ready => channel_0_real_vectoooFROMooo0x7fbf3be00080oooTO_BUFFERoooREADY, 
                                    add_out_valid => channel_9_real_vectoooFROMooo0x7fbf3be01d10oooTO_BUFFERoooVALID, 
                                    add_out_opening => channel_9_real_vectoooFROMooo0x7fbf3be01d10oooTO_BUFFERoooDATA 
); 

fifo_10 : axi_fifo GENERIC MAP       (math_ram_width, 
                                    math_ram_depth 
                                    ) 
                    PORT MAP        (buf_clk => math_clk, 
                                    buf_rst => math_rst, 

                                    buf_in_ready => channel_0_real_vectoooFROMooo0x7fbf3be00080oooTO_BUFFERoooREADY, 
                                    buf_out_ready => channel_9_real_vectoooFROM_BUFFER_TOooo0x7fbf3be029a0oooREADY, 

                                    buf_in_valid => channel_9_real_vectoooFROMooo0x7fbf3be01d10oooTO_BUFFERoooVALID, 
                                    buf_out_valid => channel_9_real_vectoooFROM_BUFFER_TOooo0x7fbf3be029a0oooVALID, 

                                    buf_in_data => channel_9_real_vectoooFROMooo0x7fbf3be01d10oooTO_BUFFERoooDATA, 
                                    buf_out_data => channel_9_real_vectoooFROM_BUFFER_TOooo0x7fbf3be029a0oooDATA 
); 

add_3 : add_node PORT MAP (         add_clk => math_clk, 
                                    add_rst => math_rst, 

                                    add_in0_ready => channel_10_real_vectoooFROM_BUFFER_TOooo0x7fbf3be01fd0oooREADY, 
                                    add_in0_valid => channel_10_real_vectoooFROM_BUFFER_TOooo0x7fbf3be01fd0oooVALID, 
                                    add_in0_opening => channel_10_real_vectoooFROM_BUFFER_TOooo0x7fbf3be01fd0oooDATA, 

                                    add_in1_ready => channel_11_real_vectoooFROM_BUFFER_TOooo0x7fbf3be01fd0oooREADY, 
                                    add_in1_valid => channel_11_real_vectoooFROM_BUFFER_TOooo0x7fbf3be01fd0oooVALID, 
                                    add_in1_opening => channel_11_real_vectoooFROM_BUFFER_TOooo0x7fbf3be01fd0oooDATA, 

                                    add_out_ready => channel_0_real_vectoooFROMooo0x7fbf3be00080oooTO_BUFFERoooREADY, 
                                    add_out_valid => channel_12_real_vectoooFROMooo0x7fbf3be01fd0oooTO_BUFFERoooVALID, 
                                    add_out_opening => channel_12_real_vectoooFROMooo0x7fbf3be01fd0oooTO_BUFFERoooDATA 
); 

fifo_11 : axi_fifo GENERIC MAP       (math_ram_width, 
                                    math_ram_depth 
                                    ) 
                    PORT MAP        (buf_clk => math_clk, 
                                    buf_rst => math_rst, 

                                    buf_in_ready => channel_0_real_vectoooFROMooo0x7fbf3be00080oooTO_BUFFERoooREADY, 
                                    buf_out_ready => channel_12_real_vectoooFROM_BUFFER_TOooo0x7fbf3be029a0oooREADY, 

                                    buf_in_valid => channel_12_real_vectoooFROMooo0x7fbf3be01fd0oooTO_BUFFERoooVALID, 
                                    buf_out_valid => channel_12_real_vectoooFROM_BUFFER_TOooo0x7fbf3be029a0oooVALID, 

                                    buf_in_data => channel_12_real_vectoooFROMooo0x7fbf3be01fd0oooTO_BUFFERoooDATA, 
                                    buf_out_data => channel_12_real_vectoooFROM_BUFFER_TOooo0x7fbf3be029a0oooDATA 
); 

prod_0 : prod_node PORT MAP (         prod_clk => math_clk, 
                                    prod_rst => math_rst, 

                                    prod_in0_ready => channel_2_real_vectoooFROM_BUFFER_TOooo0x7fbf3be02710oooREADY, 
                                    prod_in0_valid => channel_2_real_vectoooFROM_BUFFER_TOooo0x7fbf3be02710oooVALID, 
                                    prod_in0_opening => channel_2_real_vectoooFROM_BUFFER_TOooo0x7fbf3be02710oooDATA, 

                                    prod_in1_ready => channel_5_real_vectoooFROM_BUFFER_TOooo0x7fbf3be02710oooREADY, 
                                    prod_in1_valid => channel_5_real_vectoooFROM_BUFFER_TOooo0x7fbf3be02710oooVALID, 
                                    prod_in1_opening => channel_5_real_vectoooFROM_BUFFER_TOooo0x7fbf3be02710oooDATA, 

                                    prod_out_ready => channel_6_real_vectoooFROMooo0x7fbf3be02710oooTO_BUFFERoooREADY, 
                                    prod_out_valid => channel_6_real_vectoooFROMooo0x7fbf3be02710oooTO_BUFFERoooVALID, 
                                    prod_out_opening => channel_6_real_vectoooFROMooo0x7fbf3be02710oooTO_BUFFERoooDATA 
); 

fifo_12 : axi_fifo GENERIC MAP       (math_ram_width, 
                                    math_ram_depth 
                                    ) 
                    PORT MAP        (buf_clk => math_clk, 
                                    buf_rst => math_rst, 

                                    buf_in_ready => channel_6_real_vectoooFROMooo0x7fbf3be02710oooTO_BUFFERoooREADY, 
                                    buf_out_ready => channel_6_real_vectoooFROM_BUFFER_TOooo0x7fbf3be02d20oooREADY, 

                                    buf_in_valid => channel_6_real_vectoooFROMooo0x7fbf3be02710oooTO_BUFFERoooVALID, 
                                    buf_out_valid => channel_6_real_vectoooFROM_BUFFER_TOooo0x7fbf3be02d20oooVALID, 

                                    buf_in_data => channel_6_real_vectoooFROMooo0x7fbf3be02710oooTO_BUFFERoooDATA, 
                                    buf_out_data => channel_6_real_vectoooFROM_BUFFER_TOooo0x7fbf3be02d20oooDATA 
); 

prod_1 : prod_node PORT MAP (         prod_clk => math_clk, 
                                    prod_rst => math_rst, 

                                    prod_in0_ready => channel_12_real_vectoooFROM_BUFFER_TOooo0x7fbf3be029a0oooREADY, 
                                    prod_in0_valid => channel_12_real_vectoooFROM_BUFFER_TOooo0x7fbf3be029a0oooVALID, 
                                    prod_in0_opening => channel_12_real_vectoooFROM_BUFFER_TOooo0x7fbf3be029a0oooDATA, 

                                    prod_in1_ready => channel_9_real_vectoooFROM_BUFFER_TOooo0x7fbf3be029a0oooREADY, 
                                    prod_in1_valid => channel_9_real_vectoooFROM_BUFFER_TOooo0x7fbf3be029a0oooVALID, 
                                    prod_in1_opening => channel_9_real_vectoooFROM_BUFFER_TOooo0x7fbf3be029a0oooDATA, 

                                    prod_out_ready => channel_13_real_vectoooFROMooo0x7fbf3be029a0oooTO_BUFFERoooREADY, 
                                    prod_out_valid => channel_13_real_vectoooFROMooo0x7fbf3be029a0oooTO_BUFFERoooVALID, 
                                    prod_out_opening => channel_13_real_vectoooFROMooo0x7fbf3be029a0oooTO_BUFFERoooDATA 
); 

fifo_13 : axi_fifo GENERIC MAP       (math_ram_width, 
                                    math_ram_depth 
                                    ) 
                    PORT MAP        (buf_clk => math_clk, 
                                    buf_rst => math_rst, 

                                    buf_in_ready => channel_13_real_vectoooFROMooo0x7fbf3be029a0oooTO_BUFFERoooREADY, 
                                    buf_out_ready => channel_13_real_vectoooFROM_BUFFER_TOooo0x7fbf3be02d20oooREADY, 

                                    buf_in_valid => channel_13_real_vectoooFROMooo0x7fbf3be029a0oooTO_BUFFERoooVALID, 
                                    buf_out_valid => channel_13_real_vectoooFROM_BUFFER_TOooo0x7fbf3be02d20oooVALID, 

                                    buf_in_data => channel_13_real_vectoooFROMooo0x7fbf3be029a0oooTO_BUFFERoooDATA, 
                                    buf_out_data => channel_13_real_vectoooFROM_BUFFER_TOooo0x7fbf3be02d20oooDATA 
); 

div_0 : div_node PORT MAP (         div_clk => math_clk, 
                                    div_rst => math_rst, 

                                    div_in0_ready => channel_13_real_vectoooFROM_BUFFER_TOooo0x7fbf3be02d20oooREADY, 
                                    div_in0_valid => channel_13_real_vectoooFROM_BUFFER_TOooo0x7fbf3be02d20oooVALID, 
                                    div_in0_opening => channel_13_real_vectoooFROM_BUFFER_TOooo0x7fbf3be02d20oooDATA, 

                                    div_in1_ready => channel_6_real_vectoooFROM_BUFFER_TOooo0x7fbf3be02d20oooREADY, 
                                    div_in1_valid => channel_6_real_vectoooFROM_BUFFER_TOooo0x7fbf3be02d20oooVALID, 
                                    div_in1_opening => channel_6_real_vectoooFROM_BUFFER_TOooo0x7fbf3be02d20oooDATA, 

                                    div_out_ready => channel_14_real_vectoooFROMooo0x7fbf3be02d20oooTO_BUFFERoooREADY, 
                                    div_out_valid => channel_14_real_vectoooFROMooo0x7fbf3be02d20oooTO_BUFFERoooVALID, 
                                    div_out_opening => channel_14_real_vectoooFROMooo0x7fbf3be02d20oooTO_BUFFERoooDATA 
); 

fifo_14 : axi_fifo GENERIC MAP       (math_ram_width, 
                                    math_ram_depth 
                                    ) 
                    PORT MAP        (buf_clk => math_clk, 
                                    buf_rst => math_rst, 

                                    buf_in_ready => channel_14_real_vectoooFROMooo0x7fbf3be02d20oooTO_BUFFERoooREADY, 
                                    buf_out_ready => channel_14_real_vectoooFROM_BUFFER_TOoooOUTPUT_0oooREADY, 

                                    buf_in_valid => channel_14_real_vectoooFROMooo0x7fbf3be02d20oooTO_BUFFERoooVALID, 
                                    buf_out_valid => channel_14_real_vectoooFROM_BUFFER_TOoooOUTPUT_0oooVALID, 

                                    buf_in_data => channel_14_real_vectoooFROMooo0x7fbf3be02d20oooTO_BUFFERoooDATA, 
                                    buf_out_data => channel_14_real_vectoooFROM_BUFFER_TOoooOUTPUT_0oooDATA 
); 

OUTPUT_0 : OUTPUT_node PORT MAP (           OUTPUT_clk => math_clk, 
                                            OUTPUT_rst => math_rst, 

                                            OUTPUT_in_ready => channel_14_real_vectoooFROM_BUFFER_TOoooOUTPUT_0oooREADY, 
                                            OUTPUT_out_ready => math_out0_ready, 

                                            OUTPUT_in_valid => channel_14_real_vectoooFROM_BUFFER_TOoooOUTPUT_0oooVALID, 
                                            OUTPUT_out_valid => math_out0_valid, 

                                            OUTPUT_in_opening => channel_14_real_vectoooFROM_BUFFER_TOoooOUTPUT_0oooDATA, 
                                            OUTPUT_out_opening => math_out0_data 
); 


 end math_arch; 
