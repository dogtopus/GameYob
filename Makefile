# TARGET #

TARGET ?= 3DS
LIBRARY := 0

ifeq ($(TARGET),3DS)
	ifeq ($(strip $(DEVKITPRO)),)
		$(error "Please set DEVKITPRO in your environment. export DEVKITPRO=<path to>devkitPro")
	endif

	ifeq ($(strip $(DEVKITARM)),)
		$(error "Please set DEVKITARM in your environment. export DEVKITARM=<path to>devkitARM")
	endif
endif

# COMMON CONFIGURATION #

NAME := GameYob

BUILD_DIR := build
OUTPUT_DIR := output
INCLUDE_DIRS := include
SOURCE_DIRS := source

EXTRA_OUTPUT_FILES :=

ifeq ($(TARGET),3DS)
	LIBRARY_DIRS := $(DEVKITPRO)/citrus $(DEVKITPRO)/libctru
	LIBRARIES := citrus ctru m
else
	LIBRARY_DIRS :=
	LIBRARIES := ncurses SDL2 m
endif

BUILD_FLAGS := -Wunused-result -DVERSION_STRING="\"`git describe --tags --abbrev=0` (`git describe --always --abbrev=10`)\""
ifeq ($(TARGET),3DS)
	BUILD_FLAGS += -DBACKEND_3DS
else
	BUILD_FLAGS += -DBACKEND_SDL
endif

RUN_FLAGS :=

# 3DS CONFIGURATION #

DESCRIPTION := (Super) GameBoy (Color) emulator.
AUTHOR := Drenn, Steveice10
PRODUCT_CODE := CTR-P-GYOB
UNIQUE_ID := 0x1927

SYSTEM_MODE := 64MB
SYSTEM_MODE_EXT := Legacy

ROMFS_DIR :=
BANNER_AUDIO := meta/audio.wav
BANNER_IMAGE := meta/banner.png
ICON := meta/icon.png

# INTERNAL #

include buildtools/make_base
