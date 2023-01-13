global _ft_strcmp

section .text

; int	strcmp(const char *s1, const char *s2);

_ft_strcmp:
	xor rax, rax
	xor rcx, rcx
	jmp iter

iter:
	mov al, BYTE [rdi]
	mov cl, BYTE [rsi]
	cmp al, cl
	;jne diff
	jl inf
	jg sup
	cmp al, 0
	je equal
	inc rdi
	inc rsi
	jmp iter

equal:
	mov rax, 0
	ret

inf:
	mov rax, -1
	ret

sup:
	mov rax, 1
	ret
diff:
	sub al, cl
	ret
