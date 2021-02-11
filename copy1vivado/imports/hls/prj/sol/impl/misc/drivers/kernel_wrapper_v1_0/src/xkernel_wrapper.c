// ==============================================================
// Vivado(TM) HLS - High-Level Synthesis from C, C++ and SystemC v2019.2 (64-bit)
// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// ==============================================================
/***************************** Include Files *********************************/
#include "xkernel_wrapper.h"

/************************** Function Implementation *************************/
#ifndef __linux__
int XKernel_wrapper_CfgInitialize(XKernel_wrapper *InstancePtr, XKernel_wrapper_Config *ConfigPtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(ConfigPtr != NULL);

    InstancePtr->Control_BaseAddress = ConfigPtr->Control_BaseAddress;
    InstancePtr->IsReady = XIL_COMPONENT_IS_READY;

    return XST_SUCCESS;
}
#endif

void XKernel_wrapper_Start(XKernel_wrapper *InstancePtr) {
    u32 Data;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XKernel_wrapper_ReadReg(InstancePtr->Control_BaseAddress, XKERNEL_WRAPPER_CONTROL_ADDR_AP_CTRL) & 0x80;
    XKernel_wrapper_WriteReg(InstancePtr->Control_BaseAddress, XKERNEL_WRAPPER_CONTROL_ADDR_AP_CTRL, Data | 0x01);
}

u32 XKernel_wrapper_IsDone(XKernel_wrapper *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XKernel_wrapper_ReadReg(InstancePtr->Control_BaseAddress, XKERNEL_WRAPPER_CONTROL_ADDR_AP_CTRL);
    return (Data >> 1) & 0x1;
}

u32 XKernel_wrapper_IsIdle(XKernel_wrapper *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XKernel_wrapper_ReadReg(InstancePtr->Control_BaseAddress, XKERNEL_WRAPPER_CONTROL_ADDR_AP_CTRL);
    return (Data >> 2) & 0x1;
}

u32 XKernel_wrapper_IsReady(XKernel_wrapper *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XKernel_wrapper_ReadReg(InstancePtr->Control_BaseAddress, XKERNEL_WRAPPER_CONTROL_ADDR_AP_CTRL);
    // check ap_start to see if the pcore is ready for next input
    return !(Data & 0x1);
}

void XKernel_wrapper_EnableAutoRestart(XKernel_wrapper *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XKernel_wrapper_WriteReg(InstancePtr->Control_BaseAddress, XKERNEL_WRAPPER_CONTROL_ADDR_AP_CTRL, 0x80);
}

void XKernel_wrapper_DisableAutoRestart(XKernel_wrapper *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XKernel_wrapper_WriteReg(InstancePtr->Control_BaseAddress, XKERNEL_WRAPPER_CONTROL_ADDR_AP_CTRL, 0);
}

void XKernel_wrapper_Set_in_data(XKernel_wrapper *InstancePtr, u64 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XKernel_wrapper_WriteReg(InstancePtr->Control_BaseAddress, XKERNEL_WRAPPER_CONTROL_ADDR_IN_DATA_DATA, (u32)(Data));
    XKernel_wrapper_WriteReg(InstancePtr->Control_BaseAddress, XKERNEL_WRAPPER_CONTROL_ADDR_IN_DATA_DATA + 4, (u32)(Data >> 32));
}

u64 XKernel_wrapper_Get_in_data(XKernel_wrapper *InstancePtr) {
    u64 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XKernel_wrapper_ReadReg(InstancePtr->Control_BaseAddress, XKERNEL_WRAPPER_CONTROL_ADDR_IN_DATA_DATA);
    Data += (u64)XKernel_wrapper_ReadReg(InstancePtr->Control_BaseAddress, XKERNEL_WRAPPER_CONTROL_ADDR_IN_DATA_DATA + 4) << 32;
    return Data;
}

void XKernel_wrapper_Set_out_data(XKernel_wrapper *InstancePtr, u64 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XKernel_wrapper_WriteReg(InstancePtr->Control_BaseAddress, XKERNEL_WRAPPER_CONTROL_ADDR_OUT_DATA_DATA, (u32)(Data));
    XKernel_wrapper_WriteReg(InstancePtr->Control_BaseAddress, XKERNEL_WRAPPER_CONTROL_ADDR_OUT_DATA_DATA + 4, (u32)(Data >> 32));
}

u64 XKernel_wrapper_Get_out_data(XKernel_wrapper *InstancePtr) {
    u64 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XKernel_wrapper_ReadReg(InstancePtr->Control_BaseAddress, XKERNEL_WRAPPER_CONTROL_ADDR_OUT_DATA_DATA);
    Data += (u64)XKernel_wrapper_ReadReg(InstancePtr->Control_BaseAddress, XKERNEL_WRAPPER_CONTROL_ADDR_OUT_DATA_DATA + 4) << 32;
    return Data;
}

void XKernel_wrapper_InterruptGlobalEnable(XKernel_wrapper *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XKernel_wrapper_WriteReg(InstancePtr->Control_BaseAddress, XKERNEL_WRAPPER_CONTROL_ADDR_GIE, 1);
}

void XKernel_wrapper_InterruptGlobalDisable(XKernel_wrapper *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XKernel_wrapper_WriteReg(InstancePtr->Control_BaseAddress, XKERNEL_WRAPPER_CONTROL_ADDR_GIE, 0);
}

void XKernel_wrapper_InterruptEnable(XKernel_wrapper *InstancePtr, u32 Mask) {
    u32 Register;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Register =  XKernel_wrapper_ReadReg(InstancePtr->Control_BaseAddress, XKERNEL_WRAPPER_CONTROL_ADDR_IER);
    XKernel_wrapper_WriteReg(InstancePtr->Control_BaseAddress, XKERNEL_WRAPPER_CONTROL_ADDR_IER, Register | Mask);
}

void XKernel_wrapper_InterruptDisable(XKernel_wrapper *InstancePtr, u32 Mask) {
    u32 Register;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Register =  XKernel_wrapper_ReadReg(InstancePtr->Control_BaseAddress, XKERNEL_WRAPPER_CONTROL_ADDR_IER);
    XKernel_wrapper_WriteReg(InstancePtr->Control_BaseAddress, XKERNEL_WRAPPER_CONTROL_ADDR_IER, Register & (~Mask));
}

void XKernel_wrapper_InterruptClear(XKernel_wrapper *InstancePtr, u32 Mask) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XKernel_wrapper_WriteReg(InstancePtr->Control_BaseAddress, XKERNEL_WRAPPER_CONTROL_ADDR_ISR, Mask);
}

u32 XKernel_wrapper_InterruptGetEnabled(XKernel_wrapper *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XKernel_wrapper_ReadReg(InstancePtr->Control_BaseAddress, XKERNEL_WRAPPER_CONTROL_ADDR_IER);
}

u32 XKernel_wrapper_InterruptGetStatus(XKernel_wrapper *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XKernel_wrapper_ReadReg(InstancePtr->Control_BaseAddress, XKERNEL_WRAPPER_CONTROL_ADDR_ISR);
}

