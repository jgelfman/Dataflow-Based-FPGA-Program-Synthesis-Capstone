library ieee;
use IEEE.std_logic_1164.all;


entity plus1 is
    port (

        --inputs:
        out_R0x21fe2a0, --type 1 (argument for addition)
        out_channel_0_real_vect,
        out_channel_1_real,
        out_R0x2221920, --type add (addition function)
        out_R0x7fec18004f20, --type INPUT_0 (result input node)
        out_channel_2_real_vect,
        out_ROUTPUT_0 --type INPUT_0 (result input node)
        : in std_logic; 

        --outputs:
        in_channel_1_real,
        in_R0x21fe2a0, --type 1 (argument for addition) 
        in_channel_2_real_vect,
        in_R0x2221920, --type add (addition function)
        in_channel_0_real_vect,
        in_R0x7fec18004f20, --type INPUT_0 (result input node)
        in_ROUTPUT_0 --type INPUT_0 (result input node)
        : out std_logic --outputs

    );

end plus1;


architecture plus1 of plus1 is
    
    begin 

        --channel_0_real_vect
        in_channel_0_real_vect <= out_channel_0_real_vect;

        --channel_0x21fe2a0
        in_R0x21fe2a0 <= out_R0x21fe2a0;

        --channel_0x2221920
        in_R0x2221920 <= out_R0x2221920;

        --channel_0x7fec18004f20
        in_R0x7fec18004f20 <= out_R0x2221920;

        --channel_1_real
        in_channel_1_real <= out_channel_1_real;

        --channel_2_real_vect
        in_channel_2_real_vect <= out_channel_2_real_vect;

        --channel_OUTPUT_0
        in_ROUTPUT_0 <= out_ROUTPUT_0;

end plus1;