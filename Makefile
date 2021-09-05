CC = gcc
CFLAGS = -I.

TARGET = test

SRC = gmp.c test.c

.phony: all clean

all:
	$(CC) $(CFLAGS) $(SRC) -o $(TARGET)

clean:
	rm $(TARGET)
