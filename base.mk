export CC	:= arm-none-eabi-gcc
export AS	:= arm-none-eabi-as
export LD	:= arm-none-eabi-ld
export CPP	:= arm-none-eabi-cpp
export OBJCOPY	:= arm-none-eabi-objcopy
export OBJDUMP	:= arm-none-eabi-objdump

build/%.o : %.S
	$(CC) $(ASFLAGS) -MMD -c $< -o $@

%.gba : %.elf
	$(OBJCOPY) -O binary $< $@
	gbafix $@

%.elf:
	$(LD) $(LDFLAGS) -o $@ $(OFILES)

