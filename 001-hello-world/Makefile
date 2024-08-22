NAME=hello-world

BIN=$(NAME)
OBJECTS=$(NAME).o

# --------

ASM=nasm
AFLAGS=-f elf64

LD=ld.lld
LDFLAGS=

# --------

all: $(BIN)

clean:
	rm $(OBJECTS) $(BIN) || true

# --------

$(BIN): $(OBJECTS)
	$(LD) $(LDFLAGS) -o $@ $^

%.o: %.asm
	$(ASM) $(AFLAGS) -o $@ $<

