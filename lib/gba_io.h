#ifndef GBA_IO_H
#define GBA_IO_H

#define IO      (0x04000000)
#define CGRAM   (0x05000000)
#define VRAM    (0x06000000)

// Use as such:
//  ldr r0, =IO+VCOUNT
//  str r1, [r0]
// or:
//  mov r0, #IO
//  str r1, [r0, #BG0CNT]
//  str r2, [r0, #BG1CNT]

// LCD registers
#define REG_DISPCNT     (0x0)       //
#define MODE_0          (0)
#define MODE_1          (1)
#define MODE_2          (2)
#define MODE_3          (3)
#define MODE_4          (4)
#define MODE_5          (5)
#define PAGE_BIT(x)     (((x) & 1)<<4)
#define OAM_HBLANK      (0x0020)
#define OAM_1D          (0x0040)
#define FORCE_BLANK     (0x0080)
#define BG0_ENABLE      (0x0100)
#define BG1_ENABLE      (0x0200)
#define BG2_ENABLE      (0x0400)
#define BG3_ENABLE      (0x0800)
#define OBJ_ENABLE      (0x1000)
#define WIN0_ENABLE     (0x2000)
#define WIN1_ENABLE     (0x4000)
#define WINOBJ_ENABLE   (0x8000)

#define REG_DISPSTAT        (0x4)       //
#define VBLANK_FLAG         (0x0001)    // Set on scanline 160-226
#define HBLANK_FLAG         (0x0002)    // Set during hblank on all scanlines
#define VCOUNT_FLAG         (0x0004)    // 
#define VBLANK_ENABLE       (0x0008)
#define HBLANK_ENABLE       (0x0010)
#define VCOUNT_IRQ_ENABLE   (0x0020)
#define VCOUNT_IRQ_Y(x)     (((x) & 0xFF)<<8)

#define REG_VCOUNT      (0x6)       //

#define REG_BG0CNT      (0x8)       //
#define REG_BG1CNT      (0xA)       //
#define REG_BG2CNT      (0xC)       //
#define REG_BG3CNT      (0xE)       //
#define BG_PRIO(x)      ((x) & 3)
#define CHR_BASE(x)     (((x) & 3)<<2)
#define MOSAIC_ENABLE   (0x0040)
#define BG_16COLOR      (0x0000)
#define BG_256COLOR     (0x0080)
#define MAP_BASE(x)     (((x) & 0xF)<<8)
#define MAP_SIZE(x)     (((x) & 3)<<14)

#define REG_BG0HOFS     (0x10)      //
#define REG_BG0VOFS     (0x12)      //
#define REG_BG1HOFS     (0x14)      //
#define REG_BG1VOFS     (0x16)      //
#define REG_BG2HOFS     (0x18)      //
#define REG_BG2VOFS     (0x1A)      //
#define REG_BG3HOFS     (0x1C)      //
#define REG_BG3VOFS     (0x1E)      //

#define REG_BG2PA       (0x20)      //
#define REG_BG2PB       (0x22)      //
#define REG_BG2PC       (0x24)      //
#define REG_BG2PD       (0x26)      //
#define REG_BG2X        (0x28)      //
#define REG_BG2Y        (0x2C)      //

#define REG_BG3PA       (0x30)      //
#define REG_BG3PB       (0x32)      //
#define REG_BG3PC       (0x34)      //
#define REG_BG3PD       (0x36)      //
#define REG_BG3X        (0x38)      //
#define REG_BG3Y        (0x3C)      //

#define REG_WIN0H       (0x40)      //
#define REG_WIN1H       (0x42)      //
#define REG_WIN0V       (0x44)      //
#define REG_WIN1V       (0x46)      //
#define REG_WININ       (0x48)      //
#define REG_WINOUT      (0x4A)      //

#define REG_MOSAIC      (0x4C)      //

#define REG_BLDCNT      (0x50)      //
#define REG_BLDALPHA    (0x52)      //
#define REG_BLDY        (0x54)      //

// Sound registers
#define REG_SOUND1CNT_L (0x60)      //
#define REG_SOUND1CNT_H (0x62)      //
#define REG_SOUND1CNT_X (0x64)      //

#define REG_SOUND2CNT_L (0x68)      //
#define REG_SOUND2CNT_H (0x6C)      //

#define REG_SOUND3CNT_L (0x70)      //
#define REG_SOUND3CNT_H (0x72)      //
#define REG_SOUND3CNT_X (0x74)      //

#define REG_SOUND4CNT_L (0x78)      //
#define REG_SOUND4CNT_H (0x7C)      //

#define REG_SOUNDCNT_L  (0x80)      // 
#define REG_SOUNDCNT_H  (0x82)      // Mixing/DMA control
#define REG_SOUNDCNT_X  (0x84)      // Sound on/off
#define REG_SOUNDBIAS   (0x88)      // BIOS??

#define REG_WAVE_RAM    (0x90)      // RW 2*16 Channel 3 wave RAM
#define REG_FIFO_A      (0xA0)      // W Channel A FIFO
#define REG_FIFO_B      (0xA4)      // W Channel B FIFO

// DMA transfer channels
#define REG_DMA0SAD     (0xB0)      // Src address 27 bits
#define REG_DMA0DAD     (0xB4)      // Dest address 27 bits
#define REG_DMA0CNT_L   (0xB8)      // hword/word count 14 bits
#define REG_DMA0CNT_H   (0xBA)      // See flags below
#define REG_DMA1SAD     (0xBC)      // Src address 28 bits
#define REG_DMA1DAD     (0xC0)      // Dest address 27 bits
#define REG_DMA1CNT_L   (0xC4)      // hword/word count 14 bits
#define REG_DMA1CNT_H   (0xC6)
#define REG_DMA2SAD     (0xC8)      // Src address 28 bits
#define REG_DMA2DAD     (0xCC)      // Dest address 27 bits
#define REG_DMA2CNT_L   (0xD0)      // hword/word count 14 bits
#define REG_DMA2CNT_H   (0xD2)
#define REG_DMA3SAD     (0xD4)      // Src address 28 bits
#define REG_DMA3DAD     (0xD8)      // Dest address 28 bits
#define REG_DMA3CNT_L   (0xDC)      // hword/word count 16 bits
#define REG_DMA3CNT_H   (0xDE)
// DMAxCNT_H flags, OR with CNT_L setting and write word to CNT_L
#define DMA_DST_DEC     (0x00200000)    // Decrement destination pointer
#define DMA_DST_FIXED   (0x00400000)    // Fixed destination
#define DMA_DST_INCREL  (0x00600000)    // Increment/reload
#define DMA_SRC_DEC     (0x00800000)    // Decrement source pointer
#define DMA_SRC_FIXED   (0x01000000)    // Fixed source
#define DMA_SRC_INCREL  (0x01800000)
#define DMA_REPEAT      (0x02000000)
#define DMA_16          (0x00000000)
#define DMA_32          (0x04000000)
#define DMA3_DRQ        (0x08000000)
#define DMA_VBLANK      (0x10000000)    // Start transfer on VBlank
#define DMA_HBLANK      (0x20000000)    // Start transfer on HBlank
#define DMA_SPECIAL     (0x30000000)
#define DMA_IRQ         (0x40000000)    // Trigger IRQ on end
#define DMA_ENABLE      (0x80000000)
#define DMA_DISABLE     (0x00000000)

// Timer registers
#define REG_TM0CNT_L    (0x100)     //
#define REG_TM0CNT_H    (0x102)     //
#define REG_TM1CNT_L    (0x104)     //
#define REG_TM1CNT_H    (0x106)     //
#define REG_TM2CNT_L    (0x108)     //
#define REG_TM2CNT_H    (0x10A)     //
#define REG_TM3CNT_L    (0x10C)     //
#define REG_TM3CNT_H    (0x10E)     //

// Serial communication
#define REG_SIODATA32   (0x120)     //
#define REG_SIOMULTI0   (0x120)     //
#define REG_SIOMULTI1   (0x122)     //
#define REG_SIOMULTI2   (0x124)     //
#define REG_SIOMULTI3   (0x126)     //
#define REG_SIOCNT      (0x128)     //
#define REG_SIOMLT_SEND (0x12A)     //
#define REG_SIODATA8    (0x12A)     //

// Keypad input
#define REG_KEYINPUT    (0x130)     //
#define REG_KEYCNT      (0x132)     //

// Serial communication 2
#define REG_RCNT        (0x134)     //
#define REG_JOYCNT      (0x140)     //
#define REG_JOY_RECV    (0x150)     //
#define REG_JOY_TRANS   (0x154)     //
#define REG_JOYSTAT     (0x158)     //

// Interrupts, waitstate
#define REG_IE      (0x200)         // Interrupt enable
#define REG_IF      (0x202)         // Interrupt request flags
#define IRQ_VBLANK  (0x0001)
#define IRQ_HBLANK  (0x0002)
#define IRQ_VCOUNT  (0x0004)
#define IRQ_TIMER0  (0x0008)
#define IRQ_TIMER1  (0x0010)
#define IRQ_TIMER2  (0x0020)
#define IRQ_TIMER3  (0x0040)
#define IRQ_SIO     (0x0080)
#define IRQ_DMA0    (0x0100)
#define IRQ_DMA1    (0x0200)
#define IRQ_DMA2    (0x0400)
#define IRQ_DMA3    (0x0800)
#define IRQ_KEYPAD  (0x1000)
#define IRQ_GAMEPAK (0x2000)

#define REG_WAITCNT  (0x204)        // Waitstate control
#define REG_IME      (0x208)        // Interrupt master enable

#endif //GBA_IO_H
