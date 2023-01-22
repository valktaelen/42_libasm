extern ___error
global _ft_write

section .text

;ssize_t	ft_write(int fildes, const void *buf, size_t nbyte);
;						rdi				rsi				rcx


_ft_write:
	mov	rax, 0x2000004	; write
	syscall				; call write
	jc	error_exit		; if (CF == 1) then set errno
	ret					; return len

error_exit: ; if error
	mov rdi, rax		; Value of errno in rdi
	call ___error		; rax = &errno
	mov [rax], rdi		; *rax = rdi (set errno)
	mov rax, -1			; rax = -1 = error of write
	ret					; return -1 = rax
