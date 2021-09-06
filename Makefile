CC = gcc
MK = mkdir

PROJECT = example

ROOT_DIR = $(shell realpath .)
OUT_DIR = out
SRC_DIR = src
MODULES = gmp test

SRC_FILES :=
INC_DIRS :=

$(foreach M, ${MODULES}, $(eval include ${SRC_DIR}/${M}/make.mk))

CFLAGS = -std=c99 -Werror -Wall -Wextra --pedantic
LDFLAGS = 

OBJ_FILES = $(addprefix ${OUT_DIR}/, ${SRC_FILES:.c=.o})
INCLUDES = $(addprefix -I, ${INC_DIRS})
TARGET = $(OUT_DIR)/$(PROJECT)

.phony: all clean

all: $(TARGET)

.PRECIOUS: $(OUT_DIR)/. $(OUT_DIR)%/.

$(OUT_DIR)/.:
	$(MK) -p $@

$(OUT_DIR)%/.:
	$(MK) -p $@

.SECONDEXPANSION:

$(TARGET): $(OBJ_FILES)
	$(CC) $(LDFLAGS) $^ -o $@ 

${OUT_DIR}/%.o: %.c | $$(@D)/.
	$(CC) -c $(CFLAGS) $(INCLUDES) $< -o $@

clean:
	rm -rf $(OUT_DIR)
