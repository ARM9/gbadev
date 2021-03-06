#ifndef GBA_SWI_H
#define GBA_SWI_H

// arm <<16
#define SoftReset           0x0
#define RegisterRamReset    0x1
#define GetBiosChecksum     0xD
#define MultiBoot           0x25
#define HardReset           0x26

#define Halt                0x2
#define Sleep               0x3
#define IntrWait            0x4
#define VBlankIntrWait      0x5

#define Div                 0x6
#define DivArm              0x7
#define Sqrt                0x8
#define Atan                0x9
#define Atan2               0xA

#define CpuSet              0xB
#define CpuFastSet          0xC

#define BgAffineSet         0xE
#define ObjAffineSet        0xF

#define BitDecomp           0x10
#define LZ77DecompWram      0x11
#define LZ77DecompVram      0x12
#define HuffDecomp          0x13
#define RLEDecompWram       0x14
#define RLEDecompVram       0x15
#define Diff8Wram           0x16
#define Diff8Vram           0x17
#define Diff16              0x18

#define SoundBias           0x19
#define SoundDriverInit     0x1A
#define SoundDriverMode     0x1B
#define SoundDriverMain     0x1C
#define SoundDriverVSync    0x1D
#define SoundChannelClear   0x1E
#define MidiKey2Freq        0x1F
#define SoundWhatever0      0x20
#define SoundWhatever1      0x21
#define SoundWhatever2      0x22
#define SoundWhatever3      0x23
#define SoundWhatever4      0x24
#define SoundDriverVSyncOff 0x28
#define SoundDriverVSyncOn  0x29
#define SoundGetJumpList    0x2A

#endif //GBA_SWI_H
