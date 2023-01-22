extern ___error
global _ft_read

section .text

;ssize_t	ft_read(int fildes, void *buf, size_t nbyte);
;						rdi		rsi				rcx

_ft_read:
	mov	rax, 0x2000003	; read
	syscall				; call read
	jc	error_exit		; if (CF == 1) then set errno
	ret					; return len

error_exit: ; if error
	mov rdi, rax		; Value of errno in rdi
	call ___error		; rax = &errno
	mov [rax], rdi		; *rax = rdi (set errno)
	mov rax, -1			; rax = -1 = error of read
	ret					; return -1 = rax
