
    .text
    .thumb_func
    .align
    .global main
main:
    ldr r0, =loop
    bx r0

    .section .iwram,"ax",%progbits
    .arm
    .align
loop:
    ldr r0, =foo
    mov lr, pc
    bx r0
    b loop

    .thumb_func
_blx_r3_stub:
    bx r3
    .thumb_func
foo:
    push {lr}

    ldr r3, =bar
    bl _blx_r3_stub

    pop {pc}
    
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
