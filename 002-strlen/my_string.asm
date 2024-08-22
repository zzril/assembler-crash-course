SECTION .text

global my_strlen
; Exposing the `my_strlen` label in the object file,
; so other compilation units can refer to it
; (and thus call this function).

my_strlen:
; Arguments:
; rdi: const char* s
; Returns:
; rax: length of s

    mov rax, -1             ; Initialize counter with -1.
                            ; (So, it will be 0 in the first iteration.)

loop_start:
    inc rax                 ; Increase counter by 1.
    cmp byte [rdi + rax], 0 ; Check if the next byte in our string
                            ; is the null-terminator.
    jnz loop_start          ; If not, start next iteration.

    ; We're done:
    ret                     ; Return counter in rax.

