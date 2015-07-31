#ifndef ASSETS_H
#define ASSETS_H

    .section .rodata
    .align
    .global palette, palette.end
palette:
    .incbin "gfx/palette.pal.bin"
.equ palette.size, .-palette

#endif //ASSETS_H
// vim:ft=arm
