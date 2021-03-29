# This file creates an instance of an entity node.

def returnTB(sdfName, sdfArch, outputName, actorsList, interiorConnections, nodeSignals, clock_period, ram_depth, ram_width):

    wholeTB = ""

    # Libraries import
    TBlibrariesComponent = str(
    "library ieee; \n" + 
    "use ieee.std_logic_1164.all;\n" +
    "use ieee.numeric_std.all;\n\n" +
    "use std.env.finish;"
    )


    # Wrapper entity component
    TBentityComponent = "entity " + sdfName + "_testbench is \n" + "end " + sdfName + "_testbench; \n\n"

    # Architecture
    TBArch = "architecture " + str(sdfArch) + " of " + sdfName + "_testbench is \n\n"

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

    # All signals
    TBarchSignals = ""

    # Testbench constants
    TBarchConstants = ""

    TBarchConstants += "  -- testbench constants \n" + "  constant clock_period : time := " + str(clock_period) + " ns; \n" + "  constant " + str(sdfName) + "_ram_width : natural := " + str(ram_depth) + "; \n" + "  constant " + str(sdfName) + "_ram_depth : natural := " + str(ram_width) + "; \n\n"

    # Testbench signals

    # Clk and rst signals
    TBarchSignals += "  -- signals \n" + "  signal clk : std_logic := '1'; \n" + "  signal rst : std_logic := '1'; \n\n"

    # Find how many input and output signals needed
    inputCtr = 0
    outputCtr = 0
    for actor in range(len(actorsList)):
        # Node name
        entityName = str(actorsList[actor][1]).split("_")[0]
        if entityName == "INPUT":
            inputCtr += 1
        if entityName == "OUTPUT":
            outputCtr += 1

    # TB entity AXI Input signals
    for inpt in range(0,inputCtr):
        TBarchSignals +=  "  signal " + sdfName + "_in" + str(inpt) + "_ready : std_logic; \n" +  "  signal " + sdfName + "_in" + str(inpt) + "_valid : std_logic := '0'; \n" +  "  signal " + sdfName + "_in" + str(inpt) + "_data : std_logic_vector(" + str(sdfName) + "_ram_width - 1 downto 0) := (others => '0');  \n\n"
    
    # TB entity AXI Output signals
    for outpt in range(0,outputCtr):
        TBarchSignals += "  signal " + str(sdfName) + "_out" + str(outpt) + "_ready : std_logic := '0'; \n" +  "  signal " + sdfName + "_out" + str(outpt) + "_valid : std_logic; \n" +  "  signal " + str(sdfName) + "_out" + str(outpt) + "_data : std_logic_vector(" + str(sdfName) + "_ram_width - 1 downto 0); \n" + "  signal expected_" + str(sdfName) + "_out" + str(outpt) + "_data : std_logic_vector(" + str(sdfName) + "_ram_width - 1 downto 0) := (others => '0'); \n\n"

    TBArch += TBarchConstants + TBarchSignals + "\n\n"

    # Wrapper component
    TBComponent = ""

    '''
    # Component + generics + clk/rst ports
    TBComponent += "  component " + str(sdfName) + " is \n" + "      generic ( \n" + "          " + str(sdfName) + "_ram_width : natural; \n" + "          " + str(sdfName) + "_ram_depth : natural \n" + "      ); \n" + "      port ( \n" + "          " + str(sdfName) + "_clk : in std_logic; \n" + "          " + str(sdfName) + "_rst : in std_logic; \n" + "\n"

    # TB entity AXI inputs
    for inpt in range(0,inputCtr):
        TBComponent += "          " + str(sdfName) + "_in" + str(inpt) + "_ready : in std_logic; \n" + "          " + str(sdfName) + "_in" + str(inpt) + "_valid : in std_logic; \n" + "          " + str(sdfName) + "_in" + str(inpt) + "_data : in std_logic_vector(" + str(sdfName) + "_ram_width - 1 downto 0); \n" + " \n"

    # TB entity AXI outputs
    for outpt in range(0,outputCtr):
        TBComponent += "          " + str(sdfName) + "_out" + str(outpt) + "_ready : out std_logic; \n" + "          " + str(sdfName) + "_out" + str(outpt) + "_valid : out std_logic; \n" + "          " + str(sdfName) + "_out" + str(outpt) + "_data : out std_logic_vector(" + str(sdfName) + "_ram_width - 1 downto 0)"
        if outpt < (outputCtr - 1):
            TBComponent += "; \n\n"
        elif outpt == (outputCtr - 1):
            TBComponent += " \n      ); end component; \n\n\n"

    TBArch += TBComponent
    '''

    TBMappings = "begin \n\n"

    # Clk designation
    TBcomponentMapping = "    -- clock ticking \n" + "  clk <= not clk after clock_period / 2; \n\n"

    # Wrapper component mapping
    TBcomponentMapping += "    -- Instantiate the wrapper to be tested\n" + "  " + str(sdfName) + "_wrapper : entity work." + str(sdfName) + "(" + str(sdfArch) + ") \n" + "              GENERIC MAP (" + str(sdfName) + "_ram_width, \n" + "                          " + str(sdfName) + "_ram_depth \n" + "                          ) \n" + "              PORT MAP    ( \n" + "                          " + str(sdfName) + "_clk => clk, \n" + "                          " + str(sdfName) + "_rst => rst, \n" + " \n"

    # TB entity AXI input mapping
    for inpt in range(0,inputCtr):
        TBcomponentMapping += "                          " + str(sdfName) + "_in" + str(inpt) + "_ready => " + str(sdfName) + "_in" + str(inpt) + "_ready, \n" + "                          " + str(sdfName) + "_in" + str(inpt) + "_valid => " + str(sdfName) + "_in" + str(inpt) + "_valid, \n" + "                          " + str(sdfName) + "_in" + str(inpt) + "_data => " + str(sdfName) + "_in" + str(inpt) + "_data, \n" + " \n"
    
    # TB entity AXI input mapping
    for outpt in range(0,outputCtr):
        TBcomponentMapping += "                          " + str(sdfName) + "_out" + str(outpt) + "_ready => " + str(sdfName) + "_out" + str(outpt) + "_ready, \n" + "                          " + str(sdfName) + "_out" + str(outpt) + "_valid => " + str(sdfName) + "_out" + str(outpt) + "_valid, \n" + "                          " + str(sdfName) + "_out" + str(outpt) + "_data => " + str(sdfName) + "_out" + str(outpt) + "_data"
        
        #Remainder of component mappings
        if outpt < (outputCtr - 1):
            TBcomponentMapping += ", \n\n"
        elif outpt == (outputCtr - 1):
            TBcomponentMapping += "\n                          ); \n\n\n"



    # TB Processes
    
    # TB Send Process
    TBSendProc = "    -- Sequential test process" + "    send_proc : process is \n" + "    begin \n\n"

    # Reset system
    TBSendProc += "        -- Reset system \n" + "        rst <= '1'; \n" +  "        wait until rising_edge(clk); \n\n" + "        rst <= '0'; \n" + "        wait until rising_edge(clk); \n\n"
    
    # Adding data to input(s)
    TBSendProc += "        report \"Adding input...\"; \n\n" + "        -- Loop to start writing inside 10 values \n\n"
    
    # Loading every input
    for inpt in range(0,inputCtr):
        TBSendProc += "        while unsigned(" + str(sdfName) + "_in" + str(inpt) + "_data) < 10 loop \n\n"
        
        # Wait
        TBSendProc += "            report \"Writing one data iteration to INPUT_" +  str(inpt) + "...\"; \n" + "            wait until rising_edge(clk); \n\n"
        
        # Loading all inputs
        TBSendProc += "            if " + str(sdfName) + "_in" + str(inpt) + "_valid = '1' and " + str(sdfName) + "_in" + str(inpt) + "_ready = '1' then \n" + "                " + str(sdfName) + "_in" + str(inpt) + "_data <= std_logic_vector(unsigned(" + str(sdfName) + "_in" + str(inpt) + "_data) + 1); \n" + "                " + str(sdfName) + "_in" + str(inpt) + "_valid <= '0'; \n" + "            elsif " + str(sdfName) + "_in" + str(inpt) + "_valid = '0' then \n" + "                " + str(sdfName) + "_in" + str(inpt) + "_valid <= '1'; \n" +  "            end if; \n\n" + "        end loop; \n\n"

    TBSendProc += "        report \"Writing completed...\"; \n" + "        finish;\n\n" + "    end process; \n\n\n"



    # TB Receieve Process
    TBReceiveProc = "    receive_proc : process is \n" + "    begin \n\n"

    # Reset system
    TBReceiveProc += "        -- Wait for the buffer to get full \n" + "        report \"Wait for filling...\"; \n"
    
    for outpt in range(0,outputCtr):
        TBReceiveProc += "        " + str(sdfName) + "_out" + str(outpt) + "_ready <= '0'; \n"

    TBReceiveProc += "        wait for 10 * clock_period; \n\n" + "        -- Loop to start reading data \n\n" + "        report \"Start reading data...\";"

    
    # Reading data from output(s)
    for outpt in range(0,outputCtr):
        TBReceiveProc += "        while unsigned(expected_" + str(sdfName) + "_out" + str(outpt) + "_data) < 10 loop \n\n"


    # Reading every input
    for outpt in range(0,outputCtr):
        TBReceiveProc += "        while unsigned(" + str(sdfName) + "_in" + str(outpt) + "_data) < " + str(ram_width) + " loop \n\n"
        
        # Wait
        TBReceiveProc += "            report \"Reading from OUTPUT_" + str(outpt) + "...\"; \n" + "            report \"Writing one data iteration to input " +  str(sdfName) + "...\"; \n" + "            wait until rising_edge(clk); \n\n"

        # Read from every output
        TBReceiveProc += "            if " + str(sdfName) + "_out" + str(outpt) + "_valid = '1' and " + str(sdfName) + "_out" + str(outpt) + "_ready = '1' then \n " + "                expected_" + str(sdfName) + "_out" + str(outpt) + "_data <= std_logic_vector(unsigned(expected_" + str(sdfName) + "_out" + str(outpt) + "_data) + 1); \n" + "                " + str(sdfName) + "_out" + str(outpt) + "_ready <= '0'; \n" + "            elsif  " + str(sdfName) + "_out" + str(outpt) + "_ready = '0' then \n" + "                " + str(sdfName) + "_out" + str(outpt) + "_ready <= '1'; \n" + "            end if; \n\n"

        TBReceiveProc += "        end loop; \n\n"

    TBReceiveProc += "        report \"Test completed. Check waveform.\"; \n" + "        finish; \n\n" + "    end process; \n\n"


    # Bringing the architecture together
    TBArchRemainder = "end architecture; \n"
    TBArch += TBMappings + TBcomponentMapping + TBSendProc + TBReceiveProc + TBArchRemainder


    wholeTB = TBlibrariesComponent + "\n" + TBentityComponent + "\n" + TBArch

    # File name
    fileName = str(sdfName) + "_TB"

    # Add into the output subdirectory
    direc = str(outputName) + "/" + fileName + ".vhdl"
    filewrite = open(direc,"w")
    filewrite.write(str(wholeTB))
    filewrite.close()
