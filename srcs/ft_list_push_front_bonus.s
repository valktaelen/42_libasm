section	.text
global	_ft_list_push_front
extern _t_list
extern _malloc

; void	ft_list_push_front(t_list **begin_list, void *data);
;									rdi				rsi

_ft_list_push_front:
	push rsp				; push stack pointer
	push rdi				; push begin
	push rsi				; push data
	mov rdi, 16				; param1 (rdi) = size to allocate = 16 = 2 * 8 bytes
	xor rax, rax
	call _malloc			; call malloc
	cmp rax, 0				; if error
	je return				;	return
	pop rsi					; pop data
	mov [rax], rsi			; new->data = data
	pop rdi					; pop begin
	mov rsi, [rdi]			; tmp = *begin
	mov [rax + 8], rsi		; new->next = tmp
	mov [rdi], rax			; *begin = new
	pop rsp					; pop stack pointer
	ret

return:						; pop all and return
	pop rdi
	pop rdi
	pop rsp
	ret
