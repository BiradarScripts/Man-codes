// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2022.2 (64-bit)
// Tool Version Limit: 2019.12
// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// ==============================================================
# 1 "D:/FPGA-24/matrix_adder/matrixa.cpp"
# 1 "<built-in>"
# 1 "<command-line>"
# 1 "D:/FPGA-24/matrix_adder/matrixa.cpp"
# 1 "D:/FPGA-24/matrix_adder/matrixa.h" 1







typedef char matrix_a;
typedef char matrix_b;
typedef int matrix_c;

void matrixa(matrix_a a[3][3], matrix_b b[3][3], matrix_c result[3][3]);
# 2 "D:/FPGA-24/matrix_adder/matrixa.cpp" 2

void matrixa(matrix_a a[3][3], matrix_b b[3][3], matrix_c result[3][3])
{
    for (int i = 0; i < 3; i++)
    {
        for (int j = 0; j < 3; j++)
        {
         result[i][j]=0;
            result[i][j] = a[i][j] + b[i][j];
        }
    }
}
#ifndef HLS_FASTSIM
#ifdef __cplusplus
extern "C"
#endif
void apatb_matrixa_ir(char (*)[3], char (*)[3], int (*)[3]);
#ifdef __cplusplus
extern "C"
#endif
void matrixa_hw_stub(char (*a)[3], char (*b)[3], int (*result)[3]){
matrixa(a, b, result);
return ;
}
#ifdef __cplusplus
extern "C"
#endif
void apatb_matrixa_sw(char (*a)[3], char (*b)[3], int (*result)[3]){
apatb_matrixa_ir(a, b, result);
return ;
}
#endif
# 13 "D:/FPGA-24/matrix_adder/matrixa.cpp"

