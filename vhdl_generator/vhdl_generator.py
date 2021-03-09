# This is a VHDL code generator that uses ElementTree XML to take in XML files describing dataflow graphs compiled using FAUST, and in-return produces the corresponding entities and connections in VHDL to be simulated in Xilinx Vivado.

import xml.etree.ElementTree as ET
inputfile = input("Enter the exact file name (e.g. copy1.xml):")
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

signalsList = []
for i in range(len(signals)):
    signalName = signals[i][0][1]
    srcActor = signals[i][1][1]
    srcPort = signals[i][2][1]
    dstActor = signals[i][3][1]
    dstPort = signals[i][4][1]
    acts = (srcActor, dstActor)
    prts = (srcPort, dstPort)
    signal = [signalName, acts, prts]
    signalsList.append(signal)
#[signalName, (srcActor, dstActor), (srcPort, dstPort)]

# Create an output directory
import os
os.makedirs("output")

# Create identity entitiy node VHDL file
import vhdl_generator_node
vhdl_generator_node.returnNode(sdfArch)

# Create buffer VHDL file
import vhdl_generator_buffer
vhdl_generator_buffer.returnBuffer(sdfArch)

#create entity connections based on above
import vhdl_generator_entity
vhdl_generator_buffer.returnEntity(actorsList, signalsList)


#create wrapper file connecting entities


data = "test"

output = open("output.txt", "w")
output.write(str(data))
output.close()