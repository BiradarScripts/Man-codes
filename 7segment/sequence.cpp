#include "sequence.h"

void sequence(digit_t digits[NUM_DIGITS], segment_t segments[NUM_SEGMENTS], finalcount_t &finalcount)
{
    finalcount = 0;
    digits: for (int i = 0; i <= NUM_DIGITS - NUM_SEGMENTS; i++) {
        bool is_match = true;

        innerloop: for (int j = 0; j < NUM_SEGMENTS; j++) {
            if (digits[i + j] != segments[j]) {
                is_match = false;
                break;
            }
        }

        if (is_match) {
            finalcount++;
        }
    }
}
