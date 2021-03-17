# This file creates a PLACEHOLDER instance of an identity a div node.

def returnDiv(sdfArch, resourcesFolder):
    node_import = str(
        "library ieee; \n" + 
        "use ieee.std_logic_1164.all;\n" +
        "use ieee.numeric_std.all;\n" +
        "\n"
        )
    node_entity = str(
        "entity div_node is \n" +
        "port ( \n" + 
        "        div_clk : in std_logic; \n" + 
        "        div_rst : in std_logic; \n" + 
        "\n\n" + 
        "--Input0 \n" +
        "        div_in0_ready : in std_logic; \n" + 
        "\n" +
        "        div_in0_valid : in std_logic; \n" + 
        "\n" +
        "        div_in0_opening : in std_logic_vector; \n" + 
        "\n\n" + 
        "--Input1 \n" +
        "        div_in1_ready : in std_logic; \n" + 
        "\n" +
        "        div_in1_valid : in std_logic; \n" + 
        "\n" +
        "        div_in1_opening : in std_logic_vector; \n" + 
        "\n\n" + 
        "--Output \n" +
        "        div_out_ready : out std_logic; \n" + 
        "\n" +
        "        div_out_valid : out std_logic; \n" + 
        "\n" +
        "        div_out_opening : out std_logic_vector \n" + 
        "    );  \n" + 
        "\n" +       
        "end div_node; \n"
    )
    node_arch = str(
        "architecture " + str(sdfArch) + " of div_node is \n" +
        "\n" +
        "    begin \n" +
        "\n" +
        "--PLACEHOLDER: Input1 propagated, Input 2 ignored \n" + # Placeholder behavior
        "    div_out_ready <= div_in1_ready; \n" +
        "    div_out_valid <= div_in1_valid; \n" +
        "    div_out_opening <= div_in1_opening; \n" +
        "\n" +
        "end architecture; \n"
    )
    
    whole_node = node_import + "\n" + node_entity + "\n" + node_arch

    # Add into the output subdirectory
    direc = str(resourcesFolder) + "/div_node.vhdl"
    output = open(direc,"w")
    output.write(str(whole_node))
    output.close()
