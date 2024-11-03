#ifndef __SEQUENCE_H__
#define __SEQUENCE_H__

#define NUM_DIGITS 8
#define NUM_SEGMENTS 4

typedef char digit_t;
typedef int finalcount_t;  // Changed to int
typedef char segment_t;

void sequence(digit_t digits[NUM_DIGITS], segment_t segments[NUM_SEGMENTS], finalcount_t &finalcount);
#endif
