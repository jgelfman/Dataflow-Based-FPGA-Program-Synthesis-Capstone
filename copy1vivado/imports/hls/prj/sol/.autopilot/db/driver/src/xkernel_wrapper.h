// ==============================================================
// Vivado(TM) HLS - High-Level Synthesis from C, C++ and SystemC v2019.2 (64-bit)
// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// ==============================================================
#ifndef XKERNEL_WRAPPER_H
#define XKERNEL_WRAPPER_H

#ifdef __cplusplus
extern "C" {
#endif

/***************************** Include Files *********************************/
#ifndef __linux__
#include "xil_types.h"
#include "xil_assert.h"
#include "xstatus.h"
#include "xil_io.h"
#else
#include <stdint.h>
#include <assert.h>
#include <dirent.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/mman.h>
#include <unistd.h>
#include <stddef.h>
#endif
#include "xkernel_wrapper_hw.h"

/**************************** Type Definitions ******************************/
#ifdef __linux__
typedef uint8_t u8;
typedef uint16_t u16;
typedef uint32_t u32;
#else
typedef struct {
    u16 DeviceId;
    u32 Control_BaseAddress;
} XKernel_wrapper_Config;
#endif

typedef struct {
    u32 Control_BaseAddress;
    u32 IsReady;
} XKernel_wrapper;

/***************** Macros (Inline Functions) Definitions *********************/
#ifndef __linux__
#define XKernel_wrapper_WriteReg(BaseAddress, RegOffset, Data) \
    Xil_Out32((BaseAddress) + (RegOffset), (u32)(Data))
#define XKernel_wrapper_ReadReg(BaseAddress, RegOffset) \
    Xil_In32((BaseAddress) + (RegOffset))
#else
#define XKernel_wrapper_WriteReg(BaseAddress, RegOffset, Data) \
    *(volatile u32*)((BaseAddress) + (RegOffset)) = (u32)(Data)
#define XKernel_wrapper_ReadReg(BaseAddress, RegOffset) \
    *(volatile u32*)((BaseAddress) + (RegOffset))

#define Xil_AssertVoid(expr)    assert(expr)
#define Xil_AssertNonvoid(expr) assert(expr)

#define XST_SUCCESS             0
#define XST_DEVICE_NOT_FOUND    2
#define XST_OPEN_DEVICE_FAILED  3
#define XIL_COMPONENT_IS_READY  1
#endif

/************************** Function Prototypes *****************************/
#ifndef __linux__
int XKernel_wrapper_Initialize(XKernel_wrapper *InstancePtr, u16 DeviceId);
XKernel_wrapper_Config* XKernel_wrapper_LookupConfig(u16 DeviceId);
int XKernel_wrapper_CfgInitialize(XKernel_wrapper *InstancePtr, XKernel_wrapper_Config *ConfigPtr);
#else
int XKernel_wrapper_Initialize(XKernel_wrapper *InstancePtr, const char* InstanceName);
int XKernel_wrapper_Release(XKernel_wrapper *InstancePtr);
#endif

void XKernel_wrapper_Start(XKernel_wrapper *InstancePtr);
u32 XKernel_wrapper_IsDone(XKernel_wrapper *InstancePtr);
u32 XKernel_wrapper_IsIdle(XKernel_wrapper *InstancePtr);
u32 XKernel_wrapper_IsReady(XKernel_wrapper *InstancePtr);
void XKernel_wrapper_EnableAutoRestart(XKernel_wrapper *InstancePtr);
void XKernel_wrapper_DisableAutoRestart(XKernel_wrapper *InstancePtr);

void XKernel_wrapper_Set_in_data(XKernel_wrapper *InstancePtr, u64 Data);
u64 XKernel_wrapper_Get_in_data(XKernel_wrapper *InstancePtr);
void XKernel_wrapper_Set_out_data(XKernel_wrapper *InstancePtr, u64 Data);
u64 XKernel_wrapper_Get_out_data(XKernel_wrapper *InstancePtr);

void XKernel_wrapper_InterruptGlobalEnable(XKernel_wrapper *InstancePtr);
void XKernel_wrapper_InterruptGlobalDisable(XKernel_wrapper *InstancePtr);
void XKernel_wrapper_InterruptEnable(XKernel_wrapper *InstancePtr, u32 Mask);
void XKernel_wrapper_InterruptDisable(XKernel_wrapper *InstancePtr, u32 Mask);
void XKernel_wrapper_InterruptClear(XKernel_wrapper *InstancePtr, u32 Mask);
u32 XKernel_wrapper_InterruptGetEnabled(XKernel_wrapper *InstancePtr);
u32 XKernel_wrapper_InterruptGetStatus(XKernel_wrapper *InstancePtr);

#ifdef __cplusplus
}
#endif

#endif
