
    #include "gba_io.h"

    .text
    .thumb_func
    .align
    .global main
main:
    mov r0, #0x4
    lsl r0, #24
    mov r1, #VBL_ENABLE
    str r1, [r0, #DISPSTAT]
    ldr r0, =loop
    bx r0

    .section .iwram,"ax",%progbits
    .arm
    .align
loop:
    ldr r0, =foo
    mov lr, pc
    bx r0
    swi 
    b loop

    .thumb_func
_blx_r3_stub:
    bx r3

    .thumb_func
foo:
    push {lr}

    ldr r0, =IO+VCOUNT
    ldr r3, =bar
    bl _blx_r3_stub

    pop {r3}
    bx r3
    
    .arm
bar:
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
