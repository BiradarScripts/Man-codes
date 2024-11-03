#include <iostream>
#include "sequence.h"

using namespace std;

int main()
{
    digit_t digits[NUM_DIGITS] = {1, 0, 1, 1, 0, 1, 1, 0};
    segment_t segments[NUM_SEGMENTS] = {1, 0, 1, 1};
    finalcount_t hw_finalcount , sw_finalcount ;
    int err_cnt = 0;

    // Generate the expected result
    sequence(digits, segments, sw_finalcount);

#ifdef HW_COSIM
    // Run the hardware-simulated block
    sequence(digits, segments, hw_finalcount);
#endif

    // Print result
    cout << "Software Final Count: " << sw_finalcount << endl;
#ifdef HW_COSIM
    cout << "Hardware Final Count: " << hw_finalcount << endl;
    if (hw_finalcount != sw_finalcount) {
        err_cnt++;
        cout << "*";
    }
#endif

    return err_cnt;
}
