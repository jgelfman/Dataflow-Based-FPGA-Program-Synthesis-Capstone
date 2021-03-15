# This is a VHDL code generator that uses ElementTree XML to take in XML files describing dataflow graphs compiled using FAUST, and in-return produces the corresponding entities and connections in VHDL to be simulated in Xilinx Vivado.


# Set to true in case of unkown operators
Unkowns = False

import xml.etree.ElementTree as ET
#inputfile = "math.dsp-sig.xml" # TODO: delete later
inputfile = "copy1.dsp-sig.xml" # TODO: delete later
#inputfile = input("Enter the exact file name (e.g. copy1.dsp-sig.xml):")
# e.g. copy1.dsp-sig.xml

fileTree = ET.parse(inputfile)
fileRoot = fileTree.getroot()
applicationGraph = fileRoot[0]
sdf = applicationGraph[0]

# Get sdf name and type
sdfList = list((sdf.attrib).items())
sdfName = sdfList[0][1]
sdfType = sdfList[1][1]
sdfArch = sdfName + "_arch"

# Generate list of actor names + types + ports
actors = []
for actor in sdf.iter('actor'):
    listitem = list(actor.attrib.items())
    actors.append(listitem)

actorsList = []
for i in range(len(actors)):
    actorNumID = "Actor" + str(i+1)
    actorName = actors[i][0][1]
    actorType = actors[i][1][1]
    actorPorts = []

    # Generate list of port names + direction tuples
    for port in sdf[i].iter('port'):
            portName = port.get('name')
            portType = port.get('type')
            temp = (portName, portType)
            actorPorts.append(temp)
    temp = (actorNumID, actorType, actorName, actorPorts)
    actorsList.append(temp)
#(actorNumID, actorType, actorName, [(portName, direc), ...])

# Generate list of signals between all ports
signals = []
for channel in sdf.iter('channel'):
    listitem = list(channel.attrib.items())
    signals.append(listitem)

# Distinguish between interior and exterior signals
interiorConnections = []
nodeSignals = []

for i in range(len(signals)):
    signalName = signals[i][0][1]
    srcActor = signals[i][1][1]
    srcPort = signals[i][2][1]
    dstActor = signals[i][3][1]
    dstPort = signals[i][4][1]
    acts = (srcActor, dstActor)
    prts = (srcPort, dstPort)
    signal = [signalName, acts, prts]

    if signal[1][0] == signal[1][1]:
        interiorConnections.append(signal)
    else:
        nodeSignals.append(signal)
#[signalName, (srcActor, dstActor), (srcPort, dstPort)]


# Start creating files
# Create an output directory
import os
outputName = str(sdfName) + "_output"
resourcesFolder = str(outputName) + "/generator_resources"
os.makedirs(outputName, exist_ok = True)
os.makedirs(resourcesFolder, exist_ok = True)

# Create buffer VHDL file
import vhdl_generate_buffer
vhdl_generate_buffer.returnBuffer(sdfArch, resourcesFolder)

# Create input node VHDL file 
import vhdl_generate_input_node
vhdl_generate_input_node.returnInput(sdfArch, resourcesFolder)

# Create output entitiy node VHDL file 
import vhdl_generate_output_node
vhdl_generate_output_node.returnOutput(sdfArch, resourcesFolder)

# Setting in case not all operators used
AddExists = False
ProdExists = False
DivExists = False

# In case of an unkown operator
if Unkowns == True:
    PlaceholderNeeded = True 
else:
    PlaceholderNeeded = False

# Check which operator node files are required to be generated
for actor in range(len(actorsList)):
    
    # Node name
    nodeName = str(actorsList[actor][1]).split("_")[0]

    # Check which operator nodes are required to be generated
    if nodeName == "add":
        AddExists = True
    elif nodeName == "prod":
        ProdExists = True
    elif nodeName == "div":
        DivExists = True
    elif nodeName == "INPUT" or "OUTPUT" or "add" or "prod" or "div":
        PlaceholderNeeded = False

# Create a PLACEHOLDER add node VHDL file
import vhdl_generate_add_node
if AddExists == True:
    vhdl_generate_add_node.returnAdd(sdfArch, resourcesFolder)

# Create a PLACEHOLDER prod node VHDL file
import vhdl_generate_prod_node
if ProdExists == True:
    vhdl_generate_prod_node.returnProd(sdfArch, resourcesFolder)

# Create a PLACEHOLDER div node VHDL file
import vhdl_generate_div_node
if DivExists == True:
    vhdl_generate_div_node.returnDiv(sdfArch, resourcesFolder)

# Once complex operators are added, if operator unkown, create placeholder identity node VHDL file
import vhdl_generate_identity_node
if PlaceholderNeeded == True:
    vhdl_generate_identity_node.returnIdentityNode(sdfArch, resourcesFolder)

# Create wrapper VHDL file 
import vhdl_generate_wrapper
vhdl_generate_wrapper.returnWrapper(sdfName, sdfArch, outputName, actorsList, interiorConnections, nodeSignals)


# Create testbench connecting entities
import vhdl_generate_tb

# Ask user for clock_period
#clock_period = input("Enter the desired clock period time in ns (e.g. 10):") #TODO: Uncomment
clock_period = 10 # TODO: Delete later

# Ask user for ram width
#ram_depth = input("Enter the desired ram depth (e.g. 16):") #TODO: Uncomment
ram_depth = 16 # TODO: Delete later

# Ask user for ram depth
#ram_width = input("Enter the desired ram depth (e.g. 256):") #TODO: Uncomment
ram_width = 256 # TODO: Delete later

vhdl_generate_tb.returnTB(sdfName, sdfArch, outputName, actorsList, interiorConnections, nodeSignals, clock_period, ram_depth, ram_width)

print("\n" + "VHDL program generated successfully.\n" + "Find resources at " +  str(resourcesFolder) + "\n" + "To generate wavelength and schematic, open " + str(outputName) + "\n")



# Testing

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

# Find how many input and output connections needed
inputCtr = 0
outputCtr = 0
for actor in range(len(actorsList)):
    # Node name
    entityName = str(actorsList[actor][1]).split("_")[0]
    if entityName == "INPUT":
        inputCtr += 1
    if entityName == "OUTPUT":
        outputCtr += 1

# Wrapper entity AXI Inputs
for inpt in range(0,inputCtr):
    entityComponent +=  "        " + sdfName + "_in" + str(inpt) + "_ready : in std_logic; \n" +  "        " + sdfName + "_in" + str(inpt) + "_valid : in std_logic; \n" +  "        " + sdfName + "_in" + str(inpt) + "_data : in std_logic_vector; \n" + " \n"

# Wrapper entity AXI Outputs
for outpt in range(0,outputCtr):
    entityComponent += "        " + sdfName + "_out" + str(outpt) + "_ready : out std_logic; \n" +  "        " + sdfName + "_out" + str(outpt) + "_valid : out std_logic; \n" +  "        " + sdfName + "_out" + str(outpt) + "_data : out std_logic_vector \n" + "    ); \n" + "end; \n "


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
    #if inputCount and addCount and prodCount and divCount and outputCount <= 1:
    archComponent += "\n" + "            " + str(entityName) + "_clk : in std_logic; \n" +  "            " + str(entityName) + "_rst : in std_logic; \n\n"

    # Input ports
    if entityName == "INPUT" and inputCount <= 1:
        archComponent +=  "\n" + "            " + str(entityName) + "_in_ready : in std_logic; \n" + "            " + str(entityName) + "_out_ready : out std_logic; \n" + "\n" + "            " + str(entityName) + "_in_valid : in std_logic; \n" + "            " + str(entityName) + "_out_valid : out std_logic; \n" + "\n" + "            " + str(entityName) + "_in_opening : in std_logic_vector(" + sdfName + "_ram_width - 1 downto 0); \n" + "            " + str(entityName) + "_out_opening : out std_logic_vector(" + sdfName + "_ram_width - 1 downto 0) \n" + "    ); end component; \n\n"

        archComponents += archComponent
    
    # Output ports
    elif entityName == "OUTPUT" and outputCount <= 1:
        archComponent +=  "\n" + "            " + str(entityName) + "_in_ready : in std_logic; \n" + "            " + str(entityName) + "_out_ready : out std_logic; \n" + "\n" + "            " + str(entityName) + "_in_valid : in std_logic; \n" + "            " + str(entityName) + "_out_valid : out std_logic; \n" + "\n" + "            " + str(entityName) + "_in_opening : in std_logic_vector(" + sdfName + "_ram_width - 1 downto 0); \n" + "            " + str(entityName) + "_out_opening : out std_logic_vector(" + sdfName + "_ram_width - 1 downto 0) \n" + "    ); end component; \n\n"

        archComponents += archComponent

    elif entityName == "add" and addCount <= 1: #PLACEHOLDER
        archComponent +=  "            --Input1 \n" + "            " + str(entityName) + "_in1_ready : in std_logic; \n" + "\n" + "            " + str(entityName) + "_in1_valid : in std_logic; \n" + "\n" + "            " + str(entityName) + "_in1_opening : in std_logic_vector(" + sdfName + "_ram_width - 1 downto 0); \n" + "\n\n" + "            --Input2 \n" + "            " + str(entityName) + "_in2_ready : in std_logic; \n" + "\n" + "            " + str(entityName) + "_in2_valid : in std_logic; \n" + "\n" + "            " + str(entityName) + "_in2_opening : in std_logic_vector(" + sdfName + "_ram_width - 1 downto 0); \n" + "\n\n" + "            --Output \n" + "            " + str(entityName) + "_out_ready : out std_logic; \n" + "\n" + "            " + str(entityName) + "_out_valid : out std_logic; \n" + "\n" + "            " + str(entityName) + "_out_opening : out std_logic_vector(" + sdfName + "_ram_width - 1 downto 0) \n" + "    ); end component; \n\n"

        archComponents += archComponent

    elif entityName == "prod" and prodCount <= 1: #PLACEHOLDER
        archComponent +=  "            --Input1 \n" + "            " + str(entityName) + "_in1_ready : in std_logic; \n" + "\n" + "            " + str(entityName) + "_in1_valid : in std_logic; \n" + "\n" + "            " + str(entityName) + "_in1_opening : in std_logic_vector(" + sdfName + "_ram_width - 1 downto 0); \n" + "\n\n" + "            --Input2 \n" + "            " + str(entityName) + "_in2_ready : in std_logic; \n" + "\n" + "            " + str(entityName) + "_in2_valid : in std_logic; \n" + "\n" + "            " + str(entityName) + "_in2_opening : in std_logic_vector(" + sdfName + "_ram_width - 1 downto 0); \n" + "\n\n" + "            --Output \n" + "            " + str(entityName) + "_out_ready : out std_logic; \n" + "\n" + "            " + str(entityName) + "_out_valid : out std_logic; \n" + "\n" + "            " + str(entityName) + "_out_opening : out std_logic_vector(" + sdfName + "_ram_width - 1 downto 0) \n" + "    ); end component; \n\n"

        archComponents += archComponent

    elif entityName == "div" and divCount <= 1: #PLACEHOLDER
        archComponent +=  "            --Input1 \n" + "            " + str(entityName) + "_in1_ready : in std_logic; \n" + "\n" + "            " + str(entityName) + "_in1_valid : in std_logic; \n" + "\n" + "            " + str(entityName) + "_in1_opening : in std_logic_vector(" + sdfName + "_ram_width - 1 downto 0); \n" + "\n\n" + "            --Input2 \n" + "            " + str(entityName) + "_in2_ready : in std_logic; \n" + "\n" + "            " + str(entityName) + "_in2_valid : in std_logic; \n" + "\n" + "            " + str(entityName) + "_in2_opening : in std_logic_vector(" + sdfName + "_ram_width - 1 downto 0); \n" + "\n\n" + "            --Output \n" + "            " + str(entityName) + "_out_ready : out std_logic; \n" + "\n" + "            " + str(entityName) + "_out_valid : out std_logic; \n" + "\n" + "            " + str(entityName) + "_out_opening : out std_logic_vector(" + sdfName + "_ram_width - 1 downto 0) \n" + "    ); end component; \n\n"

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
    signalFullNameToBuffer = signalName + "oooFROMooo" + signalSrcName + "oooTO_BUFFERoooDATA"

    # Full signal declaration from buffer
    signalFullNameFromBuffer = signalName + "oooFROM_BUFFER_TOooo" + signalDstName + "oooDATA"

    # Make pair for buffer handling
    bothDataSigs = []
    bothDataSigs.append(signalFullNameToBuffer)
    bothDataSigs.append(signalFullNameFromBuffer)

    # Add pair to signals list
    node_signals_data.extend(bothDataSigs)
    
    
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
    signalFullNameToBufferReady = signalName + "oooFROMooo" + signalSrcName + "oooTO_BUFFERoooREADY"
    bothReadySigs.append(signalFullNameToBufferReady)

    # Full ready signal declaration from buffers
    signalFullNameFromBufferReady = signalName + "oooFROM_BUFFER_TOooo" + signalDstName + "oooREADY"
    bothReadySigs.append(signalFullNameFromBufferReady)

    node_signals_ready.extend(bothReadySigs)
    
    # Full valid signal declaration to buffers
    signalFullNameToBufferValid = signalName + "oooFROMooo" + signalSrcName + "oooTO_BUFFERoooVALID"
    bothValidSigs.append(signalFullNameToBufferValid)

    # Full valid signal declaration from buffers
    signalFullNameFromBufferValid = signalName + "oooFROM_BUFFER_TOooo" + signalDstName + "oooVALID"
    bothValidSigs.append(signalFullNameFromBufferValid)

    node_signals_valid.extend(bothValidSigs)

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

    # Input node
    if actName == "INPUT":
        component_mapping += actName + "_" + str(inputs) + " : " + str(actName) + "_node"

        actID = str(actorsList[act][2])
        toBuffReady = ""
        toBuffValid = ""
        toBuffData = ""

        # Port Map
        component_mapping += " PORT MAP ("

        # Clock + reset
        component_mapping += "         " + str(actName) + "_clk => " + str(sdfName) + "_clk, \n" + "                                        " + str(actName) + "_rst => " + str(sdfName) + "_rst, \n"

        # Figure out buffer subsequent exterior signals
        for sig in range(len(nodeSignals)):
            if nodeSignals[sig][1][0] == actID:
                sigFromBufName = nodeSignals[sig][2][0].split("_")[1] + "_" + nodeSignals[sig][2][0].split("_")[2]

        for readySig in range(len(node_signals_ready)):
            if str(node_signals_ready[readySig][0]).split("_")[0] + "_" + str(node_signals_ready[readySig]).split("_")[1]  == sigFromBufName:
                toBuffReady = node_signals_ready[readySig][0]
        for validSig in range(len(node_signals_valid)):
            if str(node_signals_valid[validSig][0]).split("_")[0] + "_" + str(node_signals_valid[validSig]).split("_")[1]  == sigFromBufName:
                toBuffValid = node_signals_valid[validSig][0]
        for dataSig in range(len(node_signals_data)):
            if str(node_signals_data[dataSig][0]).split("_")[0] + "_" + str(node_signals_data[dataSig]).split("_")[1]  == sigFromBufName:
                toBuffData = node_signals_data[dataSig][0]

        # Connect to correct input
        inptList = []
        for inpt in range(0,inputCtr):
            inptList.append(inpt)

        # AXI ready
        component_mapping +=  "                                        " + str(actName) + "_in" + str(inptList[act])  + "_ready => " + str(sdfName) + "_in" + str(inptList[act]) + "_ready, \n" +  "                                        " + str(actName) + "_out_ready => " + str(toBuffReady) + ", \n\n"
    
        # AXI valid
        component_mapping += "                                        " + str(actName) + "_in" + str(inptList[act]) + "_valid => " + str(sdfName) + "_in" + str(inptList[act]) + "_valid, \n" + "                                        " + str(actName) + "_out_valid => " + str(toBuffValid) + ", \n\n"
        
        # AXI data
        component_mapping += "                                        " + str(actName) + "_in" + str(inptList[act]) + "_opening => " + str(sdfName) + "_in" + str(inptList[act]) + "_data, \n"

        component_mapping += "                                        " + str(actName) + "_out_opening => " + str(toBuffData) + " \n" 

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
        component_mapping += "           " + str(actName) + "_clk => " + str(sdfName) + "_clk, \n" + "                                            " + str(actName) + "_rst => " + str(sdfName) + "_rst, \n"

        # Figure out predecessor
        actID = "OUTPUT_0"
        fromBuffReady = []
        fromBuffValid = []
        fromBuffData = []

        for readysig in range(len(node_signals_ready)):
            if node_signals_ready[readysig][1].split("ooo")[-2] == actID and node_signals_ready[readysig][1].split("ooo")[-3] == "FROM_BUFFER_TO":
                fromBuffReady.append(node_signals_ready[readysig][1])

        for validsig in range(len(node_signals_valid)):
            if node_signals_valid[validsig][1].split("ooo")[-2] == actID and node_signals_valid[validsig][1].split("ooo")[-3] == "FROM_BUFFER_TO":
                fromBuffValid.append(node_signals_valid[validsig][1])

        for datasig in range(len(node_signals_data)):
            if node_signals_data[datasig][1].split("ooo")[-2] == actID and node_signals_data[datasig][1].split("ooo")[-3] == "FROM_BUFFER_TO":
                fromBuffData.append(node_signals_data[datasig][1])
        
        # AXI ready
        component_mapping +=  "                                            " + str(actName) + "_in_ready => " + str(fromBuffReady[0]) + ", \n" +  "                                            " + str(actName) + "_out_ready => " + str(sdfName) + "_out_ready, \n\n"
    
        # AXI valid
        component_mapping += "                                            " + str(actName) + "_in_valid => " + str(fromBuffValid[0]) + ", \n" + "                                            " + str(actName) + "_out_valid => " + str(sdfName) + "_out_valid, \n\n"
        
        # AXI data
        component_mapping += "                                            " + str(actName) + "_in_opening => " + str(fromBuffReady[0]) + ", \n"

        component_mapping += "                                            " + str(actName) + "_out_opening => " + str(sdfName) + "_out_data \n" 

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
        component_mapping += "         " + str(sdfName) + "_clk => " + str(actName) + "_clk, \n" + "                                    " + str(sdfName) + "_rst => " + str(actName) + "_rst, \n"

        # Figure out predecessor and subsequent exterior signals
        actID = "0x7fbf3be01d10" #str(actorsList[act][2])
        
        toBuffReady = []
        toBuffValid = []
        toBuffData = []

        fromBuffReady = []
        fromBuffValid = []
        fromBuffData = []

        for readysig in range(len(node_signals_ready)):
            if node_signals_ready[readysig][1].split("ooo")[-2] == actID and node_signals_ready[readysig][1].split("ooo")[-3] == "FROM_BUFFER_TO":
                fromBuffReady.append(node_signals_ready[readysig][1])
            elif node_signals_ready[readysig][0].split("ooo")[-3] == actID and node_signals_ready[readysig][0].split("ooo")[-2] == "TO_BUFFER":
                toBuffReady.append(node_signals_ready[readySig][0])

        for validsig in range(len(node_signals_valid)):
            if node_signals_valid[validsig][1].split("ooo")[-2] == actID and node_signals_valid[validsig][1].split("ooo")[-3] == "FROM_BUFFER_TO":
                fromBuffValid.append(node_signals_valid[validsig][1])
            elif node_signals_valid[validsig][0].split("ooo")[-3] == actID and node_signals_valid[validsig][0].split("ooo")[-2] == "TO_BUFFER":
                toBuffValid.append(node_signals_valid[validsig][0])

        for datasig in range(len(node_signals_data)):
            if node_signals_data[datasig][1].split("ooo")[-2] == actID and node_signals_data[datasig][1].split("ooo")[-3] == "FROM_BUFFER_TO":
                fromBuffData.append(node_signals_data[datasig][1])
            elif node_signals_data[datasig][0].split("ooo")[-3] == actID and node_signals_data[datasig][0].split("ooo")[-2] == "TO_BUFFER":
                toBuffData.append(node_signals_data[datasig][0])

        print(str(toBuffReady) + "\n\n\n and now froms: \n\n" + str(fromBuffReady))

        # Input(s)
        for sig in range(len(fromBuffReady)):
            component_mapping +=  "                                    " + str(actName) + "_in" + str(sig) + "_ready => " + str(fromBuffReady[sig]) + ", \n" + "                                    " + str(actName) + "_in" + str(sig) + "_valid => " + fromBuffValid[sig] + ", \n" + "                                    " + str(actName) + "_in" + str(sig) + "_opening => " + fromBuffData[sig] + ", \n\n"

        # Output(s)
        for sig in range(len(toBuffReady)):
            component_mapping += "                                    " + str(actName) + "_out" + str(sig) + "_ready => " + toBuffReady[sig] + ", \n" + "                                    " + str(actName) + "_out" + str(sig) + "_valid => " + toBuffValid[sig] + ", \n" + "                                    " + str(actName) + "_out" + str(sig) + "_opening => " + toBuffData[sig] + " \n" 
        

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
                sigFromBufName = nodeSignals[sig][2][0].split("_")[1] + "_" + nodeSignals[sig][2][0].split("_")[2]

        for readySig in range(len(node_signals_ready)):
            if str(node_signals_ready[readySig][0]).split("_")[0] + "_" + str(node_signals_ready[readySig]).split("_")[1]  == sigFromBufName:
                fromBuffReady.append(node_signals_ready[readySig][1])
        for validSig in range(len(node_signals_valid)):
            if str(node_signals_valid[validSig][0]).split("_")[0] + "_" + str(node_signals_valid[validSig]).split("_")[1]  == sigFromBufName:
                fromBuffValid.append(node_signals_valid[validSig][1])
        for dataSig in range(len(node_signals_data)):
            if str(node_signals_data[dataSig][0]).split("_")[0] + "_" + str(node_signals_data[dataSig]).split("_")[1]  == sigFromBufName:
                fromBuffData.append(node_signals_data[dataSig][1])

        
        # AXI ready
        buffer_mapping +=  "                                    buf_in_ready => " + toBuffReady[0] + ", \n" +  "                                    buf_out_ready => " + str(fromBuffReady) + ", \n\n"
    
        # AXI valid
        buffer_mapping +=  "                                    buf_in_valid => " + toBuffValid[0] + ", \n" +  "                                    buf_out_valid => " + str(fromBuffValid) + ", \n\n"
        
        # AXI data
        buffer_mapping +=  "                                    buf_in_data => " + toBuffData[0] + ", \n" +  "                                    buf_out_data => " + str(fromBuffData) + " \n"

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
        component_mapping += "         " + str(sdfName) + "_clk => " + str(actName) + "_clk, \n" + "                                    " + str(sdfName) + "_rst => " + str(actName) + "_rst, \n"

        # Figure out predecessor and subsequent exterior signals
        actID = str(actorsList[act][2])
        
        toBuffReady = []
        toBuffValid = []
        toBuffData = []

        fromBuffReady = []
        fromBuffValid = []
        fromBuffData = []

        for readysig in range(len(node_signals_ready)):
            if node_signals_ready[readysig][1].split("ooo")[-2] == actID and node_signals_ready[readysig][1].split("ooo")[-3] == "FROM_BUFFER_TO":
                fromBuffReady.append(node_signals_ready[readysig][1])
            elif node_signals_ready[readysig][0].split("ooo")[-3] == actID and node_signals_ready[readysig][0].split("ooo")[-2] == "TO_BUFFER":
                toBuffReady.append(node_signals_ready[readysig][0])

        for validsig in range(len(node_signals_valid)):
            if node_signals_valid[validsig][1].split("ooo")[-2] == actID and node_signals_valid[validsig][1].split("ooo")[-3] == "FROM_BUFFER_TO":
                fromBuffValid.append(node_signals_valid[validsig][1])
            elif node_signals_valid[validsig][0].split("ooo")[-3] == actID and node_signals_valid[validsig][0].split("ooo")[-2] == "TO_BUFFER":
                toBuffValid.append(node_signals_valid[validsig][0])

        for datasig in range(len(node_signals_data)):
            if node_signals_data[datasig][1].split("ooo")[-2] == actID and node_signals_data[datasig][1].split("ooo")[-3] == "FROM_BUFFER_TO":
                fromBuffData.append(node_signals_data[datasig][1])
            elif node_signals_data[datasig][0].split("ooo")[-3] == actID and node_signals_data[datasig][0].split("ooo")[-2] == "TO_BUFFER":
                toBuffData.append(node_signals_data[datasig][0])
        
        # Input(s)
        for sig in range(len(fromBuffReady)):
            component_mapping +=  "                                    " + str(actName) + "_in" + str(sig) + "_ready => " + fromBuffReady[sig] + ", \n" + "                                    " + str(actName) + "_in" + str(sig) + "_valid => " + fromBuffValid[sig] + ", \n" + "                                    " + str(actName) + "_in" + str(sig) + "_opening => " + fromBuffData[sig] + ", \n\n"

        # Output(s)
        for sig in range(len(toBuffReady)):
            component_mapping += "                                    " + str(actName) + "_out" + str(sig) + "_ready => " + toBuffReady[sig] + ", \n" + "                                    " + str(actName) + "_out" + str(sig) + "_valid => " + toBuffValid[sig] + ", \n" + "                                    " + str(actName) + "_out" + str(sig) + "_opening => " + toBuffData[sig] + " \n" 
        

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
                fromBuffReady = node_signals_ready[readySig][1]
        for validSig in range(len(node_signals_valid)):
            if str(node_signals_valid[validSig][0]).split("_")[0] + str(node_signals_valid[validSig]).split("_")[1]  == sigFromBufName:
                fromBuffValid = node_signals_valid[validSig][1]
        for dataSig in range(len(node_signals_data)):
            if str(node_signals_data[dataSig][0]).split("_")[0] + str(node_signals_data[dataSig]).split("_")[1]  == sigFromBufName:
                fromBuffData = node_signals_data[dataSig][1]

        
        # AXI ready
        buffer_mapping +=  "                                    buf_in_ready => " + toBuffReady[0] + ", \n" +  "                                    buf_out_ready => " + str(fromBuffReady) + ", \n\n"
    
        # AXI valid
        buffer_mapping +=  "                                    buf_in_valid => " + toBuffValid[0] + ", \n" +  "                                    buf_out_valid => " + str(fromBuffValid) + ", \n\n"
        
        # AXI data
        buffer_mapping +=  "                                    buf_in_data => " + toBuffData[0] + ", \n" +  "                                    buf_out_data => " + str(fromBuffData) + " \n"

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
        component_mapping += "         " + str(sdfName) + "_clk => " + str(actName) + "_clk, \n" + "                                    " + str(sdfName) + "_rst => " + str(actName) + "_rst, \n"

        # Figure out predecessor and subsequent exterior signals
        actID = str(actorsList[act][2])
        
        toBuffReady = []
        toBuffValid = []
        toBuffData = []

        fromBuffReady = []
        fromBuffValid = []
        fromBuffData = []

        for readysig in range(len(node_signals_ready)):
            if node_signals_ready[readysig][1].split("ooo")[-2] == actID and node_signals_ready[readysig][1].split("ooo")[-3] == "FROM_BUFFER_TO":
                fromBuffReady.append(node_signals_ready[readysig][1])
            elif node_signals_ready[readysig][0].split("ooo")[-3] == actID and node_signals_ready[readysig][0].split("ooo")[-2] == "TO_BUFFER":
                toBuffReady.append(node_signals_ready[readysig][0])

        for validsig in range(len(node_signals_valid)):
            if node_signals_valid[validsig][1].split("ooo")[-2] == actID and node_signals_valid[validsig][1].split("ooo")[-3] == "FROM_BUFFER_TO":
                fromBuffValid.append(node_signals_valid[validsig][1])
            elif node_signals_valid[validsig][0].split("ooo")[-3] == actID and node_signals_valid[validsig][0].split("ooo")[-2] == "TO_BUFFER":
                toBuffValid.append(node_signals_valid[validsig][0])

        for datasig in range(len(node_signals_data)):
            if node_signals_data[datasig][1].split("ooo")[-2] == actID and node_signals_data[datasig][1].split("ooo")[-3] == "FROM_BUFFER_TO":
                fromBuffData.append(node_signals_data[datasig][1])
            elif node_signals_data[datasig][0].split("ooo")[-3] == actID and node_signals_data[datasig][0].split("ooo")[-2] == "TO_BUFFER":
                toBuffData.append(node_signals_data[datasig][0])
        
        # Input(s)
        for sig in range(len(fromBuffReady)):
            component_mapping +=  "                                    " + str(actName) + "_in" + str(sig) + "_ready => " + fromBuffReady[sig] + ", \n" + "                                    " + str(actName) + "_in" + str(sig) + "_valid => " + fromBuffValid[sig] + ", \n" + "                                    " + str(actName) + "_in" + str(sig) + "_opening => " + fromBuffData[sig] + ", \n\n"

        # Output(s)
        for sig in range(len(toBuffReady)):
            component_mapping += "                                    " + str(actName) + "_out" + str(sig) + "_ready => " + toBuffReady[sig] + ", \n" + "                                    " + str(actName) + "_out" + str(sig) + "_valid => " + toBuffValid[sig] + ", \n" + "                                    " + str(actName) + "_out" + str(sig) + "_opening => " + toBuffData[sig] + " \n" 
        

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
                fromBuffReady = node_signals_ready[readySig][1]
        for validSig in range(len(node_signals_valid)):
            if str(node_signals_valid[validSig][0]).split("_")[0] + str(node_signals_valid[validSig]).split("_")[1]  == sigFromBufName:
                fromBuffValid = node_signals_valid[validSig][1]
        for dataSig in range(len(node_signals_data)):
            if str(node_signals_data[dataSig][0]).split("_")[0] + str(node_signals_data[dataSig]).split("_")[1]  == sigFromBufName:
                fromBuffData = node_signals_data[dataSig][1]

        
        # AXI ready
        buffer_mapping +=  "                                    buf_in_ready => " + toBuffReady[0] + ", \n" +  "                                    buf_out_ready => " + str(fromBuffReady) + ", \n\n"
    
        # AXI valid
        buffer_mapping +=  "                                    buf_in_valid => " + toBuffValid[0] + ", \n" +  "                                    buf_out_valid => " + str(fromBuffValid) + ", \n\n"
        
        # AXI data
        buffer_mapping +=  "                                    buf_in_data => " + toBuffData[0] + ", \n" +  "                                    buf_out_data => " + str(fromBuffData) + " \n"

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