CC	:= arm-none-eabi-gcc
AS	:= arm-none-eabi-as
LD	:= arm-none-eabi-ld
CPP	:= arm-none-eabi-cpp
OBJCOPY	:= arm-none-eabi-objcopy
OBJDUMP	:= arm-none-eabi-objdump

build/%.o : %.S
	$(CC) $(asflags) -MMD -c $< -o $@

build/%.o : %.s
	$(CC) $(asflags) -MMD -c $< -o $@

%.gba : %.elf
	$(OBJCOPY) -O binary $< $@
	gbafix $@

%.elf:
	$(LD) $(ldflags) -o $@ $(ofiles)

