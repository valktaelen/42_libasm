section	.text
global	_ft_atoi_base
global	ft_atoi_base
extern	_ft_strlen

; int		ft_atoi_base(char *str, char *base);
;								num			base

; Stack in prog
; TOP number, base, dimension, value, sign

ft_atoi_base:
	jmp _ft_atoi_base

_ft_atoi_base:
	cmp rdi, 0						; secure params
	je return
	cmp rsi, 0
	je return
	push rdi
	push rsi						; TOP base, num
	mov rdi, rsi
	xor rsi, rsi
	call check_base					; check_base(base) -> dimension
	cmp rax, 2
	jl return_error
	mov rcx, rax
	pop rsi
	pop rdi
	mov rax, 1						; sign
	push rax
	xor rax, rax					; value
	mov rax, 0
	push rax
	push rcx
	push rsi
	push rdi						; TOP number, base, dimension, value, sign
	jmp whitespace

whitespace:							; start iterate on whitespace
	xor rcx, rcx
	pop rdi
	mov cl, BYTE [rdi]
	push rdi
	cmp cl, 0
	je end
	cmp cl, 32					; ' '
	je whitespace_inc
	cmp cl, 9						; '\t'
	je whitespace_inc
	cmp cl, 10					; '\n'
	je whitespace_inc
	cmp cl, 13					; '\r'
	je whitespace_inc
	cmp cl, 11					; '\v'
	je whitespace_inc
	cmp cl, 12					; '\f'
	je whitespace_inc
	jmp sign

whitespace_inc:
	pop rdi
	inc rdi
	push rdi
	jmp whitespace

sign:								; iterate on + and -
	xor rcx, rcx
	pop rdi
	mov cl, BYTE [rdi]
	push rdi
	cmp cl, 0
	je end
	cmp cl, 43					; '+'
	je sign_inc
	cmp cl, 45					; '-'
	je change_sign
	jmp conv_iter

sign_inc:
	pop rdi
	inc rdi
	push rdi
	jmp sign

change_sign:						; TOP number, base, dimension, value, sign
	pop rdi
	pop rsi
	pop rdx
	pop r11
	pop rax
	neg eax
	push rax
	push r11
	push rdx
	push rsi
	push rdi
	jmp sign_inc

conv_iter:							; TOP number, base, dimension, value, sign
	xor rcx, rcx
	pop rdi
	mov cl, BYTE [rdi]
	inc rdi
	push rdi
	cmp cl, 0
	je end
	pop rdx
	pop rdi
	push rdi
	push rdx
	call digit
	cmp rax, -1
	je end
	pop rsi
	pop rdi
	pop rcx
	pop rdx
	imul rdx, rcx
	add rdx, rax
	push rdx
	push rcx
	push rdi
	push rsi
	jmp conv_iter

end:								; TOP number, base, dimension, value, sign
	pop rax
	pop rax
	pop rax
	pop rax
	pop rdi
	imul eax, edi
	ret

return_error:
	pop rax
	pop rax
	xor rax, rax
	ret

return:
	ret

digit:								; rdi (base), r15 [cl] (digit)
	xor rax, rax
	xor rdx, rdx
	jmp digit_iter

digit_iter:
	mov ch, BYTE [rdi + rax]
	cmp ch, 0
	je return_digit_error
	cmp ch, cl
	je return
	inc rax
	jmp digit_iter

return_digit_error:
	mov rax, -1
	ret

check_base:							; rdi base [check if the base is correct]
	xor rax, rax
	jmp check_base_iter

check_base_iter:
	xor rcx, rcx
	mov cl, BYTE [rdi + rax]
	cmp cl, 0
	je return
	cmp cl, 43					; '+'
	je return_base_error
	cmp cl, 45					; '-'
	je return_base_error
	cmp cl, 32					; ' '
	je return_base_error
	cmp cl, 9						; '\t'
	je return_base_error
	cmp cl, 10					; '\n'
	je return_base_error
	cmp cl, 13					; '\r'
	je return_base_error
	cmp cl, 11					; '\v'
	je return_base_error
	cmp cl, 12					; '\f'
	je return_base_error
	inc rax
	push rax
	mov rdx, rax
	call check_base_double
	pop rsi
	cmp rax, 0
	je return
	mov rax, rsi
	jmp check_base_iter

check_base_double:
	mov rax, 1
	cmp BYTE [rdi + rdx], 0
	je return
	cmp cl, BYTE [rdi + rdx]
	je return_base_error
	inc rdx
	jmp check_base_double


return_base_error:
	xor rax, rax
	ret
