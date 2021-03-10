# This file creates a PLACEHOLDER instance of an identity an add node.

def returnAdd(sdfArch, resourcesFolder):
    node_import = str(
        "library ieee; \n" + 
        "use ieee.std_logic_1164.all;\n" +
        "use ieee.numeric_std.all;\n" +
        "\n"
        )
    node_entity = str(
        "entity entity_node is \n" +
        "port ( \n"
        "        entity_clk : in std_logic; \n"
        "        entity_rst : in std_logic; \n"
        "\n" +
        "        entity_in_ready : in std_logic; \n"
        "        entity_out_ready : out std_logic; \n"
        "\n" +
        "        entity_in_valid : in std_logic; \n"
        "        entity_out_valid : out std_logic; \n"
        "\n" +
        "        entity_in_opening : in std_logic_vector; \n"
        "        entity_out_opening : out std_logic_vector \n"
        "    );  \n"
        "\n" +       
        "end entity_node; \n"
    )
    node_arch = str(
        "architecture " + str(sdfArch) + " of entity_node is \n" +
        "\n" +
        "    begin \n" +
        "\n" +
        "    entity_out_ready <= entity_in_ready; \n" +
        "    entity_out_valid <= entity_in_valid; \n" +
        "    entity_out_opening <= entity_in_opening; \n" +
        "\n" +
        "end architecture; \n"
    )
    
    whole_node = node_import + "\n" + node_entity + "\n" + node_arch

    # Add into the output subdirectory
    direc = str(resourcesFolder) + "/add_node.vhdl"
    output = open(direc,"w")
    output.write(str(whole_node))
    output.close()

#returnNode(sdfArch)