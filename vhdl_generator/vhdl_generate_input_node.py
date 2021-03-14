# This file creates an instance of an Input node.

def returnInput(sdfArch, resourcesFolder):
    node_import = str(
        "library ieee; \n" + 
        "use ieee.std_logic_1164.all;\n" +
        "use ieee.numeric_std.all;\n" +
        "\n"
        )
    node_entity = str(
        "entity input_node is \n" +
        "port ( \n" +
        "        input_clk : in std_logic; \n" +
        "        input_rst : in std_logic; \n" +
        "\n" +
        "        input_in_ready : in std_logic; \n" +
        "        input_out_ready : out std_logic; \n" +
        "\n" +
        "        input_in_valid : in std_logic; \n" +
        "        input_out_valid : out std_logic; \n" +
        "\n" +
        "        input_in_opening : in std_logic_vector; \n" +
        "        input_out_opening : out std_logic_vector \n" +
        "    );  \n" +
        "\n" +       
        "end input_node; \n"
    )
    node_arch = str(
        "architecture " + str(sdfArch) + " of input_node is \n" +
        "\n" +
        "    begin \n" +
        "\n" +
        "    input_out_ready <= input_in_ready; \n" +
        "    input_out_valid <= input_in_valid; \n" +
        "    input_out_opening <= input_in_opening; \n" +
        "\n" +
        "end architecture; \n"
    )
    
    whole_node = node_import + "\n" + node_entity + "\n" + node_arch

    # Add into the output subdirectory
    direc = str(resourcesFolder) + "/input_node.vhdl"
    output = open(direc,"w")
    output.write(str(whole_node))
    output.close()
