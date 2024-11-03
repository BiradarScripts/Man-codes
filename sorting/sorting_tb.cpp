#include <iostream>
#include "sorting.h"

using namespace std;

int main(int argc,char **argv)
{
    DTYPE A[SIZE] = {3, 1, 4, 1, 5, 9, 2, 6, 5, 3};
    DTYPE2 sw_result[SIZE],hw_result[SIZE];
    int err_cnt = 0;

    // Generate the expected result

    DTYPE2 a[SIZE];
    for (int i = 0; i < SIZE; i++) {
        a[i] = A[i];
    }
    for (int i = 0; i < SIZE; i++) {
        for (int j = 0; j < SIZE; j++) {
            if (a[i] < a[j]) {
                DTYPE2 temp = a[i];
                a[i] = a[j];
                a[j] = temp;
            }
        }
    }

    for (int i = 0; i < SIZE; i++) {
        sw_result[i] = a[i];
    }

    // Run the AutoESL matrix multiply block

   #ifdef HW_COSIM
    sorting_network(A,hw_result);
    #endif

    // Print result matrix
    cout << "{" << endl;
    //cout << setw(6);
    for (int i = 0; i < SIZE; i++) {
        // cout << "{";
        #ifdef HW_COSIM
        cout << hw_result[i];
        // Check HW result against SW
        if (hw_result[i] != sw_result[i]) {
            err_cnt++;
            cout << "*";
        }
        #else
        cout << sw_result[i];
        #endif
        if (i == SIZE - 1)
            cout << " " << endl;
        else
            cout << ",";
    }

    cout << "}" << endl;

    return err_cnt;




}