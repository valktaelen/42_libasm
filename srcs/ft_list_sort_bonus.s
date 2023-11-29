%include "ft_list_struct_bonus.s"
section	.text
global	_ft_list_sort
global	ft_list_sort
extern _t_list

; void	ft_list_sort(t_list **begin_list, int (*cmp)());
;								rdi				rsi

ft_list_sort:
	jmp _ft_list_sort

_ft_list_sort:
	cmp rdi, 0
	je end
	cmp rsi, 0
	je end
	push rdi			; begin
	push rsi			; cmp
	mov rdi, [rdi + data]
	push rdi			; first / current

iter:
	pop rcx				; current
	pop rax				; cmp
	pop rsi				; begin
	cmp rcx, 0
	je end
	mov rdi, [rcx + next]
	cmp rdi, 0
	je end
	push rsi			; begin
	push rax			; cmp
	mov rdi, [rcx + data]		; current->data
	mov rsi, [rcx + next]	; next
	push rcx			; current
	push rsi			; next
	mov rsi, [rsi + data]		; next->data
	call rax			; cmp
	cmp rax, 1
	je sort
	jmp next_node

sort:
	pop rax				; next
	pop rcx				; current
	mov r11, [rcx + data]		; current->data (tmp)
	mov rdi, [rax + data]
	mov [rcx + data], rdi		; current->data = next->data
	mov [rax + data], r11		; next->data = current->data (tmp)
	pop rax				; cmp
	pop r11				; begin
	mov rcx, [r11 + data]
	push r11
	push rax
	push rcx
	jmp iter

next_node:
	pop rax				; next
	pop rcx				; current
	push rax			; current = next
	jmp iter

end:
	ret
