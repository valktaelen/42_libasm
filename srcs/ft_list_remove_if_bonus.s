section	.text
global	_ft_list_remove_if
extern _t_list
extern _free

; void	ft_list_remove_if(t_list **rdi, void *rsi, int (*rdx)(), void (*rcx)(void*));
;								begin		ref		cpm(elem, ref)	free

_ft_list_remove_if:
	cmp rdi, 0
	je end
	


end:
	ret