
    #include "gba_io.h"
    #include "gba_swi.h"
    #include "macros.h"

    #include "assets.h"

    .text
    .arm
    .align
    .global main
main:
    // Set vblank interrupt handler and enable vblank irq
    ldr r0, =g_vblank_irq_handler
    ldr r1, =vblankHandler
    str r1, [r0]
    mov r0, #IO
    mov r1, #VBLANK_ENABLE
    strh r1, [r0, #REG_DISPSTAT]
    mov r1, #IRQ_VBLANK
    str r1, [r0, #REG_IE]

    // Set up display registers
    mov r1, #MODE_4
    orr r1, #BG2_ENABLE
    strh r1, [r0, #REG_DISPCNT]

    ldr r0, =palette
    mov r1, #CGRAM
    mov r2, #palette.size/4
    swi CpuFastSet<<16

    ldr r0, =iwram_loop
    bx r0

    .section .iwram,"ax",%progbits
    .arm
    .align
iwram_loop:
    mov r0, #0
    bl clearFramebuffer

    bl fillTriangle

    swi VBlankIntrWait<<16
    b iwram_loop

    .arm
    .align
    .global vblankHandler
vblankHandler:
    push {lr}
    bl readKeys
    pop {pc}

// vim:ft=arm
