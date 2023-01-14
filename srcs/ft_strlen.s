global _ft_strlen

section .text

; size_t	ft_strlen(const char *rdi);

_ft_strlen:
	xor rax, rax
	jmp iter

iter:
	cmp BYTE [rdi + rax], 0
	je return
	inc rax
	jmp iter

return:
	ret
