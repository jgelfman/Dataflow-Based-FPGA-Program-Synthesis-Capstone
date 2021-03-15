# This file creates an instance of an entity node.

from os import device_encoding


def returnWrapper(sdfName, sdfArch, outputName, actorsList, interiorConnections, nodeSignals):

    wholeWrapper = ""

    # Libraries import
    librariesComponent = str(
    "library ieee; \n" + 
    "use ieee.std_logic_1164.all;\n" +
    "use ieee.numeric_std.all;\n\n"
    )


    # Wrapper entity component
    entityComponent = "entity " + sdfName + " is\n"

    # Wrapper entity generic ports
    entityComponent += "    generic ( \n" + "        " + sdfName + "_ram_width : natural; \n" +  "        " + sdfName + "_ram_depth : natural \n" + "); \n"
    
    # Wrapper entity clock + reset
    entityComponent += "    port ( \n" + "        " + sdfName + "_clk : in std_logic; \n" + "        " + sdfName + "_rst : in std_logic; \n" + " \n"

    # Wrapper entity AXI Ports
    entityComponent +=  "        " + sdfName + "_in_ready : in std_logic; \n" +  "        " + sdfName + "_in_valid : in std_logic; \n" +  "        " + sdfName + "_in_data : in std_logic_vector; \n" + " \n" +  "        " + sdfName + "_out_ready : out std_logic; \n" +  "        " + sdfName + "_out_valid : out std_logic; \n" +  "        " + sdfName + "_out_data : out std_logic_vector \n" + "    ); \n" + "end; \n "
    


    # Architecture
    wrapperArch = "architecture " + str(sdfArch) + " of " + sdfName + " is \n\n\n"

    archComponents = ""

    # Buffer count
    bufCount = len(actorsList) - 1
    bufCounter = 0

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

        # Node name
        entityName = str(actorsList[actor][1]).split("_")[0]

        # Update count and add ID to component
        if entityName == "INPUT":
            inputCount += 1
            if inputCount <= 1:
                archComponent = "    component " + str(entityName) + "_node is \n" + "        port ( \n"
        elif entityName == "add":
            addCount += 1
            if addCount <= 1:
                archComponent = "    component " + str(entityName) + "_node is \n" + "        port ( \n"
        elif entityName == "prod":
            prodCount += 1
            if prodCount <= 1:
                archComponent = "    component " + str(entityName) + "_node is \n" + "        port ( \n"
        elif entityName == "div":
            divCount += 1
            if divCount <= 1:
                archComponent = "    component " + str(entityName) + "_node is \n" + "        port ( \n"
        elif entityName == "OUTPUT":
            outputCount += 1
            if outputCount <= 1:
                archComponent = "    component " + str(entityName) + "_node is \n" + "        port ( \n"
        #Uncomment for unkown operators
        ''' 
        elif entityName != "INPUT" or "OUTPUT" or "add" or "prod" or "div":
            identityCount += 1
            archComponent = "    component " + str(entityName) + "_node is \n" + "        port ( \n"
        '''

        # Add clock + reset ports
        if inputCount and addCount and prodCount and divCount and outputCount <= 1:
            archComponent += "\n" + "            " + str(entityName) + "_clk : in std_logic; \n" +  "            " + str(entityName) + "_rst : in std_logic; \n\n"

        # Input ports
        if entityName == "INPUT" and inputCount <= 1:
            archComponent +=  "\n" + "            input_in_ready : in std_logic; \n" + "            input_out_ready : out std_logic; \n" + "\n" + "            input_in_valid : in std_logic; \n" + "            input_out_valid : out std_logic; \n" + "\n" + "            input_in_opening : in std_logic_vector(" + sdfName + "_ram_width - 1 downto 0); \n" + "            input_out_opening : out std_logic_vector(" + sdfName + "_ram_width - 1 downto 0) \n" + "    ); end component; \n\n"

            archComponents += archComponent
        
        # Output ports
        elif entityName == "OUTPUT" and outputCount <= 1:
            archComponent +=  "\n" + "            output_in_ready : in std_logic; \n" + "            output_out_ready : out std_logic; \n" + "\n" + "            output_in_valid : in std_logic; \n" + "            output_out_valid : out std_logic; \n" + "\n" + "            output_in_opening : in std_logic_vector(" + sdfName + "_ram_width - 1 downto 0); \n" + "            output_out_opening : out std_logic_vector(" + sdfName + "_ram_width - 1 downto 0) \n" + "    ); end component; \n\n"

            archComponents += archComponent

        elif entityName == "add" and addCount <= 1: #PLACEHOLDER
            archComponent +=  "            --Input1 \n" + "            add_in1_ready : in std_logic; \n" + "\n" + "            add_in1_valid : in std_logic; \n" + "\n" + "            add_in1_opening : in std_logic_vector(" + sdfName + "_ram_width - 1 downto 0); \n" + "\n\n" + "            --Input2 \n" + "            add_in2_ready : in std_logic; \n" + "\n" + "            add_in2_valid : in std_logic; \n" + "\n" + "            add_in2_opening : in std_logic_vector(" + sdfName + "_ram_width - 1 downto 0); \n" + "\n\n" + "            --Output \n" + "            add_out_ready : out std_logic; \n" + "\n" + "            add_out_valid : out std_logic; \n" + "\n" + "            add_out_opening : out std_logic_vector(" + sdfName + "_ram_width - 1 downto 0) \n" + "    ); end component; \n\n"

            archComponents += archComponent

        elif entityName == "prod" and prodCount <= 1: #PLACEHOLDER
            archComponent +=  "            --Input1 \n" + "            prod_in1_ready : in std_logic; \n" + "\n" + "            prod_in1_valid : in std_logic; \n" + "\n" + "            prod_in1_opening : in std_logic_vector(" + sdfName + "_ram_width - 1 downto 0); \n" + "\n\n" + "            --Input2 \n" + "            prod_in2_ready : in std_logic; \n" + "\n" + "            prod_in2_valid : in std_logic; \n" + "\n" + "            prod_in2_opening : in std_logic_vector(" + sdfName + "_ram_width - 1 downto 0); \n" + "\n\n" + "            --Output \n" + "            prod_out_ready : out std_logic; \n" + "\n" + "            prod_out_valid : out std_logic; \n" + "\n" + "            prod_out_opening : out std_logic_vector(" + sdfName + "_ram_width - 1 downto 0) \n" + "    ); end component; \n\n"

            archComponents += archComponent

        elif entityName == "div" and divCount <= 1: #PLACEHOLDER
            archComponent +=  "            --Input1 \n" + "            div_in1_ready : in std_logic; \n" + "\n" + "            div_in1_valid : in std_logic; \n" + "\n" + "            div_in1_opening : in std_logic_vector(" + sdfName + "_ram_width - 1 downto 0); \n" + "\n\n" + "            --Input2 \n" + "            div_in2_ready : in std_logic; \n" + "\n" + "            div_in2_valid : in std_logic; \n" + "\n" + "            div_in2_opening : in std_logic_vector(" + sdfName + "_ram_width - 1 downto 0); \n" + "\n\n" + "            --Output \n" + "            div_out_ready : out std_logic; \n" + "\n" + "            div_out_valid : out std_logic; \n" + "\n" + "            div_out_opening : out std_logic_vector(" + sdfName + "_ram_width - 1 downto 0) \n" + "    ); end component; \n\n"

            archComponents += archComponent

        # Uncomment for unkown operators
        '''
        elif entityName != "INPUT" or "OUTPUT" or "add" or "prod" or "div":
            archComponents +=  "\n" + "            entity_in_ready : in std_logic; \n" + "            entity_out_ready : out std_logic; \n" + "\n" + "            entity_in_valid : in std_logic; \n" + "            entity_out_valid : out std_logic; \n" + "\n" + "            entity_in_opening : in std_logic_vector(" + sdfName + "_ram_width - 1 downto 0); \n" + "            entity_out_opening : out std_logic_vector(" + sdfName + "_ram_width - 1 downto 0) \n" + "    ); end component; \n\n"

            archComponents += archComponent
        '''

    # Arch buffer
    archBuffer = "\n" + "    component axi_fifo is \n" + "        generic ( \n" + "            ram_width : natural; \n" + "            ram_depth : natural \n" + "        ); \n" + "        Port ( \n" + "            buf_clk : in std_logic; \n" + "            buf_rst : in std_logic; \n" + " \n" + "            buf_in_ready : out std_logic; \n" + "            buf_in_valid : in std_logic; \n" + "            buf_in_data : in std_logic_vector(" + sdfName + "_ram_width - 1 downto 0); \n" + " \n" + "            buf_out_ready : in std_logic; \n" + "            buf_out_valid : out std_logic; \n" + "            buf_out_data : out std_logic_vector(" + sdfName + "_ram_width - 1 downto 0) \n" + "        ); end component;" + "\n"



    # Other Port instantiation
    # portsList = actorsList[actor][3]

    # Arch signals
    archSignals = ""

    # Index of signals for mappings
    node_signals_data = []
    node_signals_ready = []
    node_signals_valid = []
    

    # Arch data signals
    archSignals += "\n\n signal "
    for signal in range(len(nodeSignals)):
        # Signal name
        signalName = str(nodeSignals[signal][0])

        # Signal src
        signalSrcName = str(nodeSignals[signal][1][0])

        # Signal dst
        signalDstName = str(nodeSignals[signal][1][1])

        # Full signal declaration to buffer
        signalFullNameToBuffer = signalName + "__FROM__" + signalSrcName + "__TO_BUFFER__DATA"

        # Full signal declaration from buffer
        signalFullNameFromBuffer = signalName + "__FROM_BUFFER_TO__" + signalDstName + "__DATA"

        # Make pair for buffer handling
        bothDataSigs = []
        bothDataSigs.append(signalFullNameToBuffer)
        bothDataSigs.append(signalFullNameFromBuffer)

        # Add pair to signals list
        node_signals_data.append(bothDataSigs)
        
        
        # Add to signals component handling commas
        archSignals += signalFullNameToBuffer + ", " + signalFullNameFromBuffer + ", "
    
    # Remove separator for data signals
    archSignals = archSignals[:-2]

    # Add remainder for data signals
    archSignals += " : std_logic_vector(" + sdfName + "_ram_width - 1 downto 0); \n"

    # Arch ready + valid signals
    archSignals += "signal "
    for signal in range(len(nodeSignals)):
        # Signal name
        signalName = str(nodeSignals[signal][0])

        # Signal src
        signalSrcName = str(nodeSignals[signal][1][0])

        # Signal dst
        signalDstName = str(nodeSignals[signal][1][1])

        # Bunching both ready/valid signals for buffer handling
        bothReadySigs = []
        bothValidSigs = []

        # Full ready signal declaration to buffers
        signalFullNameToBufferReady = signalName + "__FROM__" + signalSrcName + "__TO_BUFFER__READY"
        bothReadySigs.append(signalFullNameToBufferReady)

        # Full ready signal declaration from buffers
        signalFullNameFromBufferReady = signalName + "__FROM_BUFFER_TO__" + signalDstName + "__READY"
        bothReadySigs.append(signalFullNameFromBufferReady)

        node_signals_ready.append(bothReadySigs)
        
        # Full valid signal declaration to buffers
        signalFullNameToBufferValid = signalName + "__FROM__" + signalSrcName + "__TO_BUFFER__VALID"
        bothValidSigs.append(signalFullNameToBufferValid)

        # Full valid signal declaration from buffers
        signalFullNameFromBufferValid = signalName + "__FROM_BUFFER_TO__" + signalDstName + "__VALID"
        bothValidSigs.append(signalFullNameFromBufferValid)

        node_signals_valid.append(bothValidSigs)

        # Add to signals component handling commas
        archSignals += signalFullNameToBufferReady + ", " + signalFullNameFromBufferReady + ", " + signalFullNameToBufferValid + ", " + signalFullNameFromBufferValid + ", "
    
    # # Remove separator for ready + valid signals
    archSignals = archSignals[:-2]
    
    # Add ready + valid signals remainder
    archSignals += " : std_logic; \n\n\n"



    # Arch mapping
    archMappings = "begin \n\n"

    # Counters for names
    inputs = 0
    outputs = 0
    adds = 0
    prods = 0
    divs = 0

    # Node mapping
    for act in range(len(actorsList)):
    
        # Act name:
        actName = str(actorsList[act][1]).split("_")[0]

        # Connected actors
        conAct = len(actorsList) - 1

        # Reset buffer mapping
        buffer_mapping = ""

        # Add node mappings
        component_mapping = ""

        try:
            # Input node
            if actName == "INPUT":
                component_mapping += actName + "_" + str(inputs) + " : " + str(actName) + "_node"

                # Port Map
                component_mapping += " PORT MAP ("

                # Clock + reset
                component_mapping += "           " + str(sdfName) + "_clk => " + str(actName) + "_clk, \n" + "                                            " + str(sdfName) + "_rst => " + str(actName) + "_rst, \n\n"

                # AXI ready
                component_mapping +=  "                                            " + str(actName) + "_in_ready => " + str(sdfName) + "_in_ready, \n" +  "                                            " + str(actName) + "_out_ready => " + node_signals_ready[act][0] + ", \n\n"
            
                # AXI valid
                component_mapping += "                                            " + str(actName) + "_in_valid => " + str(sdfName) + "_in_valid, \n" + "                                            " + str(actName) + "_out_valid => " + node_signals_valid[act][0] + ", \n\n"
                
                # AXI data
                component_mapping += "                                            " + str(actName) + "_in_opening => " + str(sdfName) + "_in_data, \n"

                component_mapping += "                                            " + str(actName) + "_out_opening => " + node_signals_data[act][0] + " \n" 

                # Node remainder
                component_mapping += "); \n\n"



                # Add a subsequent buffer
                buffer_mapping += "fifo_" + str(bufCounter) + " : axi_fifo"

                # Generic Map
                buffer_mapping += " GENERIC MAP       (" + sdfName + "_ram_width, \n" + "                                    " + sdfName + "_ram_depth \n" + "                                    ) \n"

                # Port Map
                buffer_mapping += "                    PORT MAP        ("

                # Clock + reset
                buffer_mapping += "buf_clk => " + sdfName + "_clk, \n" + "                                    buf_rst => " + sdfName + "_rst, \n\n"

                # AXI ready
                buffer_mapping +=  "                                    buf_in_ready => " + node_signals_ready[act][0] + ", \n" +  "                                    buf_out_ready => " + node_signals_ready[act][1] + ", \n\n"
            
                # AXI valid
                buffer_mapping +=  "                                    buf_in_valid => " + node_signals_valid[act][0] + ", \n" +  "                                    buf_out_valid => " + node_signals_valid[act][1] + ", \n\n"
                
                # AXI data
                buffer_mapping +=  "                                    buf_in_data => " + node_signals_data[act][0] + ", \n" +  "                                    buf_out_data => " + node_signals_data[act][1] + " \n"

                # Buffer remainder
                buffer_mapping += "); \n\n"

                # Update buffer count
                bufCount -= 1
                bufCounter += 1

                # Update input count
                inputs +=1 

                # Add component and buffer mappings to architecture
                archMappings += component_mapping + buffer_mapping


            # Output node
            if actName == "OUTPUT":
                component_mapping += actName + "_" + str(outputs) + " : " + str(actName) + "_node"

                # Port Map
                component_mapping += " PORT MAP ("

                # Clock + reset
                component_mapping += "           " + str(sdfName) + "_clk => " + str(actName) + "_clk, \n" + "                                            " + str(sdfName) + "_rst => " + str(actName) + "_rst, \n\n"

                # AXI ready
                component_mapping +=  "                                            " + str(actName) + "_in_ready => " + node_signals_ready[-1][0] + "_in_ready, \n" +  "                                            " + str(actName) + "_out_ready => " + str(sdfName) + ", \n\n"
            
                # AXI valid
                component_mapping += "                                            " + str(actName) + "_in_valid => " + node_signals_valid[-1][0] + "_in_valid, \n" + "                                            " + str(actName) + "_out_valid => " + str(sdfName) + ", \n\n"
                
                # AXI data
                component_mapping += "                                            " + str(actName) + "_in_opening => " + node_signals_data[-1][0] + "_in_data, \n"

                component_mapping += "                                            " + str(actName) + "_out_opening => " + str(sdfName) + " \n" 

                # Update input count
                outputs +=1 

                # Node remainder
                component_mapping += "); \n\n"


                # Add component and buffer mappings to architecture as no need for a subsequent buffer for OUTPUT
                archMappings += component_mapping + buffer_mapping



            elif actName == "add":
                component_mapping += actName + "_" + str(adds) + " : " + str(actName) + "_node"

                # Port Map
                component_mapping += " PORT MAP ("

                # Clock + reset
                component_mapping += "           " + str(actName) + "_clk => " + str(sdfName) + "_clk, \n" + "                                            " + str(actName) + "_rst => " + str(sdfName) + "_rst, \n\n"

                # Figure out predecessor and subsequent exterior signals
                actID = str(actorsList[act][2])
                
                toBuffReady = []
                toBuffValid = []
                toBuffData = []

                fromBuffReady = []
                fromBuffValid = []
                fromBuffData = []

                for readysig in range(len(node_signals_ready)):
                    if node_signals_ready[readysig][1].split("__")[-2] == actID and node_signals_ready[readysig][1].split("__")[-3] == "FROM_BUFFER_TO":
                        fromBuffReady.append(node_signals_ready[readysig][1])
                    elif node_signals_ready[readysig][0].split("__")[-3] == actID and node_signals_ready[readysig][0].split("__")[-2] == "TO_BUFFER":
                        toBuffReady.append(node_signals_ready[readysig][0])

                for validsig in range(len(node_signals_valid)):
                    if node_signals_valid[validsig][1].split("__")[-2] == actID and node_signals_valid[validsig][1].split("__")[-3] == "FROM_BUFFER_TO":
                        fromBuffValid.append(node_signals_valid[validsig][1])
                    elif node_signals_valid[validsig][0].split("__")[-3] == actID and node_signals_valid[validsig][0].split("__")[-2] == "TO_BUFFER":
                        toBuffValid.append(node_signals_valid[validsig][0])

                for datasig in range(len(node_signals_data)):
                    if node_signals_data[datasig][1].split("__")[-2] == actID and node_signals_data[datasig][1].split("__")[-3] == "FROM_BUFFER_TO":
                        fromBuffData.append(node_signals_data[datasig][1])
                    elif node_signals_data[datasig][0].split("__")[-3] == actID and node_signals_data[datasig][0].split("__")[-2] == "TO_BUFFER":
                        toBuffData.append(node_signals_data[datasig][0])
                
                # Input(s)
                for sig in range(len(fromBuffReady)):
                    component_mapping +=  "                                            " + str(actName) + "_in" + str(sig) + "_ready => " + fromBuffReady[sig] + ", \n" + "                                            " + str(actName) + "_in" + str(sig) + "_valid => " + fromBuffValid[sig] + ", \n" + "                                            " + str(actName) + "_in" + str(sig) + "_opening => " + fromBuffData[sig] + ", \n\n"

                # Output(s)
                for sig in range(len(toBuffReady)):
                    component_mapping += "                                            " + str(actName) + "_out" + str(sig) + "_ready => " + toBuffReady[sig][0] + ", \n" + "                                            " + str(actName) + "_out" + str(sig) + "_valid => " + toBuffValid[sig][0] + ", \n" + "                                            " + str(actName) + "_out" + str(sig) + "_opening => " + toBuffData[sig][0] + " \n" 
                

                # Node remainder
                component_mapping += "); \n\n"



                # Add a subsequent buffer
                buffer_mapping += "fifo_" + str(bufCounter) + " : axi_fifo"

                # Generic Map
                buffer_mapping += " GENERIC MAP       (" + sdfName + "_ram_width, \n" + "                                    " + sdfName + "_ram_depth \n" + "                                    ) \n"

                # Port Map
                buffer_mapping += "                    PORT MAP        ("

                # Clock + reset
                buffer_mapping += "buf_clk => " + sdfName + "_clk, \n" + "                                    buf_rst => " + sdfName + "_rst, \n\n"


                # Figure out buffer subsequent exterior signals
                for sig in range(len(nodeSignals)):
                    if nodeSignals[sig][1][0] == actID:
                        sigFromBufName = nodeSignals[sig][2][0].split("_")[1] + nodeSignals[sig][2][0].split("_")[2]

                for readySig in range(len(node_signals_ready)):
                    if str(node_signals_ready[readySig][0]).split("_")[0] + str(node_signals_ready[readySig]).split("_")[1]  == sigFromBufName:
                        fromCurBuffReady = node_signals_ready[readySig][0]
                for validSig in range(len(node_signals_valid)):
                    if str(node_signals_valid[validSig][0]).split("_")[0] + str(node_signals_valid[validSig]).split("_")[1]  == sigFromBufName:
                        fromCurBuffValid = node_signals_valid[validSig][0]
                for dataSig in range(len(node_signals_data)):
                    if str(node_signals_data[dataSig][0]).split("_")[0] + str(node_signals_data[dataSig]).split("_")[1]  == sigFromBufName:
                        fromCurBuffData = node_signals_data[dataSig][0]

                
                # AXI ready
                buffer_mapping +=  "                                    buf_in_ready => " + toBuffReady[0][0] + ", \n" +  "                                    buf_out_ready => " + str(fromCurBuffReady) + ", \n\n"
            
                # AXI valid
                buffer_mapping +=  "                                    buf_in_valid => " + toBuffValid[0][0] + ", \n" +  "                                    buf_out_valid => " + str(fromCurBuffValid) + ", \n\n"
                
                # AXI data
                buffer_mapping +=  "                                    buf_in_data => " + toBuffData[0][0] + ", \n" +  "                                    buf_out_data => " + str(fromCurBuffData) + " \n"

                # Buffer remainder
                buffer_mapping += "); \n\n"

                # Update buffer count
                bufCount -= 1
                bufCounter += 1

                # Update add count
                adds +=1 

                # Add component and buffer mappings to architecture
                archMappings += component_mapping + buffer_mapping


            elif actName == "prod":
                component_mapping += actName + "_" + str(prods) + " : " + str(actName) + "_node"

                # Port Map
                component_mapping += " PORT MAP ("

                # Clock + reset
                component_mapping += "           " + str(actName) + "_clk => " + str(sdfName) + "_clk, \n" + "                                            " + str(actName) + "_rst => " + str(sdfName) + "_rst, \n\n"

                # Figure out predecessor and subsequent exterior signals
                actID = str(actorsList[act][2])
                
                toBuffReady = []
                toBuffValid = []
                toBuffData = []

                fromBuffReady = []
                fromBuffValid = []
                fromBuffData = []

                for readysig in range(len(node_signals_ready)):
                    if node_signals_ready[readysig][1].split("__")[-2] == actID and node_signals_ready[readysig][1].split("__")[-3] == "FROM_BUFFER_TO":
                        fromBuffReady.append(node_signals_ready[readysig][1])
                    elif node_signals_ready[readysig][0].split("__")[-3] == actID and node_signals_ready[readysig][0].split("__")[-2] == "TO_BUFFER":
                        toBuffReady.append(node_signals_ready[readysig][0])

                for validsig in range(len(node_signals_valid)):
                    if node_signals_valid[validsig][1].split("__")[-2] == actID and node_signals_valid[validsig][1].split("__")[-3] == "FROM_BUFFER_TO":
                        fromBuffValid.append(node_signals_valid[validsig][1])
                    elif node_signals_valid[validsig][0].split("__")[-3] == actID and node_signals_valid[validsig][0].split("__")[-2] == "TO_BUFFER":
                        toBuffValid.append(node_signals_valid[validsig][0])

                for datasig in range(len(node_signals_data)):
                    if node_signals_data[datasig][1].split("__")[-2] == actID and node_signals_data[datasig][1].split("__")[-3] == "FROM_BUFFER_TO":
                        fromBuffData.append(node_signals_data[datasig][1])
                    elif node_signals_data[datasig][0].split("__")[-3] == actID and node_signals_data[datasig][0].split("__")[-2] == "TO_BUFFER":
                        toBuffData.append(node_signals_data[datasig][0])
                
                # Input(s)
                for sig in range(len(fromBuffReady)):
                    component_mapping +=  "                                            " + str(actName) + "_in" + str(sig) + "_ready => " + fromBuffReady[sig] + ", \n" + "                                            " + str(actName) + "_in" + str(sig) + "_valid => " + fromBuffValid[sig] + ", \n" + "                                            " + str(actName) + "_in" + str(sig) + "_opening => " + fromBuffData[sig] + ", \n\n"

                # Output(s)
                for sig in range(len(toBuffReady)):
                    component_mapping += "                                            " + str(actName) + "_out" + str(sig) + "_ready => " + toBuffReady[sig][0] + ", \n" + "                                            " + str(actName) + "_out" + str(sig) + "_valid => " + toBuffValid[sig][0] + ", \n" + "                                            " + str(actName) + "_out" + str(sig) + "_opening => " + toBuffData[sig][0] + " \n" 
                

                # Node remainder
                component_mapping += "); \n\n"



                # Add a subsequent buffer
                buffer_mapping += "fifo_" + str(bufCounter) + " : axi_fifo"

                # Generic Map
                buffer_mapping += " GENERIC MAP       (" + sdfName + "_ram_width, \n" + "                                    " + sdfName + "_ram_depth \n" + "                                    ) \n"

                # Port Map
                buffer_mapping += "                    PORT MAP        ("

                # Clock + reset
                buffer_mapping += "buf_clk => " + sdfName + "_clk, \n" + "                                    buf_rst => " + sdfName + "_rst, \n\n"


                # Figure out buffer subsequent exterior signals
                for sig in range(len(nodeSignals)):
                    if nodeSignals[sig][1][0] == actID:
                        sigFromBufName = nodeSignals[sig][2][0].split("_")[1] + nodeSignals[sig][2][0].split("_")[2]

                for readySig in range(len(node_signals_ready)):
                    if str(node_signals_ready[readySig][0]).split("_")[0] + str(node_signals_ready[readySig]).split("_")[1]  == sigFromBufName:
                        fromCurBuffReady = node_signals_ready[readySig][0]
                for validSig in range(len(node_signals_valid)):
                    if str(node_signals_valid[validSig][0]).split("_")[0] + str(node_signals_valid[validSig]).split("_")[1]  == sigFromBufName:
                        fromCurBuffValid = node_signals_valid[validSig][0]
                for dataSig in range(len(node_signals_data)):
                    if str(node_signals_data[dataSig][0]).split("_")[0] + str(node_signals_data[dataSig]).split("_")[1]  == sigFromBufName:
                        fromCurBuffData = node_signals_data[dataSig][0]

                
                # AXI ready
                buffer_mapping +=  "                                    buf_in_ready => " + toBuffReady[0][0] + ", \n" +  "                                    buf_out_ready => " + str(fromCurBuffReady) + ", \n\n"
            
                # AXI valid
                buffer_mapping +=  "                                    buf_in_valid => " + toBuffValid[0][0] + ", \n" +  "                                    buf_out_valid => " + str(fromCurBuffValid) + ", \n\n"
                
                # AXI data
                buffer_mapping +=  "                                    buf_in_data => " + toBuffData[0][0] + ", \n" +  "                                    buf_out_data => " + str(fromCurBuffData) + " \n"

                # Buffer remainder
                buffer_mapping += "); \n\n"

                # Update buffer count
                bufCount -= 1
                bufCounter += 1

                # Update prod count
                prods +=1 

                # Add component and buffer mappings to architecture
                archMappings += component_mapping + buffer_mapping


            elif actName == "div":
                component_mapping += actName + "_" + str(divs) + " : " + str(actName) + "_node"

                # Port Map
                component_mapping += " PORT MAP ("

                # Clock + reset
                component_mapping += "           " + str(actName) + "_clk => " + str(sdfName) + "_clk, \n" + "                                            " + str(actName) + "_rst => " + str(sdfName) + "_rst, \n\n"

                # Figure out predecessor and subsequent exterior signals
                actID = str(actorsList[act][2])
                
                toBuffReady = []
                toBuffValid = []
                toBuffData = []

                fromBuffReady = []
                fromBuffValid = []
                fromBuffData = []

                for readysig in range(len(node_signals_ready)):
                    if node_signals_ready[readysig][1].split("__")[-2] == actID and node_signals_ready[readysig][1].split("__")[-3] == "FROM_BUFFER_TO":
                        fromBuffReady.append(node_signals_ready[readysig][1])
                    elif node_signals_ready[readysig][0].split("__")[-3] == actID and node_signals_ready[readysig][0].split("__")[-2] == "TO_BUFFER":
                        toBuffReady.append(node_signals_ready[readysig][0])

                for validsig in range(len(node_signals_valid)):
                    if node_signals_valid[validsig][1].split("__")[-2] == actID and node_signals_valid[validsig][1].split("__")[-3] == "FROM_BUFFER_TO":
                        fromBuffValid.append(node_signals_valid[validsig][1])
                    elif node_signals_valid[validsig][0].split("__")[-3] == actID and node_signals_valid[validsig][0].split("__")[-2] == "TO_BUFFER":
                        toBuffValid.append(node_signals_valid[validsig][0])

                for datasig in range(len(node_signals_data)):
                    if node_signals_data[datasig][1].split("__")[-2] == actID and node_signals_data[datasig][1].split("__")[-3] == "FROM_BUFFER_TO":
                        fromBuffData.append(node_signals_data[datasig][1])
                    elif node_signals_data[datasig][0].split("__")[-3] == actID and node_signals_data[datasig][0].split("__")[-2] == "TO_BUFFER":
                        toBuffData.append(node_signals_data[datasig][0])
                
                # Input(s)
                for sig in range(len(fromBuffReady)):
                    component_mapping +=  "                                            " + str(actName) + "_in" + str(sig) + "_ready => " + fromBuffReady[sig] + ", \n" + "                                            " + str(actName) + "_in" + str(sig) + "_valid => " + fromBuffValid[sig] + ", \n" + "                                            " + str(actName) + "_in" + str(sig) + "_opening => " + fromBuffData[sig] + ", \n\n"

                # Output(s)
                for sig in range(len(toBuffReady)):
                    component_mapping += "                                            " + str(actName) + "_out" + str(sig) + "_ready => " + toBuffReady[sig][0] + ", \n" + "                                            " + str(actName) + "_out" + str(sig) + "_valid => " + toBuffValid[sig][0] + ", \n" + "                                            " + str(actName) + "_out" + str(sig) + "_opening => " + toBuffData[sig][0] + " \n" 
                

                # Node remainder
                component_mapping += "); \n\n"



                # Add a subsequent buffer
                buffer_mapping += "fifo_" + str(bufCounter) + " : axi_fifo"

                # Generic Map
                buffer_mapping += " GENERIC MAP       (" + sdfName + "_ram_width, \n" + "                                    " + sdfName + "_ram_depth \n" + "                                    ) \n"

                # Port Map
                buffer_mapping += "                    PORT MAP        ("

                # Clock + reset
                buffer_mapping += "buf_clk => " + sdfName + "_clk, \n" + "                                    buf_rst => " + sdfName + "_rst, \n\n"


                # Figure out buffer subsequent exterior signals
                for sig in range(len(nodeSignals)):
                    if nodeSignals[sig][1][0] == actID:
                        sigFromBufName = nodeSignals[sig][2][0].split("_")[1] + nodeSignals[sig][2][0].split("_")[2]

                for readySig in range(len(node_signals_ready)):
                    if str(node_signals_ready[readySig][0]).split("_")[0] + str(node_signals_ready[readySig]).split("_")[1]  == sigFromBufName:
                        fromCurBuffReady = node_signals_ready[readySig][0]
                for validSig in range(len(node_signals_valid)):
                    if str(node_signals_valid[validSig][0]).split("_")[0] + str(node_signals_valid[validSig]).split("_")[1]  == sigFromBufName:
                        fromCurBuffValid = node_signals_valid[validSig][0]
                for dataSig in range(len(node_signals_data)):
                    if str(node_signals_data[dataSig][0]).split("_")[0] + str(node_signals_data[dataSig]).split("_")[1]  == sigFromBufName:
                        fromCurBuffData = node_signals_data[dataSig][0]

                
                # AXI ready
                buffer_mapping +=  "                                    buf_in_ready => " + toBuffReady[0][0] + ", \n" +  "                                    buf_out_ready => " + str(fromCurBuffReady) + ", \n\n"
            
                # AXI valid
                buffer_mapping +=  "                                    buf_in_valid => " + toBuffValid[0][0] + ", \n" +  "                                    buf_out_valid => " + str(fromCurBuffValid) + ", \n\n"
                
                # AXI data
                buffer_mapping +=  "                                    buf_in_data => " + toBuffData[0][0] + ", \n" +  "                                    buf_out_data => " + str(fromCurBuffData) + " \n"

                # Buffer remainder
                buffer_mapping += "); \n\n"

                # Update buffer count
                bufCount -= 1
                bufCounter += 1

                # Update div count
                divs +=1 

                # Add component and buffer mappings to architecture
                archMappings += component_mapping + buffer_mapping


            # Uncomment in case of unkown operators:
            '''
            elif actName != "INPUT" or "OUTPUT" or "add" or "prod" or "div": # Identity node
                identityCount += 1
                node_mapping += nodeName + "_" + str(act) + " : entity_node"

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

                node_mapping += "                                            entity_out_opening => " + node_signals_data[actor][0] + "\n\n"

                # Node remainder
                node_mapping += "); \n\n"

                # Add to architecture
                archMappings += node_mapping

                # Add a subsequent buffer
                buffer_mapping += "fifo_" + str(bufCounter) + " : axi_fifo"

                # Generic Map
                buffer_mapping += " GENERIC MAP       (" + sdfName + "_ram_width, \n" + "                                    " + sdfName + "_ram_depth \n" + "                                    ) \n"

                # Port Map
                buffer_mapping += "                    PORT MAP        ("

                # Clock + reset
                buffer_mapping += "buf_clk => " + sdfName + "_clk, \n" + "                                    buf_rst => " + sdfName + "_rst, \n\n"


                # Figure out buffer subsequent exterior signals
                for sig in range(len(nodeSignals)):
                    if nodeSignals[sig][1][0] == actID:
                        sigFromBufName = nodeSignals[sig][2][0].split("_")[1] + nodeSignals[sig][2][0].split("_")[2]

                for readySig in range(len(node_signals_ready)):
                    if str(node_signals_ready[readySig][0]).split("_")[0] + str(node_signals_ready[readySig]).split("_")[1]  == sigFromBufName:
                        fromCurBuffReady = node_signals_ready[readySig][0]
                for validSig in range(len(node_signals_valid)):
                    if str(node_signals_valid[validSig][0]).split("_")[0] + str(node_signals_valid[validSig]).split("_")[1]  == sigFromBufName:
                        fromCurBuffValid = node_signals_valid[validSig][0]
                for dataSig in range(len(node_signals_data)):
                    if str(node_signals_data[dataSig][0]).split("_")[0] + str(node_signals_data[dataSig]).split("_")[1]  == sigFromBufName:
                        fromCurBuffData = node_signals_data[dataSig][0]

                
                # AXI ready
                buffer_mapping +=  "                                    buf_in_ready => " + toBuffReady[0][0] + ", \n" +  "                                    buf_out_ready => " + str(fromCurBuffReady) + ", \n\n"
            
                # AXI valid
                buffer_mapping +=  "                                    buf_in_valid => " + toBuffValid[0][0] + ", \n" +  "                                    buf_out_valid => " + str(fromCurBuffValid) + ", \n\n"
                
                # AXI data
                buffer_mapping +=  "                                    buf_in_data => " + toBuffData[0][0] + ", \n" +  "                                    buf_out_data => " + str(fromCurBuffData) + " \n"

                # Buffer remainder
                buffer_mapping += "); \n\n"

                # Update buffer count
                bufCount -= 1
                bufCounter += 1

                # Add component and buffer mappings to architecture
                archMappings += component_mapping + buffer_mapping
            '''
        
        except:
            print("Unkown operator found: " + actName + ". Did you uncomment Unkowns?")
            raise





    # Bringing the architecture together
    arch_remainder = "\n end " + str(sdfArch) + "; \n"
    
    wrapperArch += archComponents + archBuffer + archSignals + archMappings

    wholeWrapper = librariesComponent + "\n" + entityComponent + "\n" + wrapperArch + arch_remainder

    # File name
    fileName = str(sdfName) + "_wrapper"

    # Add into the output subdirectory
    direc = str(outputName) + "/" + fileName + ".vhdl"
    filewrite = open(direc,"w")
    filewrite.write(str(wholeWrapper))
    filewrite.close()
