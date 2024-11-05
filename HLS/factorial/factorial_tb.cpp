#include <iostream>
#include "factorial.h"

using namespace std;

int main()
{
    din_t n=5;
    dout_t hw_result, sw_result;
    int err_cnt = 0;
    // Generate the expected result
    sw_result = 1;
    for (int i = 1; i <= n; i++) {
        sw_result *= i;
    }

#ifdef HW_COSIM
    // Run the AutoESL matrix multiply block
    factorial(n, hw_result);
#endif

    // Print result matrix
    cout << "hw_result = " << hw_result << endl;
    cout << "sw_result = " << sw_result << endl;    

#ifdef HW_COSIM

    if (hw_result != sw_result) {
        err_cnt++;
        cout << "ERROR: " << err_cnt << " mismatches detected!" << endl;
    } else {
        cout << "Test passed." << endl;
    }

#endif

    return err_cnt;
    // Testbench
}
