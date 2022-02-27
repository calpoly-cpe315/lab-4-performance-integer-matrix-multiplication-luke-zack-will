    // intadd function in this file

    .arch armv8-a
    .global intsub

intsub:
    str x19, [sp, -16]
    stp x20, x21, [sp, -32]
    stp x29, x30, [sp, -48]! // store FP

    mov x19, x0 // stores A
    mov x20, x1 // stores B

loop:

    eor x19, x19, x20 // xor, before and, inverts bits

    and x21, x19, x20 // and, for carry digits
    lsl x20, x21, #1 // make B contain carry, shift by 1

    cmp x20, #0 // if there are carries
    bne loop // branch if not equal

mov x0, x19 // results of final eor
ldr x19, [sp, 16] // load x19

ldp x20, x21, [sp, 32] // load x20, x21
ldp x29, x30, [sp], 48 // load FP

ret

