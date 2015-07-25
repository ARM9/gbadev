
OUTPUT_FORMAT("elf32-littlearm")
OUTPUT_ARCH(arm)

EXTERN(_start)
ENTRY(_start)

MEMORY {
    rom     : ORIGIN = 0x08000000, LENGTH = 32M
    iwram   : ORIGIN = 0x03000000, LENGTH = 32K
    ewram   : ORIGIN = 0x02000000, LENGTH = 256K
}

__text_start    = ORIGIN(rom);
__ewram_start   = ORIGIN(ewram);
__heap_end      = ORIGIN(ewram) + LENGTH(ewram);
__iwram_start   = ORIGIN(iwram);
__iwram_top     = ORIGIN(iwram) + LENGTH(iwram);
__sp_irq        = __iwram_top - 0x060;
__sp_sys        = __iwram_top - 0x100;

SECTIONS {
    . = __text_start;
    .text : {
        *(.init);
        *(.text .text.*);
        . = ALIGN(4);
        __text_end = .;
    } >rom

    .rodata : {
        *(.rodata .rodata.*)
        . = ALIGN(4);
    } >rom

    __iwram_lma = .;
    .iwram __iwram_start : AT(__iwram_lma) {
        *(.iwram)
        . = ALIGN(4);
        __iwram_end = ABSOLUTE(.);
    }

    __data_lma = __iwram_lma + SIZEOF(.iwram);
    .data ALIGN(4) : AT(__data_lma) {
        __data_start = ABSOLUTE(.);
        *(.data .data.*)
        . = ALIGN(4);
        __data_end = ABSOLUTE(.);
    }
    __iwram_lma_end = __iwram_lma + (__data_end - __iwram_start);

    .bss ALIGN(4) (NOLOAD) : {
        __bss_start = ABSOLUTE(.);
        *(.bss .bss.*)
        . = ALIGN(4);
        __bss_end = ABSOLUTE(.);
    } AT>iwram

    __ewram_lma = __iwram_lma_end;
    .ewram __ewram_start : AT(__ewram_lma) {
        *(.ewram)
        . = ALIGN(4);
        __ewram_end = ABSOLUTE(.);
    }
    __ewram_lma_end = __ewram_lma + SIZEOF(.ewram);

    .sbss ALIGN(4) (NOLOAD) : {
        __sbss_start = ABSOLUTE(.);
        *(.sbss)
        . = ALIGN(4);
        __sbss_end = ABSOLUTE(.);
        __heap_start = ABSOLUTE(.);
    } AT>ewram
}

