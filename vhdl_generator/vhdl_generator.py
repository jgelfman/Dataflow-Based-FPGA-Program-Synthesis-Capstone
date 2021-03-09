# This is a VHDL code generator that uses ElementTree XML to take in XML files describing dataflow graphs compiled using FAUST, and in-return produces the corresponding entities and connections in VHDL to be simulated in Xilinx Vivado.

import xml.etree.ElementTree as ET
inputfile = input("Enter the exact file name (e.g. copy1.dsp-sig.xml):")
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



# Create an output directory
import os
os.makedirs("output", exist_ok=True)

# Create identity entitiy node VHDL file
import vhdl_generator_node
vhdl_generator_node.returnNode(sdfArch)

# Create buffer VHDL file
import vhdl_generator_buffer
vhdl_generator_buffer.returnBuffer(sdfArch)

# Create entity connections based on above
import vhdl_generator_entity
vhdl_generator_entity.returnEntity(sdfArch, actorsList, interiorConnections, nodeSignals)



# TODO: create testbench


# TODO: finalize creating wrapper file connecting entities

data = "test"

output = open("output.txt", "w")
output.write(str(data))
output.close()


#Testing:

# Arch signals
arch_signals_component = ""

# Index of signals for mappings
node_signals_data = []
node_signals_ready = []
node_signals_valid = []

# Arch data signals
arch_signals_component += "signal "
for signal in range(len(nodeSignals)):
    # Signal name
    signalName = str(nodeSignals[signal][0])

    # Signal src
    signalSrcName = str(nodeSignals[signal][1][0])

    # Signal dst
    signalDstName = str(nodeSignals[signal][2][0])

    # Full signal declaration to buffer
    signalFullNameToBuffer = signalName + "_from_" + signalSrcName + "_to_buffer"
    node_signals_data.append(signalFullNameToBuffer)

    # Full signal declaration from buffer
    signalFullNameFromBuffer = signalName + "_from_buffer_to_" + signalDstName + "_data"
    node_signals_data.append(signalFullNameFromBuffer)
    
    
    # Add to signals component handling commas
    arch_signals_component += signalFullNameToBuffer + ", " + signalFullNameFromBuffer + ", "
arch_signals_component = arch_signals_component[:-2]

# Add remainder
arch_signals_component += " : std_logic_vector(copy1_ram_width - 1 downto 0); \n"

# Arch ready + valid signals
arch_signals_component += "signal "
for signal in range(len(nodeSignals)):
    # Signal name
    signalName = str(nodeSignals[signal][0])

    # Signal src
    signalSrcName = str(nodeSignals[signal][1][0])

    # Signal dst
    signalDstName = str(nodeSignals[signal][2][0])

    # Full ready signal declaration to buffers
    signalFullNameToBufferReady = signalName + "_from_" + signalSrcName + "_to_buffer_ready"
    node_signals_ready.append(signalFullNameToBufferReady)

    # Full ready signal declaration from buffers
    signalFullNameFromBufferReady = signalName + "_from_buffer_to_" + signalDstName + "_ready"
    node_signals_ready.append(signalFullNameFromBufferReady)
    
    # Full valid signal declaration to buffers
    signalFullNameToBufferValid = signalName + "_from_" + signalSrcName + "_to_buffer_valid"
    node_signals_valid.append(signalFullNameToBufferValid)

    # Full valid signal declaration from buffers
    signalFullNameFromBufferValid = signalName + "_from_buffer_to_" + signalDstName + "_valid"
    node_signals_valid.append(signalFullNameFromBufferValid)

    # Add to signals component handling commas
    arch_signals_component += signalFullNameToBufferReady + ", " + signalFullNameFromBufferReady + ", " + signalFullNameToBufferValid + ", " + signalFullNameFromBufferValid + ", "

# Remove last separator
arch_signals_component = arch_signals_component[:-2]

# Add signals remainder
arch_signals_component += " : std_logic; \n\n"
print(arch_signals_component)

node_signals_ready