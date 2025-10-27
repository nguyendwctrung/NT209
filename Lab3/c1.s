.section .data
	prompt: .string "Enter a number (5 digits): "
	len = . - prompt

	msg_valid: .string "Doi xung"
	msg_valid_len = . - msg_valid

	msg_invalid: .string "Khong doi xung"
	msg_invalid_len= . - msg_invalid

.section .bss
	.lcomm input, 6

.section .text
	.globl _start

_start:
	movl $4, %eax
	movl $1, %ebx
	movl $prompt, %ecx
	movl $len, %edx
	int $0x80

	movl $3, %eax
	movl $0, %ebx
	movl $input, %ecx
	movl $6, %edx
	int $0x80

	movl $input, %eax

	mov 0(%eax), %bl
	mov 4(%eax), %cl
	cmp %bl, %cl
	jne ifInvalid

	mov 1(%eax), %bl
	mov 3(%eax), %cl
	cmp %bl, %cl
	jne ifInvalid

	movl $4, %eax
	movl $1, %ebx
	movl $msg_valid, %ecx
	movl $msg_valid_len, %edx
	int $0x80

	jmp EXIT

ifInvalid:
	movl $4, %eax
	movl $1, %ebx
	movl $msg_invalid, %ecx
	movl $msg_invalid_len, %edx
	int $0x80

EXIT:
	movl $1, %eax
	int $0x80
