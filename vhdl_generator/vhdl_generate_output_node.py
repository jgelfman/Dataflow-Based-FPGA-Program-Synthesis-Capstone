# This file creates an instance of an Output node.

def returnOutput(sdfArch, resourcesFolder):
    node_import = str(
        "library ieee; \n" + 
        "use ieee.std_logic_1164.all;\n" +
        "use ieee.numeric_std.all;\n" +
        "\n"
        )
    node_entity = str(
        "entity output_node is \n" +
        "port ( \n"
        "        output_clk : in std_logic; \n"
        "        output_rst : in std_logic; \n"
        "\n" +
        "        output_in_ready : in std_logic; \n"
        "        output_out_ready : out std_logic; \n"
        "\n" +
        "        output_in_valid : in std_logic; \n"
        "        output_out_valid : out std_logic; \n"
        "\n" +
        "        output_in_opening : in std_logic_vector; \n"
        "        output_out_opening : out std_logic_vector \n"
        "    );  \n"
        "\n" +       
        "end output_node; \n"
    )
    node_arch = str(
        "architecture " + str(sdfArch) + " of output_node is \n" +
        "\n" +
        "    begin \n" +
        "\n" +
        "    output_out_ready <= output_in_ready; \n" +
        "    output_out_valid <= output_in_valid; \n" +
        "    output_out_opening <= output_in_opening; \n" +
        "\n" +
        "end architecture; \n"
    )
    
    whole_node = node_import + "\n" + node_entity + "\n" + node_arch

    # Add into the output subdirectory
    direc = str(resourcesFolder) + "/output_node.vhdl"
    output = open(direc,"w")
    output.write(str(whole_node))
    output.close()
