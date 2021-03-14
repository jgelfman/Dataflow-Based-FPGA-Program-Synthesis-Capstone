# This file creates a PLACEHOLDER instance of an identity an add node.

def returnAdd(sdfArch, resourcesFolder):
    node_import = str(
        "library ieee; \n" + 
        "use ieee.std_logic_1164.all;\n" +
        "use ieee.numeric_std.all;\n" +
        "\n"
        )
    node_entity = str(
        "entity add_node is \n" +
        "port ( \n"
        "        add_clk : in std_logic; \n"
        "        add_rst : in std_logic; \n"
        "\n\n" + 
        "--Input1 \n" +
        "        add_in1_ready : in std_logic; \n"
        "\n" +
        "        add_in1_valid : in std_logic; \n"
        "\n" +
        "        add_in1_opening : in std_logic_vector; \n"
        "\n\n" + 
        "--Input2 \n" +
        "        add_in2_ready : in std_logic; \n"
        "\n" +
        "        add_in2_valid : in std_logic; \n"
        "\n" +
        "        add_in2_opening : in std_logic_vector; \n"
        "\n\n" + 
        "--Output \n" +
        "        add_out_ready : out std_logic; \n"
        "\n" +
        "        add_out_valid : out std_logic; \n"
        "\n" +
        "        add_out_opening : out std_logic_vector \n"
        "    );  \n"
        "\n" +       
        "end add_node; \n"
    )
    node_arch = str(
        "architecture " + str(sdfArch) + " of add_node is \n" +
        "\n" +
        "    begin \n" +
        "\n" +
        "--PLACEHOLDER: Input1 propagated, Input 2 ignored \n" + # Placeholder behavior
        "    add_out_ready <= add_in1_ready; \n" +
        "    add_out_valid <= add_in1_valid; \n" +
        "    add_out_opening <= add_in1_opening; \n" +
        "\n" +
        "end architecture; \n"
    )
    
    whole_node = node_import + "\n" + node_entity + "\n" + node_arch

    # Add into the output subdirectory
    direc = str(resourcesFolder) + "/add_node.vhdl"
    output = open(direc,"w")
    output.write(str(whole_node))
    output.close()

returnAdd
