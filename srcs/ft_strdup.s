global _ft_strdup
extern _ft_strlen
extern _ft_strcpy
extern _malloc
extern ___error

section .text

; char*	ft_strdup(const char *s1);
;							rdi

_ft_strdup:
	call _ft_strlen		; get size of s1
	inc rax				; increment size (\0) for allocation
	push rdi			; push s1
	mov rdi, rax		; param1 (rdi) = size to allocate
	call _malloc		; call malloc
	jc error_exit		; if error of allocation set errno and return
	mov rdi, rax		; param1 (rdi) = pointer allocate by malloc
	pop rsi				; param2 (rsi) = s1
	call _ft_strcpy		; copy s1 in new string
	ret					; return new string

error_exit:
	mov rdi, rax		; rdi = error
	call ___error		; rax = &errno
	mov [rax], rdi		; errno = error
	mov rax, 0			; return NULL
	ret
