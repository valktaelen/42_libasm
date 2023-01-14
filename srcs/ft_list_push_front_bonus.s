section	.text
global	_ft_list_push_front
extern _t_list
extern _malloc

; void	ft_list_push_front(t_list **rdi, void *rsi);

_ft_list_push_front:
	push rsp
	push rdi
	push rsi
	mov rdi, 16
	xor rax, rax
	call _malloc
	cmp rax, 0
	je return
	pop rsi
	mov [rax], rsi
	pop rdi
	mov rsi, [rdi]
	mov [rax + 8], rsi
	mov [rdi], rax
	pop rsp

return:
	ret
