SECTION .rodata
; Section for read-only variables.

hello_world:
db "Hello, world!", 0xa
; "Define bytes" for the string `Hello, world!`,
; followed by a newline (ASCII 0x0a).
; (No need to null-terminate the string, as we're
; not using the string manipulation functions
; from the C standard lib.)

hello_len: equ $ - hello_world
; This calculates the difference between
; the "current" address and the hello_world label,
; effectively giving us the length of the string.

SECTION .text

global _start

_start:

; Prepare and execute the write syscall:

mov rax, 1           ; Syscall code for sys_write
mov edi, 1           ; 1st argument for sys_write: unsigned int fd
                     ; (The file descriptor to write to,
                     ; in our case stdout (1).)

mov rsi, hello_world ; 2nd argument for sys_write: const char* buf
                     ; (The address of the buffer containing the bytes
                     ; we want to write.)

mov rdx, hello_len   ; 3rd argument for sys_write: size_t count
                     ; (The length of the buffer /
                     ; amount of bytes to write.)

syscall              ; Execute the write syscall,
                     ; potentially returning an error code in rax.

; Exit:

mov edi, 0           ; Use exit code 0 (success) by default.

cmp rax, 0           ; Check if sys_write returned an error code
                     ; (any negative number).
setl dil             ; Set the low byte of edi to 1,
                     ; if the return value was less than zero
                     ; (effectively setting the to-be-returned
                     ; exit code in `edi` to 1 (failure)).

mov rax, 60          ; sys_exit
syscall

