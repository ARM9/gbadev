
    #include "gba_io.h"
    #include "macros.h"

    .section .iwram,"ax",%progbits

    .arm
    .align
    .global _irqHandler
_irqHandler:
    // This routine processes an interrupt request and determines which
    // routine in the global irq table to run and resets the corresponding
    // IF register flag
    mov r0, #IO
    ldr r1, [r0, #REG_IE]
    and r1, r1, r1, lsr #16 // r1 = REG_IE & REG_IF

    ldrh r2, [r0, #-8]      // Write IE&IF flags to BIOS irq flags (3fffff8)
    orr r2, r1              // else VBlankIntrWait gets stuck
    strh r2, [r0, #-8]

    tst r1, #IRQ_GAMEPAK
0:  bne 0b                      // "Crash" if gamepak is removed
    mov r2, #0                  // r2 = Index into interrupt handler table

    ands r3, r1, #IRQ_VBLANK    // Check if vblank interrupt
    bne 1f
    add r2, #4                  // Point to next interrupt handler
    ands r3, r1, #IRQ_HBLANK    // Repeat for next interrupt
    bne 1f
    add r2, #4
    ands r3, r1, #IRQ_VCOUNT
    bne 1f
    add r2, #4
    ands r3, r1, #IRQ_TIMER0
    bne 1f
    add r2, #4
    ands r3, r1, #IRQ_TIMER1
    bne 1f
    add r2, #4
    ands r3, r1, #IRQ_TIMER2
    bne 1f
    add r2, #4
    ands r3, r1, #IRQ_TIMER3
    bne 1f
    add r2, #4
    ands r3, r1, #IRQ_SIO
    bne 1f
    add r2, #4
    ands r3, r1, #IRQ_DMA0
    bne 1f
    add r2, #4
    ands r3, r1, #IRQ_DMA1
    bne 1f
    add r2, #4
    ands r3, r1, #IRQ_DMA2
    bne 1f
    add r2, #4
    ands r3, r1, #IRQ_DMA3
    bne 1f
    add r2, #4
    ands r3, r1, #IRQ_KEYPAD
1:
    orr r0, #0x200
    strh r3, [r0, #2]       // Acknowledge interrupt by writing flag to REG_IF

    mrs r0, spsr            // IRQ disable bit is always cleared in spsr here
    push {r0, r4-r7, lr}    // Save caller saved registers and spsr
                            // BIOS already saved r0-r3 and r12
    msr cpsr, r0            // Enable IRQ, switch to sys mode

    adr r0, g_irq_table     // |
    ldr r1, [r0, r2]        // | Load interrupt handler from table
    mov lr, pc
    bx r1

    mov r0, #0x92           // Disable IRQ, switch to irq mode
    msr cpsr, r0

    pop {r0, r4-r7, lr}
    msr spsr, r0

    bx lr

    .align
    .global g_irq_table
g_irq_table:
    .global g_vblank_irq_handler
    g_vblank_irq_handler:
        .word 0
    .global g_hblank_irq_handler
    g_hblank_irq_handler:
        .word 0
    .global g_vcount_irq_handler
    g_vcount_irq_handler:
        .word 0
    .global g_timer0_irq_handler
    g_timer0_irq_handler:
        .word 0
    .global g_timer1_irq_handler
    g_timer1_irq_handler:
        .word 0
    .global g_timer2_irq_handler
    g_timer2_irq_handler:
        .word 0
    .global g_timer3_irq_handler
    g_timer3_irq_handler:
        .word 0
    .global g_sio_irq_handler
    g_sio_irq_handler:
        .word 0
    .global g_dma0_irq_handler
    g_dma0_irq_handler:
        .word 0
    .global g_dma1_irq_handler
    g_dma1_irq_handler:
        .word 0
    .global g_dma2_irq_handler
    g_dma2_irq_handler:
        .word 0
    .global g_dma3_irq_handler
    g_dma3_irq_handler:
        .word 0
    .global g_keypad_irq_handler
    g_keypad_irq_handler:
        .word 0
    //.global g_gamepak_irq_handler
    //g_gamepak_irq_handler:
        //.word 0

// vim:ft=arm
