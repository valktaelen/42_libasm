global _ft_strcpy
global ft_strcpy

section .text

; char*	ft_stpcpy(char * dst, const char * src);
;						rdi				rsi

ft_strcpy:
	jmp _ft_strcpy

_ft_strcpy:
	xor rax, rax			; register rax = 0 (index)
	xor rcx, rcx			; register rcx = 0
	jmp iter				; go copy string

iter:
	mov cl, [rsi + rax]		; character of src to copy
	mov [rdi + rax], cl		; copy character
	cmp cl, 0				; if character is \0
	je return				;	return dst
	inc rax					; increment index
	jmp iter				; copy next

return:						; return dst
	mov rax, rdi
	ret
