%include "ft_list_struct_bonus.s"
section	.text
global	_ft_list_push_front
global	ft_list_push_front
extern _t_list
extern MALLOC

; void	ft_list_push_front(t_list **begin_list, void *data);
;									rdi				rsi

ft_list_push_front:
	jmp _ft_list_push_front

_ft_list_push_front:
    cmp rdi, 0                  ; if (begin_list == NULL)
    je exit                     ;   jump exit
	push rsp				; push stack pointer
	push rdi				; push begin
	push rsi				; push data
	mov rdi, 16				; param1 (rdi) = size to allocate = 16 = 2 * 8 bytes
	xor rax, rax
	call MALLOC	wrt ..plt		; call malloc
	cmp rax, 0				; if error
	jz return				;	return
	pop rsi					; pop data
	mov [rax + data], rsi			; new->data = data
	pop rdi					; pop begin
	mov rsi, [rdi]			; tmp = *begin
	mov [rax + next], rsi		; new->next = tmp
	mov [rdi], rax			; *begin = new
	pop rsp					; pop stack pointer
	ret

return:						; pop all and return
	pop rdi
	pop rdi
	pop rsp
	ret

exit:
	ret
