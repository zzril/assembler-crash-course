# This time, we have two compilation units,
# whose names we might want to be able to
# switch out easily...
MAIN=hello
STR=my_string

BIN=$(MAIN)
OBJECTS=$(MAIN).o $(STR).o
# We also have a header file this time:
HEADERS=$(STR).h

# --------

ASM=nasm
AFLAGS=-f elf64

# C-Compiler (clang):
CC=clang
# Enable all warnings:
CFLAGS=-Wall -Wextra -pedantic

# Use clang for linking as well, which will
# by default link the C standard lib:
LD=$(CC)
LDFLAGS=$(CFLAGS)

# --------

all: $(BIN)

clean:
	rm $(OBJECTS) $(BIN) || true

# --------

$(BIN): $(OBJECTS)
	$(LD) $(LDFLAGS) -o $@ $^

# The "main" C module is compiled using the C compiler:
# (Adding the header file to its dependencies,
# to trigger a recompilation if it changes.)
# Specifying the `-c` flag in order to allow us to
# do the linking in a separate step.
$(MAIN).o: $(MAIN).c $(HEADERS)
	$(CC) $(CFLAGS) -c -o $@ $<

# (Nothing changes for the assembly file...)
$(STR).o: $(STR).asm
	$(ASM) $(AFLAGS) -o $@ $<

