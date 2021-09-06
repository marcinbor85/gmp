CURRENT_DIR := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))
HERE := $(shell realpath --relative-to ${ROOT_DIR} ${CURRENT_DIR})

INC_DIRS += ${HERE}

SRC_FILES += \
	${HERE}/main.c
