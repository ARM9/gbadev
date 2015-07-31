
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
    mov r2, #palette_size/4
    swi CpuFastSet<<16

    ldr r0, =iwram_loop
    bx r0

    .section .iwram,"ax",%progbits
    .arm
    .align
iwram_loop:
    swi VBlankIntrWait<<16
    //mov r0, #CGRAM
    //ldr r1, =RGB(31,0,0)
    //strh r1, [r0]
    b iwram_loop

    .arm
    .align
    .global vblankHandler
vblankHandler:
    push {lr}
    bl readKeys
    ldr r0, =keys_pressed
    ldrh r0, [r0]
    tst r0, #KEY_START
    beq 0f
    mov r1, #CGRAM
    ldrh r2, [r1]
    add r2, #1
    strh r2, [r1]
0:
    pop {pc}

// vim:ft=arm
