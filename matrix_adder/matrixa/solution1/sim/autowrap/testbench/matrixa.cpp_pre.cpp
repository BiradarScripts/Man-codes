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
