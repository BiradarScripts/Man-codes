#include "matrixa.h"
#include<iostream>

int main()
{
    matrix_a a[row_size][col_size] = {{1, 2, 3}, {4, 5, 6}, {7, 8, 9}};
    matrix_b b[row_size][col_size] = {{9, 8, 7}, {6, 5, 4}, {3, 2, 1}};

    matrix_c sw_result[row_size][col_size], hw_result[row_size][col_size];
    int err_cnt = 0;

    for (int i = 0; i < row_size; i++)
    {
        for (int j = 0; j < col_size; j++)
        {
            sw_result[i][j] = 0;
            sw_result[i][j] = a[i][j] + b[i][j];
        }
    }

#ifdef HW_COSIM

    matrixa(a, b, hw_result);

#endif

    std::cout << "{" << std::endl;
    for (int i = 0; i < row_size; i++)
    {
        std::cout << "{";
        for (int j = 0; j < col_size; j++)
        {

#ifdef HW_COSIM
            std::cout << hw_result[i][j];
            if (hw_result[i][j] != sw_result[i][j])
            {
                err_cnt++;
                std::cout << "*";
            }

#else


            std::cout << sw_result[i][j];

#endif
    
                if (j == col_size - 1)
                    std::cout << "}" << std::endl;
                else
                    std::cout << ",";
            }
        }
        std::cout << "}" << std::endl;

#ifdef HW_COSIM
        if (err_cnt == 0)
        {
            std::cout << "Test passed!" << std::endl;
        }
        else
        {
            std::cout << "Test failed!" << std::endl;
        }
#endif
    
            return err_cnt;

}