library ieee; 
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity copy1 is
    generic ( 
        copy1_ram_width : natural; 
        copy1_ram_depth : natural 
); 
    port ( 
        copy1_clk : in std_logic; 
        copy1_rst : in std_logic; 
 
        copy1_in0_ready : in std_logic; 
        copy1_in0_valid : in std_logic; 
        copy1_in0_data : in std_logic_vector; 
 
        copy1_out0_ready : out std_logic; 
        copy1_out0_valid : out std_logic; 
        copy1_out0_data : out std_logic_vector 
    ); 
end; 
 
architecture copy1_arch of copy1 is 


    component INPUT_node is 
        port ( 

            INPUT_clk : in std_logic; 
            INPUT_rst : in std_logic; 


            input_in_ready : in std_logic; 
            input_out_ready : out std_logic; 

            input_in_valid : in std_logic; 
            input_out_valid : out std_logic; 

            input_in_opening : in std_logic_vector(copy1_ram_width - 1 downto 0); 
            input_out_opening : out std_logic_vector(copy1_ram_width - 1 downto 0) 
    ); end component; 

    component OUTPUT_node is 
        port ( 

            OUTPUT_clk : in std_logic; 
            OUTPUT_rst : in std_logic; 


            output_in_ready : in std_logic; 
            output_out_ready : out std_logic; 

            output_in_valid : in std_logic; 
            output_out_valid : out std_logic; 

            output_in_opening : in std_logic_vector(copy1_ram_width - 1 downto 0); 
            output_out_opening : out std_logic_vector(copy1_ram_width - 1 downto 0) 
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


 signal channel_0_real_vect__FROM__0x7f5f30004250__TO_BUFFER__DATA, channel_0_real_vect__FROM_BUFFER_TO__OUTPUT_0__DATA : std_logic_vector(copy1_ram_width - 1 downto 0); 
signal channel_0_real_vect__FROM__0x7f5f30004250__TO_BUFFER__READY, channel_0_real_vect__FROM_BUFFER_TO__OUTPUT_0__READY, channel_0_real_vect__FROM__0x7f5f30004250__TO_BUFFER__VALID, channel_0_real_vect__FROM_BUFFER_TO__OUTPUT_0__VALID : std_logic; 


begin 

INPUT_0 : INPUT_node PORT MAP (         INPUT_clk => copy1_clk, 
                                        INPUT_rst => copy1_rst, 

                                        INPUT_0_in_ready => copy1_0_in_ready, 
                                        channel_0_real_vect__FROM_BUFFER_TO__OUTPUT_0__READY_out_ready => c_out_ready, 

                                        INPUT_0in_valid => copy1_0_in_valid, 
                                        channel_0_real_vect__FROM_BUFFER_TO__OUTPUT_0__VALID_out_valid => c_out_valid, 

                                        INPUT_0_opening => copy1_0_in_data, 
                                        channel_0_real_vect__FROM_BUFFER_TO__OUTPUT_0__DATA_out_opening => c_out_data 
); 

fifo_0 : axi_fifo GENERIC MAP       (copy1_ram_width, 
                                    copy1_ram_depth 
                                    ) 
                    PORT MAP        (buf_clk => copy1_clk, 
                                    buf_rst => copy1_rst, 

                                    buf_in_ready => channel_0_real_vect__FROM__0x7f5f30004250__TO_BUFFER__READY, 
                                    buf_out_ready => channel_0_real_vect__FROM_BUFFER_TO__OUTPUT_0__READY, 

                                    buf_in_valid => channel_0_real_vect__FROM__0x7f5f30004250__TO_BUFFER__VALID, 
                                    buf_out_valid => channel_0_real_vect__FROM_BUFFER_TO__OUTPUT_0__VALID, 

                                    buf_in_data => channel_0_real_vect__FROM__0x7f5f30004250__TO_BUFFER__DATA, 
                                    buf_out_data => channel_0_real_vect__FROM_BUFFER_TO__OUTPUT_0__DATA 
); 

OUTPUT_0 : OUTPUT_node PORT MAP (           OUTPUT_clk => copy1_clk, 
                                            OUTPUT_rst => copy1_rst, 

                                            OUTPUT_in_ready => channel_0_real_vect__FROM_BUFFER_TO__OUTPUT_0__READY, 
                                            OUTPUT_out_ready => copy1_out_ready, 

                                            OUTPUT_in_valid => channel_0_real_vect__FROM_BUFFER_TO__OUTPUT_0__VALID, 
                                            OUTPUT_out_valid => copy1_out_valid, 

                                            OUTPUT_in_opening => channel_0_real_vect__FROM_BUFFER_TO__OUTPUT_0__READY, 
                                            OUTPUT_out_opening => copy1_out_data 
); 


 end copy1_arch; 
