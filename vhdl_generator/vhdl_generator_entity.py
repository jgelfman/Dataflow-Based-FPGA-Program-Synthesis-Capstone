# This file creates an instance of an entity node.
import vhdl_generator;

def returnEntity(sdfArch, actorsList, signalsList):

    for actor in range(len(actorsList)):
        
        whole_Entity = ""
        
        # Libraries import
        libraries_component = str(
        "library ieee; \n" + 
        "use ieee.std_logic_1164.all;\n" +
        "use ieee.numeric_std.all;\n\n"
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
        entity_component += nodeName + "_in_ready : in std_logic; \n" + nodeName + "_in_valid : in std_logic; \n" + nodeName + "_in_data : in std_logic_vector; \n" + " \n" + nodeName + "_out_ready : out std_logic; \n" + nodeName + "_out_valid : out std_logic; \n" + nodeName + "_out_data : out std_logic_vector \n" + "); \n" + "end; \n "




        # Architecture
        node_arch = "architecture " + str(sdfArch) + " of " + nodeName + "is \n"

        # Architecture node component
        arch_node_component = ""

        arch_node_component += "entity " + str(nodeName) + " is \n" + "port ( \n"

        # Add clock + reset ports
        arch_node_component += "\n" + "        entity_clk : in std_logic; \n" +  "        entity_rst : in std_logic; \n\n"

        # Other Port instantiation
        portsList = actorsList[actor][3]
        actorsList
        # Identity ports
        if nodeName == "add":
            pass #PLACEHOLDER
        elif nodeName == "prod":
            pass #PLACEHOLDER
        elif nodeName == "div":
            pass #PLACEHOLDER
        else: #nodeName == "INPUT" or "OUTPUT":
            for port in range(len(portsList)):

                # AXI ready
                arch_node_component +=  "        entity_in_ready : in std_logic; \n" + "        entity_out_ready : out std_logic; \n" + "\n"
               
                # AXI valid
                arch_node_component += "        entity_in_valid : in std_logic; \n" + "        entity_out_valid : out std_logic; \n\n"
                
                # AXI data
                arch_node_component += "entity_in_opening : in std_logic_vector(copy1_ram_width - 1 downto 0); \n" + "entity_out_opening : out std_logic_vector(copy1_ram_width - 1 downto 0) \n"

                # Node remainder
                arch_node_component += "); end component; \n\n"


        # Arch buffer
        arch_buffer_component = buffer_component


        # Arch signals
        arch_signals_component = ""

        # Index of signals for mappings
        node_signals = []

        # Arch data signals
        arch_signals_component += "signal "
        for signal in range(len(signalsList)):
            # Signal name
            signalName = str(signalsList[signal][0])

            # Signal src
            signalSrcName = str(signalsList[signal][1][0])

            # Signal dst
            signalDstName = str(signalsList[signal][2][0])

            # Full signal declaration to buffer
            signalFullNameToBuffer = signalName + "_from_" + signalSrcName + "_to_buffer"
            node_signals.append(signalFullNameToBuffer)

            # Full signal declaration from buffer
            signalFullNameFromBuffer = signalName + "from_buffer_to_" + signalDstName + "_data"
            node_signals.append(signalFullNameFromBuffer)
            
            
            # Add to signals component handling commas
            arch_signals_component += signalFullNameToBuffer + ", " + signalFullNameFromBuffer + ", "
        arch_signals_component = arch_signals_component[:-2]
        
        # Add remainder
        arch_signals_component += " : std_logic_vector(copy1_ram_width - 1 downto 0); \n"

        # Arch ready + valid signals
        arch_signals_component += "signal "
        for signal in range(len(signalsList)):
            # Signal name
            signalName = str(signalsList[signal][0])

            # Signal src
            signalSrcName = str(signalsList[signal][1][0])

            # Signal dst
            signalDstName = str(signalsList[signal][2][0])

            # Full ready signal declaration to buffers
            signalFullNameToBufferReady = signalName + "_from_" + signalSrcName + "_to_buffer_ready"
            node_signals.append(signalFullNameToBufferReady)

            # Full ready signal declaration from buffers
            signalFullNameFromBufferReady = signalName + "_from_buffer_to_" + signalDstName + "_ready"
            node_signals.append(signalFullNameFromBufferReady)
            
            # Full valid signal declaration to buffers
            signalFullNameToBufferValid = signalName + "_from_" + signalSrcName + "_to_buffer_valid"
            node_signals.append(signalFullNameToBufferValid)

            # Full valid signal declaration from buffers
            signalFullNameFromBufferValid = signalName + "_from_buffer_to_" + signalDstName + "_valid"
            node_signals.append(signalFullNameFromBufferValid)

            # Add to signals component handling commas
            arch_signals_component += signalFullNameToBufferReady + ", " + signalFullNameFromBufferReady + ", " + signalFullNameToBufferValid + ", " + signalFullNameFromBufferValid + ", "
        
        # Remove last separator
        arch_signals_component = arch_signals_component[:-2]
        
        # Add signals remainder
        arch_signals_component += " : std_logic; \n\n"
        print(arch_signals_component)



        # Arch mapping
        arch_mapping_component = "begin \n\n\n"

        for node in range(len(actorsList)):
            
            # This mappings of this node
            node_mapping = ""

            if nodeName == "add":
                pass # PLACEHOLDER
            elif nodeName == "prod":
                pass # PLACEHOLDER
            elif nodeName == "div":
                pass # PLACEHOLDER
            else: # Entry/exit/identity
                node_mapping += nodeName + "_1 : entity_node"

                # Port Map
                node_mapping += " PORT MAP ( "

                # Clock + reset
                node_mapping += "entity_clk => " + nodeName + "_clk, \n" + "entity_rst => " + nodeName + "_clk, \n\n"

                # AXI ready
                node_mapping +=  "                                            entity_in_ready => " + nodeName + "_in_ready \n" +  "                                            entity_out_ready => " + node_signals

                node_signals[0]

                

            
                # AXI valid
                node_mapping += "        entity_in_valid : in std_logic; \n" + "        entity_out_valid : out std_logic; \n" + "\n"
                
                # AXI data
                node_mapping += "entity_in_opening : in std_logic_vector(copy1_ram_width - 1 downto 0); \n" + "entity_out_opening : out std_logic_vector(copy1_ram_width - 1 downto 0) \n"

                # Node remainder
                node_mapping += "); \n\n"


        

        

        '''
        signalSrcPort = str(signalsList[signal][1][1])
        signalDstPort = str(signalsList[signal][2][1])

            srcActor = signals[i][1][1]
            srcPort = signals[i][2][1]
            dstActor = signals[i][3][1]
            dstPort = signals[i][4][1]
            acts = (srcActor, dstActor)
            prts = (srcPort, dstPort)
            signal = [signalName, acts, prts]
            signalsList.append(signal)
        '''



    
    # Bringing the architecture together
        node_arch += arch_node_component + arch_buffer_component + arch_signals_component + arch_mapping_component

    
        whole_entity = libraries_component + "\n" + entity_component + "\n" + node_arch

    # Add into the output subdirectory
    output = open("output/entity_node.vhdl","w")
    output.write(str(whole_entity))
    output.close()

returnNode()