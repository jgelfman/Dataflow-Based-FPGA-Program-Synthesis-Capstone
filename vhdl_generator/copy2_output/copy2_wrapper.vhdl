library ieee; 
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity copy2 is
    generic ( 
        copy2_ram_width : natural; 
        copy2_ram_depth : natural 
); 
    port ( 
        copy2_clk : in std_logic; 
        copy2_rst : in std_logic; 
 
        copy2_in0_ready : out std_logic; 
        copy2_in0_valid : in std_logic; 
        copy2_in0_data : in std_logic_vector; 
 
        copy2_in1_ready : out std_logic; 
        copy2_in1_valid : in std_logic; 
        copy2_in1_data : in std_logic_vector; 
 
        copy2_out0_ready : in std_logic; 
        copy2_out0_valid : out std_logic; 
        copy2_out0_data : out std_logic_vector; 

        copy2_out1_ready : in std_logic; 
        copy2_out1_valid : out std_logic; 
        copy2_out1_data : out std_logic_vector 
    ); 
end; 
 
architecture copy2_arch of copy2 is 


    component INPUT_node is 
        port ( 

            INPUT_clk : in std_logic; 
            INPUT_rst : in std_logic; 


            INPUT_in_ready : in std_logic; 
            INPUT_out_ready : in std_logic; 

            INPUT_in_valid : in std_logic; 
            INPUT_out_valid : out std_logic; 

            INPUT_in_opening : in std_logic_vector(copy2_ram_width - 1 downto 0); 
            INPUT_out_opening : out std_logic_vector(copy2_ram_width - 1 downto 0) 
    ); end component; 

    component OUTPUT_node is 
        port ( 

            OUTPUT_clk : in std_logic; 
            OUTPUT_rst : in std_logic; 


            OUTPUT_in_ready : in std_logic; 
            OUTPUT_out_ready : in std_logic; 

            OUTPUT_in_valid : in std_logic; 
            OUTPUT_out_valid : out std_logic; 

            OUTPUT_in_opening : in std_logic_vector(copy2_ram_width - 1 downto 0); 
            OUTPUT_out_opening : out std_logic_vector(copy2_ram_width - 1 downto 0) 
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
            buf_in_data : in std_logic_vector(copy2_ram_width - 1 downto 0); 
 
            buf_out_ready : in std_logic; 
            buf_out_valid : out std_logic; 
            buf_out_data : out std_logic_vector(copy2_ram_width - 1 downto 0) 
        ); end component;


signal channel_0_real_vectoooFROMooo0x7fe74f700020oooTO_BUFFERoooDATA, channel_0_real_vectoooFROM_BUFFER_TOoooOUTPUT_0oooDATA, channel_1_real_vectoooFROMooo0x7fe74f7000e0oooTO_BUFFERoooDATA, channel_1_real_vectoooFROM_BUFFER_TOoooOUTPUT_1oooDATA : std_logic_vector(copy2_ram_width - 1 downto 0); 
signal channel_0_real_vectoooFROMooo0x7fe74f700020oooTO_BUFFERoooREADY, channel_0_real_vectoooFROM_BUFFER_TOoooOUTPUT_0oooREADY, channel_0_real_vectoooFROMooo0x7fe74f700020oooTO_BUFFERoooVALID, channel_0_real_vectoooFROM_BUFFER_TOoooOUTPUT_0oooVALID, channel_1_real_vectoooFROMooo0x7fe74f7000e0oooTO_BUFFERoooREADY, channel_1_real_vectoooFROM_BUFFER_TOoooOUTPUT_1oooREADY, channel_1_real_vectoooFROMooo0x7fe74f7000e0oooTO_BUFFERoooVALID, channel_1_real_vectoooFROM_BUFFER_TOoooOUTPUT_1oooVALID : std_logic; 


begin 

INPUT_0 : INPUT_node PORT MAP (     INPUT_clk => copy2_clk, 
                                    INPUT_rst => copy2_rst, 

                                    INPUT_in_ready => copy2_in0_ready, 
                                    INPUT_out_ready => channel_0_real_vectoooFROMooo0x7fe74f700020oooTO_BUFFERoooREADY, 

                                    INPUT_in_valid => copy2_in0_valid, 
                                    INPUT_out_valid => channel_0_real_vectoooFROMooo0x7fe74f700020oooTO_BUFFERoooVALID, 

                                    INPUT_in_opening => copy2_in0_data, 
                                    INPUT_out_opening => channel_0_real_vectoooFROMooo0x7fe74f700020oooTO_BUFFERoooDATA 
); 

fifo_0 : axi_fifo GENERIC MAP       (copy2_ram_width, 
                                    copy2_ram_depth 
                                    ) 
                    PORT MAP        (buf_clk => copy2_clk, 
                                    buf_rst => copy2_rst, 

                                    buf_in_ready => channel_0_real_vectoooFROMooo0x7fe74f700020oooTO_BUFFERoooREADY, 
                                    buf_out_ready => channel_0_real_vectoooFROM_BUFFER_TOoooOUTPUT_0oooREADY, 

                                    buf_in_valid => channel_0_real_vectoooFROMooo0x7fe74f700020oooTO_BUFFERoooVALID, 
                                    buf_out_valid => channel_0_real_vectoooFROM_BUFFER_TOoooOUTPUT_0oooVALID, 

                                    buf_in_data => channel_0_real_vectoooFROMooo0x7fe74f700020oooTO_BUFFERoooDATA, 
                                    buf_out_data => channel_0_real_vectoooFROM_BUFFER_TOoooOUTPUT_0oooDATA 
); 

INPUT_1 : INPUT_node PORT MAP (     INPUT_clk => copy2_clk, 
                                    INPUT_rst => copy2_rst, 

                                    INPUT_in_ready => copy2_in1_ready, 
                                    INPUT_out_ready => channel_1_real_vectoooFROMooo0x7fe74f7000e0oooTO_BUFFERoooREADY, 

                                    INPUT_in_valid => copy2_in1_valid, 
                                    INPUT_out_valid => channel_1_real_vectoooFROMooo0x7fe74f7000e0oooTO_BUFFERoooVALID, 

                                    INPUT_in_opening => copy2_in1_data, 
                                    INPUT_out_opening => channel_1_real_vectoooFROMooo0x7fe74f7000e0oooTO_BUFFERoooDATA 
); 

fifo_1 : axi_fifo GENERIC MAP       (copy2_ram_width, 
                                    copy2_ram_depth 
                                    ) 
                    PORT MAP        (buf_clk => copy2_clk, 
                                    buf_rst => copy2_rst, 

                                    buf_in_ready => channel_1_real_vectoooFROMooo0x7fe74f7000e0oooTO_BUFFERoooREADY, 
                                    buf_out_ready => channel_1_real_vectoooFROM_BUFFER_TOoooOUTPUT_1oooREADY, 

                                    buf_in_valid => channel_1_real_vectoooFROMooo0x7fe74f7000e0oooTO_BUFFERoooVALID, 
                                    buf_out_valid => channel_1_real_vectoooFROM_BUFFER_TOoooOUTPUT_1oooVALID, 

                                    buf_in_data => channel_1_real_vectoooFROMooo0x7fe74f7000e0oooTO_BUFFERoooDATA, 
                                    buf_out_data => channel_1_real_vectoooFROM_BUFFER_TOoooOUTPUT_1oooDATA 
); 

OUTPUT_0 : OUTPUT_node PORT MAP (           OUTPUT_clk => copy2_clk, 
                                            OUTPUT_rst => copy2_rst, 

                                            OUTPUT_in_ready => channel_0_real_vectoooFROM_BUFFER_TOoooOUTPUT_0oooREADY, 
                                            OUTPUT_out_ready => copy2_out0_ready, 

                                            OUTPUT_in_valid => channel_0_real_vectoooFROM_BUFFER_TOoooOUTPUT_0oooVALID, 
                                            OUTPUT_out_valid => copy2_out0_valid, 

                                            OUTPUT_in_opening => channel_0_real_vectoooFROM_BUFFER_TOoooOUTPUT_0oooDATA, 
                                            OUTPUT_out_opening => copy2_out0_data 
); 

OUTPUT_1 : OUTPUT_node PORT MAP (           OUTPUT_clk => copy2_clk, 
                                            OUTPUT_rst => copy2_rst, 

                                            OUTPUT_in_ready => channel_1_real_vectoooFROM_BUFFER_TOoooOUTPUT_1oooREADY, 
                                            OUTPUT_out_ready => copy2_out0_ready, 

                                            OUTPUT_in_valid => channel_1_real_vectoooFROM_BUFFER_TOoooOUTPUT_1oooVALID, 
                                            OUTPUT_out_valid => copy2_out0_valid, 

                                            OUTPUT_in_opening => channel_1_real_vectoooFROM_BUFFER_TOoooOUTPUT_1oooDATA, 
                                            OUTPUT_out_opening => copy2_out0_data 
); 


 end copy2_arch; 
