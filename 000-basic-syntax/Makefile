# Some handy variables:

NAME=do-nothing

# The final program to be created by the linker:
BIN=$(NAME)

# (Intermediate) object files to be created by the assembler:
OBJECTS=$(NAME).o

# --------

# Tools used:

# Assembler (nasm):
ASM=nasm

# Flags to-be-used when invoking the assembler:
# (Generate 64-bit binaries:)
AFLAGS=-f elf64

# Linker (ld.lld, the one used internally by clang - calling it directly prevents linking the C standard lib):
LD=ld.lld

# Linker flags (none):
LDFLAGS=

# --------

# Targets to be specified when invoking `make`:

# Default target - just create the final binary:
all: $(BIN)

# Clenup all generated files:
# (The trailing `|| true` ensures that this command always succeeds,
# so make will not throw an error in case we invoked `make clean`
# with no build files present.)
clean:
	rm $(OBJECTS) $(BIN) || true

# --------

# Create the final binary by invoking the linker
# with the specified flags on the generated object file:
# (`$@` refers to the target of this rule, i. e. the name of the binary.)
$(BIN): $(OBJECTS)
	$(LD) $(LDFLAGS) -o $@ $^

# Create an object file from the corresponding assembly source file
# by invoking the assembler with the specified flags:
# (`$<` refers to the name of the first prerequisite, i. e. the source file.
# (It is generally a good habit to use this over `$^` for compiling/assembling,
# as these steps only ever process one input file,
# but we may later want to specify multiple dependencies for them to
# trigger recompilation, e. g. in case we alter a header file.))
%.o: %.asm
	$(ASM) $(AFLAGS) -o $@ $<

