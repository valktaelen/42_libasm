global _ft_strcpy

section .text

; char*	ft_strcpy(char * rdi, const char * rsi);

_ft_strcpy:
	xor rax, rax
	xor rcx, rcx
	jmp iter

iter:
	mov cl, [rsi + rax]
	mov [rdi + rax], cl
	cmp cl, 0
	je return
	inc rax
	jmp iter

return:
	mov rax, rdi
	ret
