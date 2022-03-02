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
    stp x29, x30, [sp, -128]!
    mov x29, sp
    stp x19, x20, [sp, 16]
    stp x21, x22, [sp, 32]
    stp x23, x24, [sp, 48]
    stp x25, x26, [sp, 64]
    stp x27, x28, [sp, 80]


/*
    planning variables
    x19: C, result matrix
    x20: A, matrix A
    x21: B, matrix B
    x22: hA, height of matrix A
    x23: wA, width of matrix A, height of matrix B
    x24: wB, width of matrix B
    x25: counter i
    x26: counter j
    x27: counter k
    x28: sum
*/

    // save orig
    mov x19, x0
    mov x20, x1
    mov x21, x2
    mov x22, x3
    mov x23, x4
    mov x24, x5
mov x25, #0
iloop:
    mov x26, #0//zero j

    jloop:
        mov x28, #0 //sum = 0
        mov x27, #0//zero k

	    kloop:
            //        sum += A[i * wA + k] * B[k * wB + j];
            mul x0, x25, x22 //i * wa
	    add x0, x0, x27
            //x0 now has the index
            lsl x0, x0 , #2 //index * = int offset in array
            ldr w9, [x20, x0]//saves A[index x0] into x9

            mul x0, x24, x27
	    add x0, x0, x26
            lsl x0, x0, #2//index shifted by int offset
            ldr w10, [x21, x0]//saves B[index x0] into x10

            mul x0, x9, x10 // A[etc] * B[etc]
	        add x28, x0, x28


        //end of kloop
        //k < Wa
        cmp x27, x23
        b.ge endkloop
	add x0, x27, #1
        mov x27, x0
        b kloop

        endkloop:
            // C[i * wB + j] = sum;
                // i * wB
            mul x0, x25, x24
            // + j
	    add x0, x0, x26
            lsl x0, x0, #2 // index * 4 for array offset for ints

            str w28, [x19, x0]

    //end of jloop
    //j < Wa
    cmp x26, x24
    b.ge endjloop
    //j++
    add x0, x26, #1
    mov x26, x0
    b jloop
    endjloop:
         //end of iloop
	 //i < Ha
	 cmp x25, x22
         b.ge ending

//i++
add x0, x25, #1
mov x25, x0
b iloop

ending:
    ldp x19, x20, [sp, 16]
    ldp x21, x22, [sp, 32]
    ldp x23, x24, [sp, 48]
    ldp x25, x26, [sp, 64]
    ldp x27, x28, [sp, 80]
    ldp x29, x30, [sp], 128 // ld FP, LR

ret

