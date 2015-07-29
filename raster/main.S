
    #include "gba_io.h"
    #include "gba_swi.h"
    #include "macros.h"

    .text
    .arm
    .align
    .global main
main:
    @ Set vblank interrupt handler and enable vblank irq
    ldr r0, =g_vblank_irq_handler
    ldr r1, =vblankHandler
    str r1, [r0]
    mov r0, #IO
    mov r1, #VBLANK_ENABLE
    strh r1, [r0, #REG_DISPSTAT]
    mov r1, #IRQ_VBLANK
    str r1, [r0, #REG_IE]

    @ Set up display registers
    mov r1, #MODE_4
    orr r1, #BG2_ENABLE
    strh r1, [r0, #REG_DISPCNT]

    ldr r0, =iwram_loop
    bx r0

    .section .iwram,"ax",%progbits
    .arm
    .align
iwram_loop:
    Break
    swi VBlankIntrWait<<16
    b iwram_loop

    .arm
    .align
    .global vblankHandler
vblankHandler:
    bx lr

@ vim:ft=arm
