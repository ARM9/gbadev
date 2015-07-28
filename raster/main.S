
    #include "gba_io.h"
    #include "gba_swi.h"
    #include "macros.h"

    .text
    .arm
    .align
    .global main
main:
    ldr r0, =g_vblank_irq_handler
    ldr r1, =vblankHandler
    str r1, [r0]

    mov r0, #IO
    mov r1, #VBL_ENABLE
    str r1, [r0, #REG_DISPSTAT]
    mov r1, #IRQ_VBLANK
    str r1, [r0, #REG_IE]

    ldr r0, =iwram_loop
    bx r0

    .section .iwram,"ax",%progbits
    .arm
    .align
iwram_loop:
    swi VBlankIntrWait<<16
    b iwram_loop

    .arm
    .align
    .global vblankHandler
vblankHandler:
    bx lr

    .align
    .data
    .word 0xfeedbacc
    
    .bss
    .space 40

    .section .ewram,"ax",%progbits
    .word 0xEEEEEEEE,0xDDDDDDDD,0xCCCCCCCC,0xBBBBBBBB

    .section .ewram
    .word 0xFFFFFFFF

    .section .sbss
    .ascii "123456789"

    .section .iwram
    .word 0xcafebabe
@ vim:ft=arm
