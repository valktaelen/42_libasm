section	.text
global	ft_list_remove_if
extern	FREE

_ft_list_remove_if:
ft_list_remove_if:
	push	rbp
	push	rbx
	push	r12
	mov		r12, [rdi]
	xor		rbx, rbx
	cmp		rdi, 0
	jz		return
	cmp		rdx, 0
	jz		return
	cmp		rcx, 0
	jz		return
	jmp		compare_start
free_elt:
	mov		r8, [rdi]
	mov		rbp, [r8 + 8]
	push	rsi
	push	rdx
	push	rcx
	push	rdi
	mov		rdx, [rdi]
	mov		rdi, [rdx]
	call	rcx
	pop		rdi
	push	rdi
	mov		rdx, [rdi]
	mov		rdi, rdx
	call	FREE	wrt ..plt
	pop		rdi
	pop		rcx
	pop		rdx
	pop		rsi
	mov		[rdi], rbp
	cmp		rbx, 0
	jnz		set_previous_next
	mov		r12, rbp
	jmp		compare_start
set_previous_next:
	mov		[rbx + 8], rbp
	jmp		compare_start
compare_null:
	xor		rdi, rsi
	mov		rax, rdi
	jmp		compare_end
move_next:
	mov		rbx, [rdi]
	mov		r8,	[rbx + 8]
	mov		[rdi], r8
compare_start:
	cmp		QWORD [rdi], 0
	jz		return
	push	rdi
	push	rsi
	push	rdx
	push	rcx
	mov		r8, [rdi]
	mov		rdi, [r8]
	cmp		rdi, 0
	jz		compare_null
	call	rdx
compare_end:
	pop		rcx
	pop		rdx
	pop		rsi
	pop		rdi
	cmp		rax, 0
	jz		free_elt
	jmp		move_next
return:
	mov		[rdi], r12
	pop		r12
	pop		rbx
	pop		rbp
	ret
