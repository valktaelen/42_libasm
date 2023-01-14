section	.text
global	_ft_list_sort
extern _t_list

; void	ft_list_sort(t_list **begin_list,int (*cmp)());

_ft_list_sort:
	cmp rdi, 0
	je end
	cmp rsi, 0
	je end
	push rdi			; begin
	push rsi			; cmp
	mov rdi, [rdi]
	push rdi			; first / current

iter:
	pop rcx				; current
	pop rax				; cmp
	pop r11				; begin
	cmp rcx, 0
	je end
	mov rdi, [rcx + 8]
	cmp rdi, 0
	je end
	push r11			; begin
	push rax			; cmp
	mov rdi, [rcx]		; current->data
	mov rsi, [rcx + 8]	; next
	push rcx			; current
	push rsi			; next
	mov rsi, [rsi]		; next->data
	call rax			; cmp
	cmp rax, 1
	je sort
	jmp next

sort:
	pop rax			; next
	pop rcx			; current
	mov r11, [rcx]	; current->data (tmp)
	mov [rcx], rdi	; current->data = next->data
	mov [rax], r11	; next->data = current->data (tmp)
	pop rax			; cmp
	pop r11			; begin
	mov rcx, [r11]
	push r11
	push rax
	push rcx
	jmp iter

next:
	pop rax			; next
	pop rcx			; current
	push rax		; current = next
	jmp iter

end:
	ret
