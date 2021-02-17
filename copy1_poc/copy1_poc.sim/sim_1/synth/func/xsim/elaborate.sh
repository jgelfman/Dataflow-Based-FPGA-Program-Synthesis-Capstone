#!/bin/bash -f
# ****************************************************************************
# Vivado (TM) v2019.2.1 (64-bit)
#
# Filename    : elaborate.sh
# Simulator   : Xilinx Vivado Simulator
# Description : Script for elaborating the compiled design
#
# Generated by Vivado on Thu Feb 18 01:36:03 +08 2021
# SW Build 2729669 on Thu Dec  5 04:48:12 MST 2019
#
# Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
#
# usage: elaborate.sh
#
# ****************************************************************************
set -Eeuo pipefail
echo "xelab -wto 7cb67da4d93341db9fa3bd9068944096 --incr --debug typical --relax --mt 8 -L xil_defaultlib -L secureip --snapshot copy1_wrapper_func_synth xil_defaultlib.copy1_wrapper -log elaborate.log"
xelab -wto 7cb67da4d93341db9fa3bd9068944096 --incr --debug typical --relax --mt 8 -L xil_defaultlib -L secureip --snapshot copy1_wrapper_func_synth xil_defaultlib.copy1_wrapper -log elaborate.log

