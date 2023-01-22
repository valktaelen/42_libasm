global _ft_strlen

section .text

; size_t	ft_strlen(const char *s);
;							rdi

_ft_strlen:
	xor rax, rax				; register rax = 0 (index)
	jmp iter					; iterate

iter:
	cmp BYTE [rdi + rax], 0		; compare character to \0
	je return					; if character == \0 return
	inc rax						; increment index
	jmp iter					; compare next character

return:
	ret
