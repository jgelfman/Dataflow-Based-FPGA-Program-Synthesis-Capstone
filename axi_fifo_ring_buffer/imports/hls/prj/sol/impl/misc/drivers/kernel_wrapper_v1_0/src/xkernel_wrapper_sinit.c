// ==============================================================
// Vivado(TM) HLS - High-Level Synthesis from C, C++ and SystemC v2019.2 (64-bit)
// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// ==============================================================
#ifndef __linux__

#include "xstatus.h"
#include "xparameters.h"
#include "xkernel_wrapper.h"

extern XKernel_wrapper_Config XKernel_wrapper_ConfigTable[];

XKernel_wrapper_Config *XKernel_wrapper_LookupConfig(u16 DeviceId) {
	XKernel_wrapper_Config *ConfigPtr = NULL;

	int Index;

	for (Index = 0; Index < XPAR_XKERNEL_WRAPPER_NUM_INSTANCES; Index++) {
		if (XKernel_wrapper_ConfigTable[Index].DeviceId == DeviceId) {
			ConfigPtr = &XKernel_wrapper_ConfigTable[Index];
			break;
		}
	}

	return ConfigPtr;
}

int XKernel_wrapper_Initialize(XKernel_wrapper *InstancePtr, u16 DeviceId) {
	XKernel_wrapper_Config *ConfigPtr;

	Xil_AssertNonvoid(InstancePtr != NULL);

	ConfigPtr = XKernel_wrapper_LookupConfig(DeviceId);
	if (ConfigPtr == NULL) {
		InstancePtr->IsReady = 0;
		return (XST_DEVICE_NOT_FOUND);
	}

	return XKernel_wrapper_CfgInitialize(InstancePtr, ConfigPtr);
}

#endif

