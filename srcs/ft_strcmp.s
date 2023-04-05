global _ft_strcmp
global ft_strcmp

section .text

; int	ft_strcmp(const char *s1, const char *s2);
;							rdi				rsi

ft_strcmp:
	jmp _ft_strcmp

_ft_strcmp:
	xor rax, rax			; register rax = 0
	xor rcx, rcx			; register rcx = 0
	jmp iter				; go compare string

iter:
	mov al, BYTE [rdi]		; character of s1
	mov cl, BYTE [rsi]		; character of s2
	cmp al, cl				; compare 2 character
	;jne diff				; to return the diff (not only -1, 0, 1)
	jl inf					; if s1 < s2 return -1
	jg sup					; if s1 > s2 return 1
	cmp al, 0				; if s1 == \0
	je equal				;	return 0
	inc rdi					; ++s1
	inc rsi					; ++s2
	jmp iter				; pass to the next character

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
