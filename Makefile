PIN_ROOT := $(shell realpath ./pin-3.28-98749-g6643ecee5-gcc-linux)

ifneq ("$(PIN_ROOT)", "")
    CONFIG_ROOT := $(PIN_ROOT)/source/tools/Config
    include $(CONFIG_ROOT)/makefile.config
    include $(TOOLS_ROOT)/Config/makefile.default.rules
endif

all: intel64

intel64:
	mkdir -p obj-intel64
	$(MAKE) TARGET=intel64 obj-intel64/branchExt.so

clean-all:
	$(MAKE) TARGET=intel64 clean
