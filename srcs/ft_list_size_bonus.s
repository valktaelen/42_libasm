section	.text
global	_ft_list_size
extern _t_list

; int	ft_list_size(t_list *rdi);

_ft_list_size:
	xor rax, rax
	jmp iter

iter:
	cmp rdi, 0
	je return
	inc rax
	mov rdi, [rdi + 8]
	jmp iter

return:
	ret
