################################################################################
# build tools

CC = gcc
MK = mkdir

################################################################################
# project configuration

PROJECT = example

OUT_DIR = out
SRC_DIR = src

CFLAGS = -std=c99 -Werror -Wall -Wextra --pedantic
LDFLAGS = 

################################################################################
# prepare variables

RWILDCARD = $(wildcard $1$2) $(foreach d,$(wildcard $1*),$(call RWILDCARD,$d/,$2))
SRC_FILES = $(call RWILDCARD,${SRC_DIR}/,*.c)
INC_FILES = $(call RWILDCARD,${SRC_DIR}/,*.h)
INC_DIRS = ${SRC_DIR} $(patsubst %/,%,$(sort $(dir ${INC_FILES})))
OBJ_FILES = $(addprefix ${OUT_DIR}/, ${SRC_FILES:.c=.o})
INCLUDES = $(addprefix -I, ${INC_DIRS})
TARGET = $(OUT_DIR)/$(PROJECT)

################################################################################
# targets, rules, dependencies

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
