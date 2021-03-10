# This file creates an instance of an entity node.

def returnEntity(sdfArch, outputName, actorsList, interiorConnections, nodeSignals):


    # Buffer count
    bufCount = len(actorsList) - 1

    # Input count
    inputCount = 0
    # Add count
    addCount = 0
    # Prod count
    prodCount = 0
    # Div count
    divCount = 0
    # Output count
    outputCount = 0
    # Identity node count
    identityCount = 0


    for actor in range(len(actorsList)):
        
        whole_Entity = ""
        
        # Libraries import
        libraries_component = str(
        "library ieee; \n" + 
        "use ieee.std_logic_1164.all;\n" +
        "use ieee.numeric_std.all;\n\n"
        )

        # Node name
        nodeName = str(actorsList[actor][1]).split("_")[0]

        # Buffer component
        buffer_component = "\n" + "    component axi_fifo is \n" + "        generic ( \n" + "            ram_width : natural; \n" + "            ram_depth : natural \n" + "        ); \n" + "        Port ( \n" + "            buf_clk : in std_logic; \n" + "            buf_rst : in std_logic; \n" + " \n" + "            buf_in_ready : out std_logic; \n" + "            buf_in_valid : in std_logic; \n" + "            buf_in_data : in std_logic_vector(" + nodeName + "_ram_width - 1 downto 0); \n" + " \n" + "            buf_out_ready : in std_logic; \n" + "            buf_out_valid : out std_logic; \n" + "            buf_out_data : out std_logic_vector(" + nodeName + "_ram_width - 1 downto 0) \n" + "        ); end component;" + "\n"


        # Own entity
        entity_component = ""
        entity_component = "entity " + nodeName + " is\n"

        # Own entity generic ports
        entity_component += "    generic ( \n" + "        " + nodeName + "_ram_width : natural; \n" +  "        " + nodeName + "_ram_depth : natural \n" + "); \n"
        
        # Own entity clock + reset
        entity_component += "    port ( \n" +  "        " + nodeName + "_clk : in std_logic; \n" +  "        " + nodeName + "_rst : in std_logic; \n" + " \n" 
        # Own entity AXI Ports
        entity_component +=  "        " + nodeName + "_in_ready : in std_logic; \n" +  "        " + nodeName + "_in_valid : in std_logic; \n" +  "        " + nodeName + "_in_data : in std_logic_vector; \n" + " \n" +  "        " + nodeName + "_out_ready : out std_logic; \n" +  "        " + nodeName + "_out_valid : out std_logic; \n" +  "        " + nodeName + "_out_data : out std_logic_vector \n" + "    ); \n" + "end; \n "




        # Architecture
        node_arch = "architecture " + str(sdfArch) + " of " + nodeName + " is \n"

        # Architecture node component
        arch_node_component = ""

        arch_node_component += "    component " + str(nodeName) + "_node is \n" + "        port ( \n"

        # Add clock + reset ports
        arch_node_component += "\n" + "            entity_clk : in std_logic; \n" +  "            entity_rst : in std_logic; \n\n"

        # Other Port instantiation
        portsList = actorsList[actor][3]
        # Identity ports
        if nodeName == "add": #PLACEHOLDER
            
            # AXI ready
            arch_node_component +=  "            entity_in_ready : in std_logic; \n" + "            entity_out_ready : out std_logic; \n" + "\n"
            
            # AXI valid
            arch_node_component += "            entity_in_valid : in std_logic; \n" + "            entity_out_valid : out std_logic; \n\n"
            
            # AXI data
            arch_node_component += "            entity_in_opening : in std_logic_vector(" + nodeName + "_ram_width - 1 downto 0); \n" + "            entity_out_opening : out std_logic_vector(" + nodeName + "_ram_width - 1 downto 0) \n"

            # Node remainder
            arch_node_component += "        ); end component; \n\n"

        elif nodeName == "prod": #PLACEHOLDER
            
            # AXI ready
            arch_node_component +=  "            entity_in_ready : in std_logic; \n" + "            entity_out_ready : out std_logic; \n" + "\n"
            
            # AXI valid
            arch_node_component += "            entity_in_valid : in std_logic; \n" + "            entity_out_valid : out std_logic; \n\n"
            
            # AXI data
            arch_node_component += "            entity_in_opening : in std_logic_vector(" + nodeName + "_ram_width - 1 downto 0); \n" + "            entity_out_opening : out std_logic_vector(" + nodeName + "_ram_width - 1 downto 0) \n"

            # Node remainder
            arch_node_component += "        ); end component; \n\n"

        elif nodeName == "div": #PLACEHOLDER
            
            # AXI ready
            arch_node_component +=  "            entity_in_ready : in std_logic; \n" + "            entity_out_ready : out std_logic; \n" + "\n"
            
            # AXI valid
            arch_node_component += "            entity_in_valid : in std_logic; \n" + "            entity_out_valid : out std_logic; \n\n"
            
            # AXI data
            arch_node_component += "            entity_in_opening : in std_logic_vector(" + nodeName + "_ram_width - 1 downto 0); \n" + "            entity_out_opening : out std_logic_vector(" + nodeName + "_ram_width - 1 downto 0) \n"

            # Node remainder
            arch_node_component += "        ); end component; \n\n"

        else: #nodeName == "INPUT" or "OUTPUT": # Or identity

            # AXI ready
            arch_node_component +=  "            entity_in_ready : in std_logic; \n" + "            entity_out_ready : out std_logic; \n" + "\n"
            
            # AXI valid
            arch_node_component += "            entity_in_valid : in std_logic; \n" + "            entity_out_valid : out std_logic; \n\n"
            
            # AXI data
            arch_node_component += "            entity_in_opening : in std_logic_vector(" + nodeName + "_ram_width - 1 downto 0); \n" + "            entity_out_opening : out std_logic_vector(" + nodeName + "_ram_width - 1 downto 0) \n"

            # Node remainder
            arch_node_component += "        ); end component; \n\n"



        # Arch buffer
        arch_buffer_component = buffer_component



        # Arch signals
        arch_signals_component = ""

        # Index of signals for mappings
        node_signals_data = []
        node_signals_ready = []
        node_signals_valid = []

        # Arch data signals
        arch_signals_component += "\n\n signal "
        for signal in range(len(nodeSignals)):
            # Signal name
            signalName = str(nodeSignals[signal][0])

            # Signal src
            signalSrcName = str(nodeSignals[signal][1][0])

            # Signal dst
            signalDstName = str(nodeSignals[signal][2][0])

            # Full signal declaration to buffer
            signalFullNameToBuffer = signalName + "_from_" + signalSrcName + "_to_buffer"

            # Full signal declaration from buffer
            signalFullNameFromBuffer = signalName + "_from_buffer_to_" + signalDstName + "_data"

            # Make pair for buffer handling
            bothDataSigs = []
            bothDataSigs.append(signalFullNameToBuffer)
            bothDataSigs.append(signalFullNameFromBuffer)

            # Add pair to signals list
            node_signals_data.append(bothDataSigs)
            
            
            # Add to signals component handling commas
            arch_signals_component += signalFullNameToBuffer + ", " + signalFullNameFromBuffer + ", "
        arch_signals_component = arch_signals_component[:-2]

        # Add remainder
        arch_signals_component += " : std_logic_vector(" + nodeName + "_ram_width - 1 downto 0); \n"

        # Arch ready + valid signals
        arch_signals_component += "signal "
        for signal in range(len(nodeSignals)):
            # Signal name
            signalName = str(nodeSignals[signal][0])

            # Signal src
            signalSrcName = str(nodeSignals[signal][1][0])

            # Signal dst
            signalDstName = str(nodeSignals[signal][2][0])

            # Bunching both ready/valid signals for buffer handling
            bothReadySigs = []
            bothValidSigs = []

            # Full ready signal declaration to buffers
            signalFullNameToBufferReady = signalName + "_from_" + signalSrcName + "_to_buffer_ready"
            bothReadySigs.append(signalFullNameToBufferReady)

            # Full ready signal declaration from buffers
            signalFullNameFromBufferReady = signalName + "_from_buffer_to_" + signalDstName + "_ready"
            bothReadySigs.append(signalFullNameFromBufferReady)

            node_signals_ready.append(bothReadySigs)
            
            # Full valid signal declaration to buffers
            signalFullNameToBufferValid = signalName + "_from_" + signalSrcName + "_to_buffer_valid"
            bothValidSigs.append(signalFullNameToBufferValid)

            # Full valid signal declaration from buffers
            signalFullNameFromBufferValid = signalName + "_from_buffer_to_" + signalDstName + "_valid"
            bothValidSigs.append(signalFullNameFromBufferValid)

            node_signals_valid.append(bothValidSigs)

            # Add to signals component handling commas
            arch_signals_component += signalFullNameToBufferReady + ", " + signalFullNameFromBufferReady + ", " + signalFullNameToBufferValid + ", " + signalFullNameFromBufferValid + ", "
        
        # Remove last separator
        arch_signals_component = arch_signals_component[:-2]
        
        # Add signals remainder
        arch_signals_component += " : std_logic; \n\n\n"




        # Arch mapping
        arch_mapping_component = "begin \n\n"

        # Node mapping
        #for act in range(len(actorsList) - 1):
        
        # Act name:
        #actName = str(actorsList[act][1]).split("_")[0]

        # Connected actors
        conAct = len(actorsList) - 1


        # Add node mappings
        node_mapping = ""

        try:
            if nodeName == "INPUT": # Entry node
                inputCount += 1
                node_mapping += nodeName + "_" + str(inputCount - 1) + " : entity_node"

                # Port Map
                node_mapping += " PORT MAP ("

                # Clock + reset
                node_mapping += "           entity_clk => " + nodeName + "_clk, \n" + "                                            entity_rst => " + nodeName + "_rst, \n\n"

                # AXI ready
                node_mapping +=  "                                            entity_in_ready => " + nodeName + "_in_ready, \n" +  "                                            entity_out_ready => " + node_signals_ready[actor][0] + ", \n\n"
            
                # AXI valid
                node_mapping += "                                            entity_in_valid => " + nodeName + "_in_valid, \n" + "                                            entity_out_valid => " + node_signals_valid[actor][0] + ", \n\n"
                
                # AXI data
                node_mapping += "                                            entity_in_opening => " + nodeName + "_in_data, \n"

                node_mapping += "                                            entity_out_opening => " + node_signals_data[actor][0] + " \n" 

                # Node remainder
                node_mapping += "); \n\n"

                # Add to architecture
                arch_mapping_component += node_mapping

            elif nodeName == "OUTPUT": # Exit node
                outputCount += 1
                node_mapping += nodeName + "_" + str(outputCount - 1) + " : entity_node"

                # Port Map
                node_mapping += " PORT MAP ("

                # Clock + reset
                node_mapping += "           entity_clk => " + nodeName + "_clk, \n" + "                                            entity_rst => " + nodeName + "_rst, \n\n"

                # AXI ready
                node_mapping +=  "                                            entity_in_ready => " + nodeName + "_in_ready, \n" +  "                                            entity_out_ready => " + node_signals_ready[-1][0] + ", \n\n"
            
                # AXI valid
                node_mapping += "                                            entity_in_valid => " + nodeName + "_in_valid, \n" + "                                            entity_out_valid => " + node_signals_valid[-1][0] + ", \n\n"
                
                # AXI data
                node_mapping += "                                            entity_in_opening => " + nodeName + "_in_data, \n"

                node_mapping += "                                            entity_out_opening => " + nodeName + "_out_data \n"

                # Node remainder
                node_mapping += "); \n\n"

                # Add to architecture
                arch_mapping_component += node_mapping

            elif nodeName == "add": # PLACEHOLDERS (just the identity node for now)
                addCount += 1
                node_mapping += nodeName + "_" + str(addCount - 1) + " : add_node"

                # Port Map
                node_mapping += " PORT MAP ("

                # Clock + reset
                node_mapping += "           entity_clk => " + nodeName + "_clk, \n" + "                                            entity_rst => " + nodeName + "_rst, \n\n"

                # AXI ready
                node_mapping +=  "                                            entity_in_ready => " + node_signals_ready[actor][1] + ", \n" +  "                                            entity_out_ready => " + node_signals_ready[actor][0] + ", \n\n"
            
                # AXI valid
                node_mapping += "                                            entity_in_valid => " + node_signals_valid[actor][1] + ", \n" + "                                            entity_out_valid => " + node_signals_valid[actor][0] + ", \n\n"
                
                # AXI data
                node_mapping += "                                            entity_in_opening => " + node_signals_data[actor][1] + ", \n"

                node_mapping += "                                            entity_out_opening => " + node_signals_data[actor][0] + ", \n\n"

                # Node remainder
                node_mapping += "); \n\n"

                # Add to architecture
                arch_mapping_component += node_mapping

            elif nodeName == "prod": # PLACEHOLDERS (just the identity node for now)
                prodCount += 1
                node_mapping += nodeName + "_" + str(prodCount - 1) + " : prod_node"

                # Port Map
                node_mapping += " PORT MAP ("

                # Clock + reset
                node_mapping += "           entity_clk => " + nodeName + "_clk, \n" + "                                            entity_rst => " + nodeName + "_rst, \n\n"

                # AXI ready
                node_mapping +=  "                                            entity_in_ready => " + node_signals_ready[actor][1] + ", \n" +  "                                            entity_out_ready => " + node_signals_ready[actor][0] + ", \n\n"
            
                # AXI valid
                node_mapping += "                                            entity_in_valid => " + node_signals_valid[actor][1] + ", \n" + "                                            entity_out_valid => " + node_signals_valid[actor][0] + ", \n\n"
                
                # AXI data
                node_mapping += "                                            entity_in_opening => " + node_signals_data[actor][1] + ", \n"

                node_mapping += "                                            entity_out_opening => " + node_signals_data[actor][0] + ", \n\n"

                # Node remainder
                node_mapping += "); \n\n"

                # Add to architecture
                arch_mapping_component += node_mapping

            elif nodeName == "div": # PLACEHOLDERS (just the identity node for now)
                divCount += 1
                node_mapping += nodeName + "_" + str(divCount - 1) + " : div_node"

                # Port Map
                node_mapping += " PORT MAP ("

                # Clock + reset
                node_mapping += "           entity_clk => " + nodeName + "_clk, \n" + "                                            entity_rst => " + nodeName + "_rst, \n\n"

                # AXI ready
                node_mapping +=  "                                            entity_in_ready => " + node_signals_ready[actor][1] + ", \n" +  "                                            entity_out_ready => " + node_signals_ready[actor][0] + ", \n\n"
            
                # AXI valid
                node_mapping += "                                            entity_in_valid => " + node_signals_valid[actor][1] + ", \n" + "                                            entity_out_valid => " + node_signals_valid[actor][0] + ", \n\n"
                
                # AXI data
                node_mapping += "                                            entity_in_opening => " + node_signals_data[actor][1] + ", \n"

                node_mapping += "                                            entity_out_opening => " + node_signals_data[actor][0] + ", \n\n"

                # Node remainder
                node_mapping += "); \n\n"

                # Add to architecture
                arch_mapping_component += node_mapping

            elif nodeName != "INPUT" or "OUTPUT" or "add" or "prod" or "div": # Identity node
                identityCount += 1
                node_mapping += nodeName + "_" + str(identityCount - 1) + " : entity_node"

                # Port Map
                node_mapping += " PORT MAP ("

                # Clock + reset
                node_mapping += "           entity_clk => " + nodeName + "_clk, \n" + "                                            entity_rst => " + nodeName + "_rst, \n\n"

                # AXI ready
                node_mapping +=  "                                            entity_in_ready => " + node_signals_ready[actor][1] + ", \n" +  "                                            entity_out_ready => " + node_signals_ready[actor][0] + ", \n\n"
            
                # AXI valid
                node_mapping += "                                            entity_in_valid => " + node_signals_valid[actor][1] + ", \n" + "                                            entity_out_valid => " + node_signals_valid[actor][0] + ", \n\n"
                
                # AXI data
                node_mapping += "                                            entity_in_opening => " + node_signals_data[actor][1] + ", \n"

                node_mapping += "                                            entity_out_opening => " + node_signals_data[actor][0] + ", \n\n"

                # Node remainder
                node_mapping += "); \n\n"

                # Add to architecture
                arch_mapping_component += node_mapping
        
        except:
            print("Unkown operator found: " + nodeName)
            raise


        # Buffer mapping
        # Check for buffer count

        if bufCount != 0:
            
            # Add buffer mappings
            buffer_mapping = ""

            buffer_mapping += "fifo_" + str(signal+1) + " : axi_fifo"

            # Generic Map
            buffer_mapping += " GENERIC MAP       (" + nodeName + "_ram_width, \n" + "                                    " + nodeName + "_ram_depth \n" + "                                    ) \n"

            # Port Map
            buffer_mapping += "                    PORT MAP        ("

            # Clock + reset
            buffer_mapping += "buf_clk => " + nodeName + "_clk, \n" + "                                    buf_rst => " + nodeName + "_rst, \n\n"

            # AXI ready
            buffer_mapping +=  "                                    buf_in_ready => " + node_signals_ready[signal][0] + ", \n" +  "                                    buf_out_ready => " + node_signals_ready[signal][1] + ", \n\n"
        
            # AXI valid
            buffer_mapping +=  "                                    buf_in_valid => " + node_signals_valid[signal][0] + ", \n" +  "                                    buf_out_valid => " + node_signals_valid[signal][1] + ", \n\n"
            
            # AXI data
            buffer_mapping +=  "                                    buf_in_data => " + node_signals_data[signal][0] + ", \n" +  "                                    buf_out_data => " + node_signals_data[signal][1] + " \n"

            # Buffer remainder
            buffer_mapping += "); \n\n"

            # Update buffer count
            bufCount -= 1

            arch_mapping_component += buffer_mapping

    
        # Bringing the architecture together
        arch_remainder = "\n end " + str(sdfArch) + "; \n"
        
        node_arch += arch_node_component + arch_buffer_component + arch_signals_component + arch_mapping_component
    
        whole_entity = libraries_component + "\n" + entity_component + "\n" + node_arch + arch_remainder

        # File name
        if nodeName == "INPUT":
            fileName = nodeName + "_" + str(inputCount - 1)
        elif nodeName == "OUTPUT":
            fileName = nodeName + "_" + str(outputCount - 1)
        elif nodeName == "add":
            fileName = nodeName + "_" + str(addCount - 1)
        elif nodeName == "div":
            fileName = nodeName + "_" + str(divCount - 1)
        elif nodeName == "prod":
            fileName = nodeName + "_" + str(prodCount - 1)
        else:
            fileName = nodeName + "_" + str(identityCount - 1)

        # Add into the output subdirectory
        direc = str(outputName) + "/" + fileName + ".vhdl"
        filewrite = open(direc,"w")
        filewrite.write(str(whole_entity))
        filewrite.close()

#returnEntity(sdfArch, actorsList, interiorConnections, nodeSignals)