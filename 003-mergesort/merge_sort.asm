SECTION .text

global merge_sort

; --------

merge_sort:
; Arguments:
; rdi: const int* array
; rsi: size_t size

; Check exit condition:
cmp rsi, 2
jb done

; Calculate half length(s):
mov rcx, rsi
shr rsi, 1
sub rcx, rsi

; Calculate start address of second half:
lea rdx, [rdi + rsi * 4]

; Save our parameters on stack:
push rdi
push rsi
push rdx
push rcx

; Sort first half:
call merge_sort

; Peek parameters for second half:
mov rdi, [rsp + 8]
mov rsi, [rsp]
; Sort second half:
call merge_sort

; Restore old parameters:
pop rcx
pop rdx
pop rsi
pop rdi

; Merge:
call merge

done:
; Return:
ret

; --------

merge:
; Arguments:
; rdi: const int* sorted array 0
; rsi: size_t size array 0
; rdx: const int* sorted array 1
; rcx: size_t size array 1

; Save total size in r10:
lea r10, [rsi + rcx]

compare_loop_start:

; Check exit condition 0:
cmp rcx, 0
je remaining_elements_all_in_array0

; Check exit condition 1:
cmp rsi, 0
je remaining_elements_all_in_array1

; Compare elements:

mov r8d, [rdi + rsi * 4 - 4]
mov r9d, [rdx + rcx * 4 - 4]
cmp r8d, r9d
jg half_0_greater

xchg r8d, r9d
inc rsi
dec rcx

half_0_greater:
push r8 ; we construct the merged array on the stack...
dec rsi

jmp compare_loop_start

remaining_elements_all_in_array0:
mov rdx, rdi
mov rcx, rsi
remaining_elements_all_in_array1:
; we have rcx many remaining elements, starting at rdx

; prepare registers for string instructions (source in rsi, count in rcx):
xchg rdx, rsi
lea rsi, [rsi + rcx * 4 - 4]
std ; array is already sorted correctly, so we push in reverse order

push_single_element_on_stack:
lodsd
push rax
loop push_single_element_on_stack

cld ; clear direction flag again

; copy tmp array from stack back to original rdi:

xchg rcx, r10 ; restore count in rcx (needed for string instructions)

copy_temp_array_from_stack:
pop rax
stosd

loop copy_temp_array_from_stack

ret

