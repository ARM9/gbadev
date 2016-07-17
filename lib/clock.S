
    #include "gba_io.h"

    .thumb

    .text
    .thumb_func
    .balign 2
    .global reset_clock
    .type reset_clock, %function
reset_clock:
// Reset timer 2 and 3, 32 bit counter (3 counts up when 2 overflows)
// in: void
// out: void
    ldr r0, [timer_base]
    // write 0x0000 to TMXCNT_L (reload value) and flags to TMXCNT_H, in one store
    mov r1, #((1<<7) | (0<<6) | (0<<2) | (0<<0))
            //enable   irq     count up  prescaler
    lsl r1, #16 // high hword = flags, low hword = 0x0000
    str r1, [r0, #REG_TM2CNT_L]

    mov r1, #((1<<7) | (0<<6) | (1<<2) | (0<<0))
            //enable   irq     count up  prescaler
    lsl r1, #16
    str r1, [r0, #REG_TM3CNT_L]

    bx lr

    .thumb_func
    .balign 2
    .global clock
    .type clock, %function
clock:
// libc esque clock() function
// in: void
// out:
//  r0: u32 = current clock ticks
    ldr r1, [timer_base]
    ldrh r0, [r1, #REG_TM3CNT_L]
    lsl r0, #16
    ldrh r2, [r1, #REG_TM2CNT_L]
    orr r0, r2

    bx lr

    .local timer_base
    .balign 4
timer_base:
    .word REG_TIMER_BASE

// vim:ft=arm
