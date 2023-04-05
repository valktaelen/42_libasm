extern ERRNO
global _ft_read
global ft_read

section .text

;ssize_t	ft_read(int fildes, void *buf, size_t nbyte);
;						rdi		rsi				rcx

ft_read:
	jmp _ft_read

_ft_read:
	mov	rax, SYS_READ	; read
	syscall				; call read
	test rax, rax
	js	error_exit		; if (SF == 1 (rax < 0)) then set errno
	ret					; return len

error_exit: ; if error
	neg rax
	;mov rdi, rax		; Value of errno in rdi
	push rax
	call ERRNO wrt ..plt		; rax = &errno
	pop rdi
	mov [rax], rdi		; *rax = rdi (set errno)
	mov rax, -1			; rax = -1 = error of read
	ret					; return -1 = rax
