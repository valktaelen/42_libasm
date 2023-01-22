section	.text
global	_ft_list_size
extern _t_list

; int	ft_list_size(t_list *begin_list);
;							rdi

_ft_list_size:
	xor rax, rax			; register rax = 0 (size)
	jmp iter				; iterate on list

iter:
	cmp rdi, 0				; if (pointer == NULL)
	je return				;	return size
	inc rax					; ++size
	mov rdi, [rdi + 8]		; lst = lst->next
	jmp iter				; do next

return:
	ret
