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
#define DISPCNT     (0x0)       //
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

#define DISPSTAT    (0x4)       //
#define VBLANK      (0x0001)    // Set on scanline 160-226
#define HBLANK      (0x0002)    // Set during hblank on all scanlines
#define VCOUNT_FLAG (0x0004)    // 
#define VBL_ENABLE  (0x0008)
#define HBL_ENABLE  (0x0010)
#define VIRQ_ENABLE (0x0020)
#define VIRQ_Y(x)   (((x) & 0xFF)<<8)

#define VCOUNT      (0x6)       //

#define BG0CNT      (0x8)       //
#define BG1CNT      (0xA)       //
#define BG2CNT      (0xC)       //
#define BG3CNT      (0xE)       //
#define BG_PRIO(x)      ((x) & 3)
#define CHR_BASE(x)     (((x) & 3)<<2)
#define MOSAIC_ENABLE   (0x0040)
#define BG_16COLOR      (0x0000)
#define BG_256COLOR     (0x0080)
#define MAP_BASE(x)     (((x) & 0xF)<<8)
#define MAP_SIZE(x)     (((x) & 3)<<14)

#define BG0HOFS     (0x10)      //
#define BG0VOFS     (0x12)      //
#define BG1HOFS     (0x14)      //
#define BG1VOFS     (0x16)      //
#define BG2HOFS     (0x18)      //
#define BG2VOFS     (0x1A)      //
#define BG3HOFS     (0x1C)      //
#define BG3VOFS     (0x1E)      //

#define BG2PA       (0x20)      //
#define BG2PB       (0x22)      //
#define BG2PC       (0x24)      //
#define BG2PD       (0x26)      //
#define BG2X        (0x28)      //
#define BG2Y        (0x2C)      //

#define BG3PA       (0x30)      //
#define BG3PB       (0x32)      //
#define BG3PC       (0x34)      //
#define BG3PD       (0x36)      //
#define BG3X        (0x38)      //
#define BG3Y        (0x3C)      //

#define WIN0H       (0x40)      //
#define WIN1H       (0x42)      //
#define WIN0V       (0x44)      //
#define WIN1V       (0x46)      //
#define WININ       (0x48)      //
#define WINOUT      (0x4A)      //

#define MOSAIC      (0x4C)      //

#define BLDCNT      (0x50)      //
#define BLDALPHA    (0x52)      //
#define BLDY        (0x54)      //

// Sound registers
#define SOUND1CNT_L (0x60)      //
#define SOUND1CNT_H (0x62)      //
#define SOUND1CNT_X (0x64)      //

#define SOUND2CNT_L (0x68)      //
#define SOUND2CNT_H (0x6C)      //

#define SOUND3CNT_L (0x70)      //
#define SOUND3CNT_H (0x72)      //
#define SOUND3CNT_X (0x74)      //

#define SOUND4CNT_L (0x78)      //
#define SOUND4CNT_H (0x7C)      //

#define SOUNDCNT_L  (0x80)      // 
#define SOUNDCNT_H  (0x82)      // Mixing/DMA control
#define SOUNDCNT_X  (0x84)      // Sound on/off
#define SOUNDBIAS   (0x88)      // BIOS??

#define WAVE_RAM    (0x90)      // RW 2*16 Channel 3 wave RAM
#define FIFO_A      (0xA0)      // W Channel A FIFO
#define FIFO_B      (0xA4)      // W Channel B FIFO

// DMA transfer channels
#define DMA0SAD     (0xB0)      //
#define DMA0DAD     (0xB4)      //
#define DMA0CNT_L   (0xB8)      //
#define DMA0CNT_H   (0xBA)      //
#define DMA1SAD     (0xBC)      //
#define DMA1DAD     (0xC0)      //
#define DMA1CNT_L   (0xC4)      //
#define DMA1CNT_H   (0xC6)      //
#define DMA2SAD     (0xC8)      //
#define DMA2DAD     (0xCC)      //
#define DMA2CNT_L   (0xD0)      //
#define DMA2CNT_H   (0xD2)      //
#define DMA3SAD     (0xD4)      //
#define DMA3DAD     (0xD8)      //
#define DMA3CNT_L   (0xDC)      //
#define DMA3CNT_H   (0xDE)      //

// Timer registers
#define TM0CNT_L    (0x100)     //
#define TM0CNT_H    (0x102)     //
#define TM1CNT_L    (0x104)     //
#define TM1CNT_H    (0x106)     //
#define TM2CNT_L    (0x108)     //
#define TM2CNT_H    (0x10A)     //
#define TM3CNT_L    (0x10C)     //
#define TM3CNT_H    (0x10E)     //

// Serial communication
#define SIODATA32   (0x120)     //
#define SIOMULTI0   (0x120)     //
#define SIOMULTI1   (0x122)     //
#define SIOMULTI2   (0x124)     //
#define SIOMULTI3   (0x126)     //
#define SIOCNT      (0x128)     //
#define SIOMLT_SEND (0x12A)     //
#define SIODATA8    (0x12A)     //

// Keypad input
#define KEYINPUT    (0x130)     //
#define KEYCNT      (0x132)     //

// Serial communication 2
#define RCNT        (0x134)     //
#define JOYCNT      (0x140)     //
#define JOY_RECV    (0x150)     //
#define JOY_TRANS   (0x154)     //
#define JOYSTAT     (0x158)     //

// Interrupts, waitstate
#define IE       (0x200)        // Interrupt enable
#define IF       (0x202)        // Interrupt request flags
#define WAITCNT  (0x204)        // Waitstate control
#define IME      (0x208)        // Interrupt master enable

#endif //GBA_H
