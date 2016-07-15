
    #include "gba_io.h"
    #include "macros.h"

    .section .iwram,"ax",%progbits
    .arm
    .align
    .global readKeys
readKeys:
    // in: void
    // out: void
    mov r0, #IO
    ldr r1, [r0, #REG_KEYINPUT] // r1 = REG_KEYINPUT
    mov r2, #-1                 // | Invert bits so 0 = released
    eor r1, r2                  // /
    mov r4, r1
    adr r0, keys_held
    ldrh r2, [r0]               // r2 = keys_held
    ldrh r3, [r0, #2]           // r3 = keys_pressed
    strh r2, [r0, #4]           // keys_held_prev = r2
    strh r1, [r0]               // keys_held = REG_KEYINPUT
    eor r1, r2                  // | r1 ^= keys_held_prev
    and r1, r4                  // | r1 &= keys_held
    strh r1, [r0, #2]           // / keys_pressed = r1
    bx lr

    .global keys_held, keys_pressed, keys_held_prev
keys_held:
    .space 2
keys_pressed:
    .space 2
keys_held_prev:
    .space 2

// vim:ft=arm
