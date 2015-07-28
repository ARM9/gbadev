#ifndef MACROS_H
#define MACROS_H

#define Bit(x) (1<<x)

#ifdef DEBUG
    #define Break mov r11,r11
#else
    #define Break 
#endif

#define blx_r3(x) ldr r3, =x; bl _blx_r3_stub

#endif //MACROS_H
