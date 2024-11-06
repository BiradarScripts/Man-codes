#include "function_under_test.h"  // Replace with the actual header defining the function
#include <iostream>

int main() {
    // Initialize input data
    input_type input1[size1] = {/* Initialize with test values */};
    input_type input2[size2] = {/* Initialize with test values */};
    
    // Initialize output data
    output_type sw_result[output_size], hw_result[output_size];
    int err_cnt = 0;

    // Compute expected result using software (reference model)
    for (int i = 0; i < output_size; i++) {
        sw_result[i] = reference_function(input1, input2);  // Replace with desired operation
    }

#ifdef HW_COSIM
    // Run the function for hardware co-simulation
    function_under_test(input1, input2, hw_result);
#endif

    // Print and compare results
    std::cout << "{" << std::endl;
    for (int i = 0; i < output_size; i++) {
        std::cout << "{";

#ifdef HW_COSIM
        std::cout << hw_result[i];
        if (hw_result[i] != sw_result[i]) {
            err_cnt++;
            std::cout << "*";  // Mark errors
        }
#else
        std::cout << sw_result[i];  // Print software result when HW_COSIM is not defined
#endif

        if (i == output_size - 1)
            std::cout << "}" << std::endl;
        else
            std::cout << ", ";
    }
    std::cout << "}" << std::endl;

#ifdef HW_COSIM
    // Display test result summary
    if (err_cnt == 0) {
        std::cout << "Test passed!" << std::endl;
    } else {
        std::cout << "Test failed!" << std::endl;
    }
#endif

    return err_cnt;  // Return the error count as the exit code
}