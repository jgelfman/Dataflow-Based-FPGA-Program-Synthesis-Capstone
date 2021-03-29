# This file creates a PLACEHOLDER instance of an identity a prod node.

def returnProd(sdfArch, resourcesFolder):
    node_import = str(
        "library ieee; \n" + 
        "use ieee.std_logic_1164.all;\n" +
        "use ieee.numeric_std.all;\n" +
        "\n"
        )
    node_entity = str(
        "entity prod_node is \n" +
        "port ( \n"
        "        prod_clk : in std_logic; \n"
        "        prod_rst : in std_logic; \n"
        "\n\n" + 
        "--Input0 \n" +
        "        prod_in0_ready : out std_logic; \n"
        "\n" +
        "        prod_in0_valid : in std_logic; \n"
        "\n" +
        "        prod_in0_opening : in std_logic_vector; \n"
        "\n\n" + 
        "--Input1 \n" +
        "        prod_in1_ready : out std_logic; \n"
        "\n" +
        "        prod_in1_valid : in std_logic; \n"
        "\n" +
        "        prod_in1_opening : in std_logic_vector; \n"
        "\n\n" + 
        "--Output \n" +
        "        prod_out_ready : in std_logic; \n"
        "\n" +
        "        prod_out_valid : out std_logic; \n"
        "\n" +
        "        prod_out_opening : out std_logic_vector \n"
        "    );  \n"
        "\n" +       
        "end prod_node; \n"
    )
    node_arch = str(
        "architecture " + str(sdfArch) + " of prod_node is \n" +
        "\n" +
        "    begin \n" +
        "\n" +
        "--PLACEHOLDER: Input1 propagated, Input 2 ignored" # Placeholder behavior
        "    prod_in1_ready <= prod_out_ready; \n" +
        "    prod_out_valid <= prod_in1_valid; \n" +
        "    prod_out_opening <= prod_in1_opening; \n" +
        "\n" +
        "end architecture; \n"
    )
    
    whole_node = node_import + "\n" + node_entity + "\n" + node_arch

    # Add into the output subdirectory
    direc = str(resourcesFolder) + "/prod_node.vhdl"
    output = open(direc,"w")
    output.write(str(whole_node))
    output.close()


