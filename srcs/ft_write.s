extern ___error
global _ft_write

section .text

; ssize_t ft_write(int rdi, void *rsi, size_t rcx);
_ft_write:
	mov	rax, 0x2000004	; write
	syscall				; call write
	jc	error_exit		; retenu a 1 (CF == 1) alors set errno
	ret					; return len

error_exit: ; en cas d'erreur
	mov rdi, rax	; On stock le retour de l'appel system dans un tmp rdi = rax
	xor rax, rax	; rax = 0 (non necessaire)
	call ___error	; rax = &errno
	mov [rax], rdi	; *rax = rdi (retour d'erreur de l'appel system)
	mov rax, -1		; rax = -1 = error de write
	ret				; return -1 = rax
