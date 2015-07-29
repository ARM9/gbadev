GBA assembly programming with binutils

Calling convention:
```
r0-r7:  Function arguments, caller saved
r8-r11: Callee saved
r12:    Caller saved (used by blx stub)
r13:    Stack pointer
r14:    Link register
```
