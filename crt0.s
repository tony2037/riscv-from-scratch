.section .init, "ax"
.global _start
_start:
    /* see: https://stackoverflow.com/questions/29527623/in-assembly-code-how-cfi-directive-works/33732119#33732119 */
    /* also see: https://sourceware.org/binutils/docs/as/CFI-directives.html */
    .cfi_startproc
    .cfi_undefined ra
    .option push
    .option norelax
    la gp, __global_pointer$
    .option pop
    /* set the address. __statck_top to sp, stack pointer */
    la sp, __stack_top
    /* s0 is what is known as a “saved register” meaning it is preserved across function calls. Second, s0 sometimes acts as the frame pointer, which enables each function invocation to maintain it’s own little space on the stack for storing parameters passed into that function. */
    add s0, sp, zero
    /* unconditional jump */
    jal zero, main
    .cfi_endproc
    .end
