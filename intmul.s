    // intmul function in this file

    .arch armv8-a
    .global intmul

intmul:

    stp x29, x30, [sp, -48]!
    mov x29, sp
    stp x23, x24, [sp, 16] // registers not used by other ints
    stp x25, x26, [sp, 32] // 26 is negative flag for x1

    cmp x0, #0
    beq zero // check if 0

    cmp x1, #0
    beq zero // check if 0

    cmp x0, x1
    bgt swapskip // if greater don't use as incrementor

    // swap
    mov x23, x1
    mov x1, x0
    mov x0, x23 

    swapskip:
    
    mov x23, x0 // A, base value
    mov x24, x1 // B, iterations of loop

    cmp x1, #0
    blt neg // yum
    resume1:
    mov x25, #0 // set them equal for the adding
loop:
    // see if its even
    and x26, x24, #1
    cmp x26, #0
    beq bigdiv

    mov x0, x25
    mov x1, x23
    bl intadd // addition fnc
    mov x25, x0 // x25 has result
    //addition
    mov x0, x24 // set 0 to B counter
    mov x1, #1
    bl intsub
    mov x24, x0
    //decrement B

    cmp x24, #0 // one works, zero doesn't idk why
    bne loop // if not loop
    b end

zero: // if zero fnc

    mov x25, #0
    b end

neg:
    mov x1, x23 //invert A
    mov x0, #0
    bl intsub
    mov x23, x0
    mov x1, x24 //invert B
    mov x0, #0
    bl intsub
    mov x24, x0
    b resume1

// divides by two
bigdiv:
    lsl x23, x23, #1
    lsr x24, x24, #1
    b loop

end:

    mov x0, x25
    ldp x23, x24, [sp, 16]
    ldp x25, x26, [sp, 32]
    ldp x29, x30, [sp], 48
ret
