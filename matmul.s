////////////////////////////////////////////////////////////////////////////////
// You're implementing the following function in ARM Assembly
//! C = A * B
//! @param C          result matrix
//! @param A          matrix A
//! @param B          matrix B
//! @param hA         height of matrix A
//! @param wA         width of matrix A, height of matrix B
//! @param wB         width of matrix B
//
//  Note that while A, B, and C represent two-dimensional matrices,
//  they have all been allocated linearly. This means that the elements
//  in each row are sequential in memory, and that the first element
//  of the second row immedialely follows the last element in the first
//  row, etc.
//
//void matmul(int* C, const int* A, const int* B, unsigned int hA,
//    unsigned int wA, unsigned int wB)
//{
//  for (unsigned int i = 0; i < hA; ++i)
//    for (unsigned int j = 0; j < wB; ++j) {
//      int sum = 0;
//      for (unsigned int k = 0; k < wA; ++k) {
//        sum += A[i * wA + k] * B[k * wB + j];
//      }
//      C[i * wB + j] = sum;
//    }
//}
////////////////////////////////////////////////////////////////////////////////

	.arch armv8-a
	.global matmul
matmul:
    stp x19, x20, [sp, -16]
    stp x21, x22, [sp, -32]
    stp x23, x24, [sp, -48]
    stp x25, x26, [sp, -64]
    stp x27, x28, [sp, -80]
    stp x29, x30, [sp, -96]! // FP, LR


/*
    planning variables
	 counter i, x19
	 counter j, x20
	 counter k, x21
	 stored input ha, x22
	 stored intput wa, x23
	 stored input wb, x24
	 sum, x25
	 interemediate total, x26
*/

    // save orig
    mov x19, x0
    mov x20, x1
    mov x21, x2
    mov x22, x3
    mov x23, x4
    mov x24, x5
    mov x25, x6
    mov x26, x7
ret
