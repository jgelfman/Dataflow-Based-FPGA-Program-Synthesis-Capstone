# This is a generated file. Use and modify at your own risk.
################################################################################

open_project prj
open_solution sol
set_part  xczu9eg-ffvb1156-2-e
add_files ../kernel_wrapper_cmodel.cpp
set_top kernel_wrapper
config_sdx -optimization_level none -target xocc
config_rtl -auto_prefix=0
csynth_design
exit

