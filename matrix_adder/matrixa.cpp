#include "matrixa.h"

void matrixa(matrix_a a[row_size][col_size], matrix_b b[row_size][col_size], matrix_c result[row_size][col_size])
{
    loop1:for (int i = 0; i < row_size; i++)
    {
        loop2:for (int j = 0; j < col_size; j++)
        {
        	result[i][j]=0;
            result[i][j] = a[i][j] + b[i][j];
        }
    }
}
