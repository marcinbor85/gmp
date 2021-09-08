################################################################################
# build tools

CC = gcc
CXX = g++
MK = mkdir
RM = rm

################################################################################
# project configuration

PROJECT = example

OUT_DIR = out
SRC_DIR = src

CFLAGS = -std=c11 -Werror -Wall -Wextra --pedantic
CXXFLAGS = -std=c++20 -Werror -Wall -Wextra --pedantic
LDFLAGS = 

################################################################################
# prepare variables

RWILDCARD = $(wildcard $1$2) $(foreach d,$(wildcard $1*),$(call RWILDCARD,$d/,$2))
SRC_C_FILES = $(call RWILDCARD,$(SRC_DIR)/,*.c)
OBJ_C_FILES = $(addprefix $(OUT_DIR)/, $(patsubst %.c,%.o,$(SRC_C_FILES)))
SRC_CXX_FILES = $(call RWILDCARD,$(SRC_DIR)/,*.cpp)
OBJ_CXX_FILES = $(addprefix $(OUT_DIR)/, $(patsubst %.cpp,%.o,$(SRC_CXX_FILES)))
INC_FILES = $(call RWILDCARD,$(SRC_DIR)/,*.h) $(call RWILDCARD,$(SRC_DIR)/,*.hpp)
INC_DIRS = $(SRC_DIR) $(patsubst %/,%,$(sort $(dir $(INC_FILES))))
INCLUDES = $(addprefix -I, $(INC_DIRS))
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

$(TARGET): $(OBJ_C_FILES) $(OBJ_CXX_FILES)
	$(CC) $(LDFLAGS) $^ -o $@ 

$(OUT_DIR)/%.o: %.c | $$(@D)/.
	$(CC) -c $(CFLAGS) $(INCLUDES) $< -o $@

$(OUT_DIR)/%.o: %.cpp | $$(@D)/.
	$(CXX) -c $(CXXFLAGS) $(INCLUDES) $< -o $@

clean:
	$(RM) -rf $(OUT_DIR)
