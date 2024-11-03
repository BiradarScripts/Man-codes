#include "sorting.h"

void sorting_network(DTYPE A[SIZE], DTYPE2 B[SIZE]) {
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
    B[i] = a[i];
  }
}