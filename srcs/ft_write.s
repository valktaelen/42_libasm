
section .text
extern ERRNO
global ft_write
global _ft_write

;ssize_t	ft_write(int fildes, const void *buf, size_t nbyte);
;						rdi				rsi				rcx

ft_write:
	jmp _ft_write
	
_ft_write:
	mov	rax, SYS_WRITE	; write
	syscall				; call write
	test rax, rax		; rax & rax
	js	error_exit		; if (SF == 1 (rax < 0)) then set errno
	ret					; return len

error_exit: ; if error
	neg rax
	; mov rdi, rax		; Value of errno in rdi
	push rax
	call ERRNO	wrt ..plt	; rax = &errno
	pop rdi
	mov [rax], rdi		; *rax = rdi (set errno)
	mov rax, -1			; rax = -1 = error of write
	ret					; return -1 = rax
