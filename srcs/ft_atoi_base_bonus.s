section	.text
global	_ft_atoi_base
extern	_ft_strlen

; int	ft_atoi_base(char const *rdi, char const *rsi);
;								num				base

_ft_atoi_base:
	cmp rdi, 0
	je return
	cmp rsi, 0
	je return
	push rsi
	push rdi			; # TOP #  number (string) | base (string)
	mov rdi, rsi
	call check_base		; check_base(base)
	mov rdi, rax
	cmp rax, 0
	jne convert
	pop rdi
	pop rsi
	jmp return

convert:
	pop rdi 			; number (string)
	pop rcx				; base (string)
	mov rsi, 1
	push rsi			; sign
	push rax			; baseDim
	xor rax, rax
	push rax			; # TOP #  number (string) | base (string) | number | base (dim) | sign
	push rcx			; base
	push rdi
	jmp begin

begin:
	pop rdi
	push rdi
	mov sil, BYTE [rdi]
	cmp sil, 0
	je end_convert
	cmp sil, 43					; '+'
	je begin
	cmp sil, 45					; '-'
	je change_sign
	cmp sil, 32					; ' '
	je convert_next
	cmp sil, 9					; '\t'
	je convert_next
	cmp sil, 10					; '\n'
	je convert_next
	cmp sil, 13					; '\r'
	je convert_next
	cmp sil, 11					; '\v'
	je convert_next
	cmp sil, 12					; '\f'
	je convert_next
	jmp convert_iter

convert_next:
	pop rdi
	inc rdi
	push rdi
	jmp begin

change_sign:	; # TOP #  number (string) | base (string) | number | base (dim) | sign
	pop r11
	pop r12
	pop r13
	pop r14
	pop r15
	inc r11
	neg r15
	push r15
	push r14
	push r13
	push r12
	push r11
	jmp begin

convert_iter:	; # TOP #  number (string) | base (string) | number | base (dim) | sign
	pop rcx				; number (string)
	pop rdi				; base (string)
	mov sil, BYTE [rcx]	; digit
	inc rcx
	push rdi
	push rcx
	call get_pos_base	; get_pos_base(base, val (sil))
	cmp rax, -1
	je end_convert
	mov r12, rax
	pop rcx				; number (string)
	pop rdi				; base (string)
	pop rax				; number
	pop rsi				; base
	imul rax, rsi		; n * base
	add rax, r11		; n + i
	push rsi
	push rax
	push rdi
	inc rcx
	push rcx
	jmp convert_iter

end_convert:
	pop rax
	pop rax
	pop rax
	pop rdi
	pop rdi
	;imul rax, rdi
	ret

return:
	ret

; Pos in base

get_pos_base: ; get_pos_base(base, val (sil))
	xor rax, rax
	jmp get_pos_base_iter

get_pos_base_iter:	; rdi base, sil val
	cmp BYTE [rdi + rax], 0
	je get_pos_base_error
	cmp BYTE [rdi + rax], sil
	je return
	inc rax
	jmp get_pos_base_iter

get_pos_base_error:
	mov rax, -1
	ret

; Check base

check_base:	; check_base(base)
	xor rax, rax
	jmp iter_base

iter_base:
	mov sil, BYTE [rdi + rax]
	cmp sil, 0
	je return_base
	cmp sil, 43					; '+'
	je return_base_error
	cmp sil, 45					; '-'
	je return_base_error
	cmp sil, 32					; ' '
	je return_base_error
	cmp sil, 9					; '\t'
	je return_base_error
	cmp sil, 10					; '\n'
	je return_base_error
	cmp sil, 13					; '\r'
	je return_base_error
	cmp sil, 11					; '\v'
	je return_base_error
	cmp sil, 12					; '\f'
	je return_base_error
	mov rsi, rax
	push rax
	mov rdx, rax				; rdx = i
	call check_base_unique
	cmp rax, 0
	pop rax
	je return_base_error
	inc rax
	jmp iter_base

check_base_unique:
	mov rax, rdx
	jmp check_base_unique_iter

check_base_unique_iter: ; rax i, rdi base, sil char
	inc rax
	mov bl, BYTE [rdi + rax]
	cmp bl, 0
	je return_base
	cmp bl, sil
	je return_base_error
	jmp check_base_unique_iter

return_base:
	cmp rax, 2
	jl return_base_error
	ret

return_base_error:
	xor rax, rax
	ret
