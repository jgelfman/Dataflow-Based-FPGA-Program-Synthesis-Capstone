library ieee; 
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity noise is
    generic ( 
        noise_ram_width : natural; 
        noise_ram_depth : natural 
); 
    port ( 
        noise_clk : in std_logic; 
        noise_rst : in std_logic; 
 
        noise_out0_ready : out std_logic; 
        noise_out0_valid : out std_logic; 
        noise_out0_data : out std_logic_vector 
    ); 
end; 
 
architecture noise_arch of noise is 


    component prod_node is 
        port ( 

            prod_clk : in std_logic; 
            prod_rst : in std_logic; 

            --Input1 
            prod_in0_ready : in std_logic; 

            prod_in0_valid : in std_logic; 

            prod_in0_opening : in std_logic_vector(noise_ram_width - 1 downto 0); 


            --Input2 
            prod_in1_ready : in std_logic; 

            prod_in1_valid : in std_logic; 

            prod_in1_opening : in std_logic_vector(noise_ram_width - 1 downto 0); 


            --Output 
            prod_out_ready : out std_logic; 

            prod_out_valid : out std_logic; 

            prod_out_opening : out std_logic_vector(noise_ram_width - 1 downto 0) 
    ); end component; 

    component add_node is 
        port ( 

            add_clk : in std_logic; 
            add_rst : in std_logic; 

            --Input1 
            add_in0_ready : in std_logic; 

            add_in0_valid : in std_logic; 

            add_in0_opening : in std_logic_vector(noise_ram_width - 1 downto 0); 


            --Input2 
            add_in1_ready : in std_logic; 

            add_in1_valid : in std_logic; 

            add_in1_opening : in std_logic_vector(noise_ram_width - 1 downto 0); 


            --Output 
            add_out_ready : out std_logic; 

            add_out_valid : out std_logic; 

            add_out_opening : out std_logic_vector(noise_ram_width - 1 downto 0) 
    ); end component; 

    component OUTPUT_node is 
        port ( 

            OUTPUT_clk : in std_logic; 
            OUTPUT_rst : in std_logic; 


            OUTPUT_in_ready : in std_logic; 
            OUTPUT_out_ready : out std_logic; 

            OUTPUT_in_valid : in std_logic; 
            OUTPUT_out_valid : out std_logic; 

            OUTPUT_in_opening : in std_logic_vector(noise_ram_width - 1 downto 0); 
            OUTPUT_out_opening : out std_logic_vector(noise_ram_width - 1 downto 0) 
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
            buf_in_data : in std_logic_vector(noise_ram_width - 1 downto 0); 
 
            buf_out_ready : in std_logic; 
            buf_out_valid : out std_logic; 
            buf_out_data : out std_logic_vector(noise_ram_width - 1 downto 0) 
        ); end component;


signal channel_0_realoooFROMooo0x28c38c0oooTO_BUFFERoooDATA, channel_0_realoooFROM_BUFFER_TOooo0x28c4100oooDATA, channel_10_intoooFROMooo0x28beb00oooTO_BUFFERoooDATA, channel_10_intoooFROM_BUFFER_TOooo0x28bee40oooDATA, channel_13_intoooFROMooo0x28bee40oooTO_BUFFERoooDATA, channel_13_intoooFROM_BUFFER_TOooo0x28c29d0oooDATA, channel_14_realoooFROMooo0x28c29d0oooTO_BUFFERoooDATA, channel_14_realoooFROM_BUFFER_TOooo0x28c41b0oooDATA, channel_15_realoooFROMooo0x28c41b0oooTO_BUFFERoooDATA, channel_15_realoooFROM_BUFFER_TOoooOUTPUT_0oooDATA, channel_1_realoooFROMooo0x7fb684006710oooTO_BUFFERoooDATA, channel_1_realoooFROM_BUFFER_TOooo0x28c4100oooDATA, channel_2_realoooFROMooo0x28c4100oooTO_BUFFERoooDATA, channel_2_realoooFROM_BUFFER_TOooo0x28c41b0oooDATA, channel_3_intoooFROMooo0x28b8890oooTO_BUFFERoooDATA, channel_3_intoooFROM_BUFFER_TOooo0x28c3320oooDATA, channel_6_intoooFROMooo0x28bee40oooTO_BUFFERoooDATA, channel_6_intoooFROM_BUFFER_TOooo0x28c3320oooDATA, channel_7_intoooFROMooo0x28c3320oooTO_BUFFERoooDATA, channel_7_intoooFROM_BUFFER_TOooo0x28c3450oooDATA, channel_8_intoooFROMooo0x28b8420oooTO_BUFFERoooDATA, channel_8_intoooFROM_BUFFER_TOooo0x28c3450oooDATA, channel_9_intoooFROMooo0x28c3450oooTO_BUFFERoooDATA, channel_9_intoooFROM_BUFFER_TOooo0x28beb00oooDATA : std_logic_vector(noise_ram_width - 1 downto 0); 
signal channel_0_realoooFROMooo0x28c38c0oooTO_BUFFERoooREADY, channel_0_realoooFROM_BUFFER_TOooo0x28c4100oooREADY, channel_0_realoooFROMooo0x28c38c0oooTO_BUFFERoooVALID, channel_0_realoooFROM_BUFFER_TOooo0x28c4100oooVALID, channel_10_intoooFROMooo0x28beb00oooTO_BUFFERoooREADY, channel_10_intoooFROM_BUFFER_TOooo0x28bee40oooREADY, channel_10_intoooFROMooo0x28beb00oooTO_BUFFERoooVALID, channel_10_intoooFROM_BUFFER_TOooo0x28bee40oooVALID, channel_13_intoooFROMooo0x28bee40oooTO_BUFFERoooREADY, channel_13_intoooFROM_BUFFER_TOooo0x28c29d0oooREADY, channel_13_intoooFROMooo0x28bee40oooTO_BUFFERoooVALID, channel_13_intoooFROM_BUFFER_TOooo0x28c29d0oooVALID, channel_14_realoooFROMooo0x28c29d0oooTO_BUFFERoooREADY, channel_14_realoooFROM_BUFFER_TOooo0x28c41b0oooREADY, channel_14_realoooFROMooo0x28c29d0oooTO_BUFFERoooVALID, channel_14_realoooFROM_BUFFER_TOooo0x28c41b0oooVALID, channel_15_realoooFROMooo0x28c41b0oooTO_BUFFERoooREADY, channel_15_realoooFROM_BUFFER_TOoooOUTPUT_0oooREADY, channel_15_realoooFROMooo0x28c41b0oooTO_BUFFERoooVALID, channel_15_realoooFROM_BUFFER_TOoooOUTPUT_0oooVALID, channel_1_realoooFROMooo0x7fb684006710oooTO_BUFFERoooREADY, channel_1_realoooFROM_BUFFER_TOooo0x28c4100oooREADY, channel_1_realoooFROMooo0x7fb684006710oooTO_BUFFERoooVALID, channel_1_realoooFROM_BUFFER_TOooo0x28c4100oooVALID, channel_2_realoooFROMooo0x28c4100oooTO_BUFFERoooREADY, channel_2_realoooFROM_BUFFER_TOooo0x28c41b0oooREADY, channel_2_realoooFROMooo0x28c4100oooTO_BUFFERoooVALID, channel_2_realoooFROM_BUFFER_TOooo0x28c41b0oooVALID, channel_3_intoooFROMooo0x28b8890oooTO_BUFFERoooREADY, channel_3_intoooFROM_BUFFER_TOooo0x28c3320oooREADY, channel_3_intoooFROMooo0x28b8890oooTO_BUFFERoooVALID, channel_3_intoooFROM_BUFFER_TOooo0x28c3320oooVALID, channel_6_intoooFROMooo0x28bee40oooTO_BUFFERoooREADY, channel_6_intoooFROM_BUFFER_TOooo0x28c3320oooREADY, channel_6_intoooFROMooo0x28bee40oooTO_BUFFERoooVALID, channel_6_intoooFROM_BUFFER_TOooo0x28c3320oooVALID, channel_7_intoooFROMooo0x28c3320oooTO_BUFFERoooREADY, channel_7_intoooFROM_BUFFER_TOooo0x28c3450oooREADY, channel_7_intoooFROMooo0x28c3320oooTO_BUFFERoooVALID, channel_7_intoooFROM_BUFFER_TOooo0x28c3450oooVALID, channel_8_intoooFROMooo0x28b8420oooTO_BUFFERoooREADY, channel_8_intoooFROM_BUFFER_TOooo0x28c3450oooREADY, channel_8_intoooFROMooo0x28b8420oooTO_BUFFERoooVALID, channel_8_intoooFROM_BUFFER_TOooo0x28c3450oooVALID, channel_9_intoooFROMooo0x28c3450oooTO_BUFFERoooREADY, channel_9_intoooFROM_BUFFER_TOooo0x28beb00oooREADY, channel_9_intoooFROMooo0x28c3450oooTO_BUFFERoooVALID, channel_9_intoooFROM_BUFFER_TOooo0x28beb00oooVALID : std_logic; 


begin 

prod_0 : prod_node PORT MAP (         prod_clk => noise_clk, 
                                    prod_rst => noise_rst, 

                                    prod_in_ready => channel_3_intoooFROM_BUFFER_TOooo0x28c3320oooREADY, 
                                    prod_in_valid => channel_3_intoooFROM_BUFFER_TOooo0x28c3320oooVALID, 
                                    prod_in_opening => channel_3_intoooFROM_BUFFER_TOooo0x28c3320oooDATA, 

                                    prod_in_ready => channel_6_intoooFROM_BUFFER_TOooo0x28c3320oooREADY, 
                                    prod_in_valid => channel_6_intoooFROM_BUFFER_TOooo0x28c3320oooVALID, 
                                    prod_in_opening => channel_6_intoooFROM_BUFFER_TOooo0x28c3320oooDATA, 

                                    prod_out_ready => channel_7_intoooFROMooo0x28c3320oooTO_BUFFERoooREADY, 
                                    prod_out_valid => channel_7_intoooFROMooo0x28c3320oooTO_BUFFERoooVALID, 
                                    prod_out_opening => channel_7_intoooFROMooo0x28c3320oooTO_BUFFERoooDATA 
); 

fifo_0 : axi_fifo GENERIC MAP       (noise_ram_width, 
                                    noise_ram_depth 
                                    ) 
                    PORT MAP        (buf_clk => noise_clk, 
                                    buf_rst => noise_rst, 

                                    buf_in_ready => channel_7_intoooFROMooo0x28c3320oooTO_BUFFERoooREADY, 
                                    buf_out_ready => channel_7_intoooFROM_BUFFER_TOooo0x28c3450oooREADY, 

                                    buf_in_valid => channel_7_intoooFROMooo0x28c3320oooTO_BUFFERoooVALID, 
                                    buf_out_valid => channel_7_intoooFROM_BUFFER_TOooo0x28c3450oooVALID, 

                                    buf_in_data => channel_7_intoooFROMooo0x28c3320oooTO_BUFFERoooDATA, 
                                    buf_out_data => channel_7_intoooFROM_BUFFER_TOooo0x28c3450oooDATA 
); 

add_0 : add_node PORT MAP (         add_clk => noise_clk, 
                                    add_rst => noise_rst, 

                                    add_in0_ready => channel_7_intoooFROM_BUFFER_TOooo0x28c3450oooREADY, 
                                    add_in0_valid => channel_7_intoooFROM_BUFFER_TOooo0x28c3450oooVALID, 
                                    add_in0_opening => channel_7_intoooFROM_BUFFER_TOooo0x28c3450oooDATA, 

                                    add_in1_ready => channel_8_intoooFROM_BUFFER_TOooo0x28c3450oooREADY, 
                                    add_in1_valid => channel_8_intoooFROM_BUFFER_TOooo0x28c3450oooVALID, 
                                    add_in1_opening => channel_8_intoooFROM_BUFFER_TOooo0x28c3450oooDATA, 

                                    add_out_ready => channel_0_realoooFROMooo0x28c38c0oooTO_BUFFERoooREADY, 
                                    add_out_valid => channel_9_intoooFROMooo0x28c3450oooTO_BUFFERoooVALID, 
                                    add_out_opening => channel_9_intoooFROMooo0x28c3450oooTO_BUFFERoooDATA 
); 

fifo_1 : axi_fifo GENERIC MAP       (noise_ram_width, 
                                    noise_ram_depth 
                                    ) 
                    PORT MAP        (buf_clk => noise_clk, 
                                    buf_rst => noise_rst, 

                                    buf_in_ready => channel_0_realoooFROMooo0x28c38c0oooTO_BUFFERoooREADY, 
                                    buf_out_ready => channel_9_intoooFROM_BUFFER_TOooo0x28beb00oooREADY, 

                                    buf_in_valid => channel_9_intoooFROMooo0x28c3450oooTO_BUFFERoooVALID, 
                                    buf_out_valid => channel_9_intoooFROM_BUFFER_TOooo0x28beb00oooVALID, 

                                    buf_in_data => channel_9_intoooFROMooo0x28c3450oooTO_BUFFERoooDATA, 
                                    buf_out_data => channel_9_intoooFROM_BUFFER_TOooo0x28beb00oooDATA 
); 

prod_1 : prod_node PORT MAP (         prod_clk => noise_clk, 
                                    prod_rst => noise_rst, 

                                    prod_in_ready => channel_1_realoooFROM_BUFFER_TOooo0x28c4100oooREADY, 
                                    prod_in_valid => channel_1_realoooFROM_BUFFER_TOooo0x28c4100oooVALID, 
                                    prod_in_opening => channel_1_realoooFROM_BUFFER_TOooo0x28c4100oooDATA, 

                                    prod_in_ready => channel_0_realoooFROM_BUFFER_TOooo0x28c4100oooREADY, 
                                    prod_in_valid => channel_0_realoooFROM_BUFFER_TOooo0x28c4100oooVALID, 
                                    prod_in_opening => channel_0_realoooFROM_BUFFER_TOooo0x28c4100oooDATA, 

                                    prod_out_ready => channel_2_realoooFROMooo0x28c4100oooTO_BUFFERoooREADY, 
                                    prod_out_valid => channel_2_realoooFROMooo0x28c4100oooTO_BUFFERoooVALID, 
                                    prod_out_opening => channel_2_realoooFROMooo0x28c4100oooTO_BUFFERoooDATA 
); 

fifo_2 : axi_fifo GENERIC MAP       (noise_ram_width, 
                                    noise_ram_depth 
                                    ) 
                    PORT MAP        (buf_clk => noise_clk, 
                                    buf_rst => noise_rst, 

                                    buf_in_ready => channel_2_realoooFROMooo0x28c4100oooTO_BUFFERoooREADY, 
                                    buf_out_ready => channel_2_realoooFROM_BUFFER_TOooo0x28c41b0oooREADY, 

                                    buf_in_valid => channel_2_realoooFROMooo0x28c4100oooTO_BUFFERoooVALID, 
                                    buf_out_valid => channel_2_realoooFROM_BUFFER_TOooo0x28c41b0oooVALID, 

                                    buf_in_data => channel_2_realoooFROMooo0x28c4100oooTO_BUFFERoooDATA, 
                                    buf_out_data => channel_2_realoooFROM_BUFFER_TOooo0x28c41b0oooDATA 
); 

prod_2 : prod_node PORT MAP (         prod_clk => noise_clk, 
                                    prod_rst => noise_rst, 

                                    prod_in_ready => channel_14_realoooFROM_BUFFER_TOooo0x28c41b0oooREADY, 
                                    prod_in_valid => channel_14_realoooFROM_BUFFER_TOooo0x28c41b0oooVALID, 
                                    prod_in_opening => channel_14_realoooFROM_BUFFER_TOooo0x28c41b0oooDATA, 

                                    prod_in_ready => channel_2_realoooFROM_BUFFER_TOooo0x28c41b0oooREADY, 
                                    prod_in_valid => channel_2_realoooFROM_BUFFER_TOooo0x28c41b0oooVALID, 
                                    prod_in_opening => channel_2_realoooFROM_BUFFER_TOooo0x28c41b0oooDATA, 

                                    prod_out_ready => channel_15_realoooFROMooo0x28c41b0oooTO_BUFFERoooREADY, 
                                    prod_out_valid => channel_15_realoooFROMooo0x28c41b0oooTO_BUFFERoooVALID, 
                                    prod_out_opening => channel_15_realoooFROMooo0x28c41b0oooTO_BUFFERoooDATA 
); 

fifo_3 : axi_fifo GENERIC MAP       (noise_ram_width, 
                                    noise_ram_depth 
                                    ) 
                    PORT MAP        (buf_clk => noise_clk, 
                                    buf_rst => noise_rst, 

                                    buf_in_ready => channel_15_realoooFROMooo0x28c41b0oooTO_BUFFERoooREADY, 
                                    buf_out_ready => channel_15_realoooFROM_BUFFER_TOoooOUTPUT_0oooREADY, 

                                    buf_in_valid => channel_15_realoooFROMooo0x28c41b0oooTO_BUFFERoooVALID, 
                                    buf_out_valid => channel_15_realoooFROM_BUFFER_TOoooOUTPUT_0oooVALID, 

                                    buf_in_data => channel_15_realoooFROMooo0x28c41b0oooTO_BUFFERoooDATA, 
                                    buf_out_data => channel_15_realoooFROM_BUFFER_TOoooOUTPUT_0oooDATA 
); 

OUTPUT_0 : OUTPUT_node PORT MAP (           OUTPUT_clk => noise_clk, 
                                            OUTPUT_rst => noise_rst, 

                                            OUTPUT_in_ready => channel_15_realoooFROM_BUFFER_TOoooOUTPUT_0oooREADY, 
                                            OUTPUT_out_ready => noise_out0_ready, 

                                            OUTPUT_in_valid => channel_15_realoooFROM_BUFFER_TOoooOUTPUT_0oooVALID, 
                                            OUTPUT_out_valid => noise_out0_valid, 

                                            OUTPUT_in_opening => channel_15_realoooFROM_BUFFER_TOoooOUTPUT_0oooDATA, 
                                            OUTPUT_out_opening => noise_out0_data 
); 


 end noise_arch; 
