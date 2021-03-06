#
# Copyright 2014, NICTA
#
# This software may be distributed and modified according to the terms of
# the BSD 2-Clause license. Note that NO WARRANTY is provided.
# See "LICENSE_BSD2.txt" for details.
#
# @TAG(NICTA_BSD)
#

lib-dirs:=libs

VERSION = 1
PATCHLEVEL = 0
SUBLEVEL = 0
EXTRAVERSION = 0

# The main target we want to generate
#all: sel4test-image
all: sel4bench-image

-include .config

export TIMING_PMC0_EVENT?=SEL4BENCH_EVENT_CACHE_L1D_MISS
export TIMING_PMC1_EVENT?=SEL4BENCH_EVENT_CACHE_L1I_MISS
export DEFINES+="TIMING_PMC0_EVENT=$(TIMING_PMC0_EVENT)"
export DEFINES+="TIMING_PMC1_EVENT=$(TIMING_PMC1_EVENT)"

include tools/common/project.mk

# Some example qemu invocations

simulate-kzm:
	/opt/ertos/simulators-x86_64/qemu-arm -nographic -M kzm \
		-kernel images/sel4bench-image-arm-imx31

simulate-beagle:
	/opt/ertos/simulators-x86_64/qemu-arm -nographic -M beagle \
		-kernel images/sel4bench-image-arm-omap3

simulate-ia32:
	/opt/ertos/simulators-x86_64/qemu -L /opt/ertos/simulators-x86_64/pc-bios \
		-m 512 -nographic -kernel images/kernel-ia32-pc99 \
		-initrd images/sel4bench-image-ia32-pc99
