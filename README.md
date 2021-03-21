# Dataflow Based FPGA Program Synthesis
A Yale-NUS BSc. (Hons) in Mathematical, Computational, and Statistical Sciences Capstone: **an FPGA Program Generator written in Python that takes `dsp-sig` XML Dataflow Graphs created using FAUST to produce FPGA programs in VHDL.**


## Example: `math`
For a `math.dsp-sig.dot` dataflow graph for which a `math.dsp-sig.xml` was created using the FAUST fork by [@jkmingwen](https://github.com/jkmingwen):
<img width="745" alt="Screenshot 2021-03-21 at 23 03 22" src="https://user-images.githubusercontent.com/47740280/111909805-abb00100-8a99-11eb-8c71-ba91bde5f5fe.png">

The following is an automatically generated FPGA program in VHDL, compiled using Vivado:
<img width="1526" alt="entirely_generated_math" src="https://user-images.githubusercontent.com/47740280/111909696-478d3d00-8a99-11eb-87a9-e0d1ae1b546c.png">
Zoomed in:
<img width="1499" alt="entirely_generated_math_1" src="https://user-images.githubusercontent.com/47740280/111909702-4c51f100-8a99-11eb-9e55-d32539fd7e80.png">


## How does this work?

Steps to reproduce:
1. Clone the rep.
2. `cd Dataflow-Based-FPGA-Program-Synthesis-Capstone/vhdl_generator`
3. Copy in a desired dataflow graph **in `.xml` format** from one of the provided examples into this folder:
`cp ../Dataflow_Graphs/sdf_xmls/copy1.dsp-sig.xml .`
4. Run `python vhdl_generator_main.py'
5. Specify the exact file name or cancel to exit, e.g.:
`copy1.dsp-sig.xml` or `cancel`
6. Specify the Wavemodel clock period in ns or cancel to exit, e.g.:
`10` or `cancel`
7. Specify the desired RAM depth or cancel to exit, e.g:
`16` or `cancel`
8. Specify the desired RAM width or cancel to exit, e.g:
`256` or `cancel`
9. The desired FPGA program in VHDL will be generated in the architecture output subdirectory, e.g. `copy1_output`
10. In Vivado, create a new project specifying the output subdirectory as a resource folder, as well as any desired constraints and the board type.
11. Finally, run the simulation to produce a wavelength or a schematic to your heart's desire!


## What's Inside?

### `vhdl_generator`
A folder containing the generator python files themselves:
- `vhdl_generator_main.py`: The main generator framework.
- `vhdl_generate_wrapper.py`: The dataflow wrapper.
- `vhdl_generate_tb.py`: The for Vivado simulation testbench flow and constraints.

The generator resource files:
- `vhdl_generate_buffer.py`: borrowed from the AXI FIFO buffer implementation by @jjzmajic
- `vhdl_generate_input_node.py`: a basic input node.
- `vhdl_generate_output_node.py`: a basic output node.
- `vhdl_generate_add_node.py`: a placeholder add operator node.
- `vhdl_generate_prod_node.py`: a placeholder prod operator node.
- `vhdl_generate_div_node.py`: a placeholder div operator node.
- `vhdl_generate_identity_node.py`: a placeholder unkown operator identity operator node.

Copied example output dataflow graphs in `.xml` format:
- copy1.dsp-sig.xml
- copy2.dsp-sig.xml
- math.dsp-sig.xml
- noise.dsp-sig.xml

Their automatically generated output subfolders with relevant resource files inside (**these can be ran in Vivado**):
- copy1_output
- copy2_output
- math_output
- noise_output

The Vivado projects of some of the automatically generated programs above (**these can be opened in Vivado for schematics or waveforms**):
- generated_copy1_vivado_project
- generated_copy2_vivado_project
- generated_math_vivado_project


### `Dataflow_Graphs`
A folder containing an array of dataflow graphs produced by [@jkmingwen](https://github.com/jkmingwen) using [his fork](https://github.com/jkmingwen/faust) of the [FAUST programming language](https://github.com/grame-cncm/faust). Every subfolder contains a dataflow signal process `.dsp` file, a `.dot` graph, an `.xml`, and a `.png` visualization:
- `copy1`: a basic 1 input to 1 output copy dataflow.
- `noisedsp`: a noise generator dataflow.
- `plus1`: a basic plus 1 adder dataflow.
- `split_sum`: a split sum dataflow.

As well as:
- `sd_xmls`: `.xml`s of a few dataflow examples.
- `sig_graph`: `.pdf` visualizations of the same dataflow examples.


### `axi_fifo_ring_buffer`
A clone folder of an AXI FIFO buffer written in VHDL as a Xilinx Vivado Project by [@jjzmajic](https://gitlab.com/jjzmajic) from his [repository](https://gitlab.com/jjzmajic/axi_fifo_ring_buffer):

The FPGA program generator was developed using the VHDL buffer implementation which can be found here:
`axi_fifo_ring_buffer/kernel_wrapper_ex.srcs/sources_1/imports/new/`

This can be ran as Xilinx Vivado Project.

*Note: Full documentation can be found in this subfolder's readme.*


### `copy1_poc`
A folder containing the manual implementation proof of concept written in VHDL on which the generator is based. 
This can be ran as Xilinx Vivado Project.

### Further work that can be done
- [] Implement more operators in VHDL for greater dataflow operator support (*these can be added into the main generator framework file*).
- [] Test and tweak the full potential of the buffer for large dataflows (*tweak the buffer using its own file or the testbench flow*).


### Acknowledgment
This repository was done as an independent capstone project supervised by Prof. Bodin at Yale-NUS College [@bbodin](https://github.com/bbodin).
