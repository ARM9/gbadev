include ../base.mk

target		:= $(shell basename $(CURDIR))
output		:= $(target)
build		:= build
sources		:= . ../lib
incdirs		:= $(build) ../lib
includes	:= $(foreach dir,$(incdirs),-I$(dir))

asflags		:= -g -mcpu=arm7tdmi -mthumb-interwork $(includes)
ldflags		:= -g -T ../lib/cart.ld

sfiles		:= $(foreach dir,$(sources),$(notdir $(wildcard $(dir)/*.S)))
ofiles		:= $(sfiles:%.S=$(build)/%.o)
depfiles	:= $(ofiles:.o=.d)

VPATH	:= $(foreach dir,$(sources),$(CURDIR)/$(dir))

.PHONY: all clean debug release run

all: release

debug: asflags	+= -DDEBUG
debug: ldflags	+=
debug: $(output).gba

release: asflags	+=
release: ldflags	+=
release: $(output).gba

$(output).gba : $(output).elf

$(output).elf : $(build) $(ofiles)

$(build):
	@mkdir -p $@

clean:
	rm -rf $(output).gba $(output).elf $(build)

run:
	mgba -2 $(output).gba

-include $(depfiles)

