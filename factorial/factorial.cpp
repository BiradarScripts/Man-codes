#include "factorial.h"

void factorial(din_t n, dout_t &result) {
    result = 1;
    for (int i = 1; i <= n; i++) {
        result *= i;
    }
}