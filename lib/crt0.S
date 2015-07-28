
    #include "gba_io.h"

    .section .init
    .arm
    .align
    .global _start
_start:
    b _rom_header_end

    @ Header
    .space  156             @ Logo
    .space  12              @ Game title
    .space  4               @ Game code
    .byte   0x30, 0x31      @ Maker code
    .byte   0x96            @ Fixed value must be 0x96
    .byte   0               @ Main unit code
    .byte   0               @ Device type
    .space  7               @ Reserved area
    .byte   0x00            @ Version number 1.x
    .byte   0               @ Checksum complement
    .byte   0,0             @ Checksum

    @ Multiboot header
    @b _ram_start      @ RAM entry point
    @.byte   0         @ Boot mode
    @.byte   0         @ Slave number
    @.space  26        @ Unused
    @b _joybus_start   @ GBA/GCN entry point

    .align
_rom_header_end:
    mov r0, #IO             @ Disable interrupts
    str r0, [r0, #REG_IME]

    mov r0, #0x12           @ Set up irq stack pointer
    msr cpsr, r0
    ldr sp, =__sp_irq
    mov r0, #0x1f           @ System mode stack pointer
    msr cpsr, r0
    ldr sp, =__sp_sys

    orr r0, pc, #1          @ Switch to thumb state
    bx r0
    .thumb
    ldr r0, =__iwram_start  @ Load iwram sections
    ldr r1, =__iwram_lma
    ldr r2, =__iwram_lma_end
    bl _mem_copy

    ldr r0, =__bss_start    @ Clear bss section
    ldr r1, =__bss_end
    bl _mem_clear

    ldr r0, =__ewram_start  @ Load ewram sections
    ldr r1, =__ewram_lma
    ldr r2, =__ewram_lma_end
    bl _mem_copy

    ldr r0, =__sbss_start   @ Clear sbss section
    ldr r1, =__sbss_end
    bl _mem_clear

    ldr r0, =__iwram_top-4  @ Set interrupt handler
    ldr r1, =_irq_handler
    str r1, [r0]

    ldr r0, =main
    bx r0

    .align 1
    .thumb_func
_mem_copy:
    @ in:
    @   r0 dest
    @   r1 src
    @   r2 end
    @ out: void
    @ clobbers: r3
    cmp r1, r2
    beq 1f
0:
    ldmia r1!, {r3}
    stmia r0!, {r3}
    cmp r1, r2
    blo 0b
1:
    bx lr

    .thumb_func
_mem_clear:
    @ in:
    @   r0 dest
    @   r1 end
    @ out: void
    @ clobbers: r2
    cmp r0, r1
    beq 1f      @ end if size = 0
    mov r2, #0
0:
    stmia r0!, {r2}
    cmp r0, r1
    blo 0b
1:
    bx lr

    .section .iwram,"ax",%progbits
    .align 1
    .thumb_func
    .global _blx_r3_stub
_blx_r3_stub:
    bx r3

@ vim:ft=arm
