# This file creates an instance of an entity node.
import vhdl_generator;


def returnEntity(actorsList, signalsList):

    for actor in range(len(actorsList)):
        whole_Entity = ""

        # Libraries import
        libraries_import = str(
        "library ieee; \n" + 
        "use ieee.std_logic_1164.all;\n" +
        "use ieee.numeric_std.all;\n" +
        "\n"
        )

        # Entity name
        actorType = str(actorsList[actor][1]).split("_")[0]
        whole_Entity += "entity " + str(actorType) + " is \n" + "port ( \n"

        # Add clock + reset ports
        whole_Entity += "\n" + "        entity_clk : in std_logic; \n" +  "        entity_rst : in std_logic; \n" + "\n"

        # Other Port instantiation
        portsList = actorsList[actor][3]
        # Identity ports
        if actorType == "INPUT" or "OUTPUT":
            for port in range(len(portsList)):
                # add AXI ports
                return 

        elif actorType == "add": ## PLACEHOLDER
            for port in range(len(portsList)):

        elif actorType == "prod": ## PLACEHOLDER
            for port in range(len(portsList)):

        elif actorType == "div": ## PLACEHOLDER
            for port in range(len(portsList)):

        else:
            for port in range(len(portsList)):

    
    node_entity = 
        for actor in actorsList:
            
        str(
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
    
    node_arch = 
    #component instantiation 
    #signal instatiation
    #Porting
    
    whole_entity = node_import + "\n" + node_entity + "\n" + node_arch

    # Add into the output subdirectory
    output = open("output/entity_node.vhdl","w")
    output.write(str(whole_entity))
    output.close()

returnNode()