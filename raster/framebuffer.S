
    #include "gba_io.h"
    #include "framebuffer.h"

    .section .iwram,"ax",%progbits
    .align
    .global g_Framebuffer, g_Framebuffer.ptr, g_Framebuffer.frame
g_Framebuffer:
    g_Framebuffer.ptr:
        .word VRAM + FB_FRAME0
    g_Framebuffer.frame:
        .byte FB_FRAME0

    .arm
    .align
    .global clearFramebuffer
clearFramebuffer:
    // in:
    //  r0 clear color
    // out: void
    push {r8-r12, r14}
    orr r0, r0, lsl #8
    orr r0, r0, lsl #16
    mov r1, r0
    mov r2, r0
    mov r3, r0
    mov r4, r0
    mov r5, r0
    mov r6, r0
    mov r7, r0
    mov r8, r0
    mov r9, r0
    mov r10, r0
    mov r11, r0
    adr r14, g_Framebuffer.ptr
    ldr r12, [r14]
    add r14, r12, #FB_SIZE
0:
    stmia r12!, {r0-r11}
    cmp r12, r14
    bne 0b

    pop {r8-r12, r14}
    bx lr

// vim:ft=arm
