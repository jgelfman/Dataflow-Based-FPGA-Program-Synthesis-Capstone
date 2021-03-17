# This is a VHDL code generator that uses ElementTree XML to take in XML files describing dataflow graphs compiled using FAUST, and in-return produces the corresponding entities and connections in VHDL to be simulated in Xilinx Vivado.


# Set to true in case of unkown operators
Unkowns = False

import sys
import xml.etree.ElementTree as ET
inputfile = input("Enter the exact file name (e.g. copy1.dsp-sig.xml) or type \"cancel\" to cancel: \n")
if inputfile == "cancel":
    sys.exit()
    
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
clock_period = input("Enter the desired clock period time in ns (e.g. 10) or type \"cancel\" to cancel: \n")
if clock_period == "cancel":
    sys.exit()

# Ask user for ram width
ram_depth = input("Enter the desired ram depth (e.g. 16) or type \"cancel\" to cancel: \n")
if ram_depth == "cancel":
    sys.exit()

# Ask user for ram depth
ram_width = input("Enter the desired ram depth (e.g. 256) or type \"cancel\" to cancel: \n")
if ram_width == "cancel":
    sys.exit()

vhdl_generate_tb.returnTB(sdfName, sdfArch, outputName, actorsList, interiorConnections, nodeSignals, clock_period, ram_depth, ram_width)

print("\n" + "VHDL program generated successfully.\n" + "Find resources at " +  str(resourcesFolder) + "\n" + "To generate wavelength and schematic, open " + str(outputName) + "\n")
