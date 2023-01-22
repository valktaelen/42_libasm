global _ft_strdup
extern _ft_strlen
extern ___error
extern _malloc
extern _ft_strcpy

section .text

; char*	ft_strdup(const char *rdi);

_ft_strdup:
	call _ft_strlen
	inc rax
	push rdi
	mov rdi, rax
	call _malloc
	jc error_exit
	mov rdi, rax
	pop rsi
	call _ft_strcpy
	ret

error_exit:
	mov rdi, rax
	call ___error
	mov [rax], rdi
	mov rax, 0
	ret
