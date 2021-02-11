// ==============================================================
// Vivado(TM) HLS - High-Level Synthesis from C, C++ and SystemC v2019.2 (64-bit)
// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// ==============================================================
// control
// 0x00 : Control signals
//        bit 0  - ap_start (Read/Write/COH)
//        bit 1  - ap_done (Read/COR)
//        bit 2  - ap_idle (Read)
//        bit 3  - ap_ready (Read)
//        bit 7  - auto_restart (Read/Write)
//        others - reserved
// 0x04 : Global Interrupt Enable Register
//        bit 0  - Global Interrupt Enable (Read/Write)
//        others - reserved
// 0x08 : IP Interrupt Enable Register (Read/Write)
//        bit 0  - Channel 0 (ap_done)
//        bit 1  - Channel 1 (ap_ready)
//        others - reserved
// 0x0c : IP Interrupt Status Register (Read/TOW)
//        bit 0  - Channel 0 (ap_done)
//        bit 1  - Channel 1 (ap_ready)
//        others - reserved
// 0x10 : Data signal of in_data
//        bit 31~0 - in_data[31:0] (Read/Write)
// 0x14 : Data signal of in_data
//        bit 31~0 - in_data[63:32] (Read/Write)
// 0x18 : reserved
// 0x1c : Data signal of out_data
//        bit 31~0 - out_data[31:0] (Read/Write)
// 0x20 : Data signal of out_data
//        bit 31~0 - out_data[63:32] (Read/Write)
// 0x24 : reserved
// (SC = Self Clear, COR = Clear on Read, TOW = Toggle on Write, COH = Clear on Handshake)

#define XKERNEL_WRAPPER_CONTROL_ADDR_AP_CTRL       0x00
#define XKERNEL_WRAPPER_CONTROL_ADDR_GIE           0x04
#define XKERNEL_WRAPPER_CONTROL_ADDR_IER           0x08
#define XKERNEL_WRAPPER_CONTROL_ADDR_ISR           0x0c
#define XKERNEL_WRAPPER_CONTROL_ADDR_IN_DATA_DATA  0x10
#define XKERNEL_WRAPPER_CONTROL_BITS_IN_DATA_DATA  64
#define XKERNEL_WRAPPER_CONTROL_ADDR_OUT_DATA_DATA 0x1c
#define XKERNEL_WRAPPER_CONTROL_BITS_OUT_DATA_DATA 64

