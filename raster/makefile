AS	:= arm-none-eabi-as
LD	:= arm-none-eabi-ld
CPP	:= arm-none-eabi-cpp
OBJCOPY	:= arm-none-eabi-objcopy
OBJDUMP	:= arm-none-eabi-objdump

TARGET		:= $(shell basename $(CURDIR))
OUTPUT		:= $(TARGET)
BUILD		:= build
SOURCES		:= . ../lib
INCLUDES	:= $(BUILD) ../lib
INCDIRS		:= $(foreach dir,$(INCLUDES),-I$(dir))

ASFLAGS		:= -g -mcpu=arm7tdmi -mthumb-interwork $(INCDIRS)
LDFLAGS		:= -g -T ../lib/cart.ld
CPPFLAGS	:= $(INCDIRS)

SFILES	:= $(foreach dir,$(SOURCES),$(notdir $(wildcard $(dir)/*.S)))
OFILES	:= $(SFILES:%.S=build/%.o)

VPATH	:= $(foreach dir,$(SOURCES),$(CURDIR)/$(dir))

#------------------------------------------------
build/%.o : %.S
	$(CPP) $(CPPFLAGS) -E -pipe $< | $(AS) $(ASFLAGS) -o $@ -
#------------------------------------------------
.PHONY: all clean debug release run

all: release

debug: ASFLAGS	+=
debug: LDFLAGS	+=
debug: CPPFLAGS	+= -DDEBUG
debug: $(OUTPUT).gba

release: ASFLAGS	+=
release: LDFLAGS	+=
release: $(OUTPUT).gba

$(BUILD):
	@mkdir -p $@

$(OUTPUT).gba : $(OUTPUT).elf
	$(OBJCOPY) -O binary $< $@
	gbafix $@

$(OUTPUT).elf: $(BUILD) $(OFILES)
	$(LD) $(LDFLAGS) -o $@ $(OFILES)

clean:
	rm -rf $(OUTPUT).gba $(OUTPUT).elf $(BUILD)

run:
	mgba -2 $(OUTPUT).gba

