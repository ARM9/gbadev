include ../base.mk

TARGET		:= $(shell basename $(CURDIR))
OUTPUT		:= $(TARGET)
BUILD		:= build
SOURCES		:= . ../lib
INCLUDES	:= $(BUILD) ../lib
INCLUDE		:= $(foreach dir,$(INCLUDES),-I$(dir))

ASFLAGS		:= -g -mcpu=arm7tdmi -mthumb-interwork $(INCLUDE)
LDFLAGS		:= -g -T ../lib/cart.ld

SFILES		:= $(foreach dir,$(SOURCES),$(notdir $(wildcard $(dir)/*.S)))
OFILES		:= $(SFILES:%.S=build/%.o)
DEPFILES	:= $(OFILES:.o=.d)

VPATH	:= $(foreach dir,$(SOURCES),$(CURDIR)/$(dir))

.PHONY: all clean debug release run

all: release

debug: ASFLAGS	+= -DDEBUG
debug: LDFLAGS	+=
debug: $(OUTPUT).gba

release: ASFLAGS	+=
release: LDFLAGS	+=
release: $(OUTPUT).gba

$(OUTPUT).gba : $(OUTPUT).elf

$(OUTPUT).elf : $(BUILD) $(OFILES)

$(BUILD):
	@mkdir -p $@

clean:
	rm -rf $(OUTPUT).gba $(OUTPUT).elf $(BUILD)

run:
	mgba -2 $(OUTPUT).gba

-include $(DEPFILES)

