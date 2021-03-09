# This file creates an instance of an entity node.
import vhdl_generator;

def returnEntity(sdfArch, actorsList, signalsList):

    for actor in range(len(actorsList)):
        
        whole_Entity = ""
        
        # Libraries import
        libraries_component = str(
        "library ieee; \n" + 
        "use ieee.std_logic_1164.all;\n" +
        "use ieee.numeric_std.all;\n" +
        "\n"
        )



        # Buffer component
        buffer_component = "\n" + "component axi_fifo is \n" + "generic ( \n" + "    ram_width : natural; \n" + "    ram_depth : natural \n" + "); \n" + "Port ( \n" + "    buf_clk : in std_logic; \n" + "    buf_rst : in std_logic; \n" + " \n" + "    buf_in_ready : out std_logic; \n" + "    buf_in_valid : in std_logic; \n" + "    buf_in_data : in std_logic_vector(copy1_ram_width - 1 downto 0); \n" + " \n" + "    buf_out_ready : in std_logic; \n" + "    buf_out_valid : out std_logic; \n" + "    buf_out_data : out std_logic_vector(copy1_ram_width - 1 downto 0) \n" + "); end component;" + "\n"



        # Node name
        nodeName = str(actorsList[actor][1]).split("_")[0]


        # Own entity
        entity_component = ""
        entity_component = "entity " + nodeName + " is\n"

        # Own entity generic ports
        entity_component += "generic ( \n" + nodeName + "_ram_width : natural; \n" + nodeName + "_ram_depth : natural \n" + "); \n"
        
        # Own entity clock + reset
        entity_component += "port ( \n" + nodeName + "_clk : in std_logic; \n" + nodeName + "_rst : in std_logic; \n" + " \n" 
        # Own entity AXI Ports
        entity_component += "copy1_in_ready : in std_logic; \n" + nodeName + "_in_valid : in std_logic; \n" + nodeName + "_in_data : in std_logic_vector; \n" + " \n" + nodeName + "_out_ready : out std_logic; \n" + nodeName + "_out_valid : out std_logic; \n" + nodeName + "_out_data : out std_logic_vector \n" + "); \n" + "end; \n "



        # Architecture
        arch = "architecture " + str(sdfArch) + " of " + nodeName + "is \n"

        # Architecture node component
        arch_node_component = ""

        arch_node_component += "entity " + str(nodeName) + " is \n" + "port ( \n"

        # Add clock + reset ports
        arch_node_component += "\n" + "        entity_clk : in std_logic; \n" +  "        entity_rst : in std_logic; \n" + "\n"

        # Other Port instantiation
        portsList = actorsList[actor][3]
        # Identity ports
        if nodeName == "add":
            next #PLACEHOLDER
        elif nodeName == "prod":
            next #PLACEHOLDER
        elif nodeName == "div":
            next #PLACEHOLDER
        elif nodeName == "INPUT" or "OUTPUT":
            for port in range(len(portsList)):

                # AXI ready
                arch_node_component +=  "        entity_in_ready : in std_logic; \n" + "        entity_out_ready : out std_logic; \n" + "\n"
               
                # AXI valid
                arch_node_component += "        entity_in_valid : in std_logic; \n" + "        entity_out_valid : out std_logic; \n" + "\n"
                
                # AXI data
                arch_node_component += "entity_in_opening : in std_logic_vector(copy1_ram_width - 1 downto 0); \n" + "entity_out_opening : out std_logic_vector(copy1_ram_width - 1 downto 0) \n"

                # Node remainder
                arch_node_component += "); end component; \n" + "\n"

        else: # For all unknown operators
            for port in range(len(portsList)):
                # AXI ready
                arch_node_component +=  "        entity_in_ready : in std_logic; \n" + "        entity_out_ready : out std_logic; \n" + "\n"
               
                # AXI valid
                arch_node_component += "        entity_in_valid : in std_logic; \n" + "        entity_out_valid : out std_logic; \n" + "\n"
                
                # AXI data
                arch_node_component += "entity_in_opening : in std_logic_vector(copy1_ram_width - 1 downto 0); \n" + "entity_out_opening : out std_logic_vector(copy1_ram_width - 1 downto 0) \n"

                # Node remainder
                arch_node_component += "); end component; \n" + "\n"

        # Arch buffer
        arch_buffer_component = buffer_component

        # Arch signals
        arch_signals_component = ""

    
    
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