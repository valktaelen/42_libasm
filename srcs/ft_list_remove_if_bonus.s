section	.text
global	_ft_list_remove_if
extern _t_list
extern _free

; void	ft_list_remove_if(t_list **rdi, void *rsi, int (*rdx)(), void (*rcx)(void*));
;								begin		ref		cpm(elem, ref)	free

_ft_list_remove_if:
	cmp rdi, 0			; secure params
	je end
	cmp rsi, 0
	je end
	cmp rdx, 0
	je end
	cmp rcx, 0
	je end
	xor rax, rax
	push rcx			; save free
	push rdx			; save cmp
	push rsi			; save ref
	push rdi			; save begin
	push rax			; push old struct (NULL)
	mov rax, [rdi]		; rax = struct*
	push rax			; push current struct
	jmp iter			; iterate

iter:
	pop r13				; current val
	pop r12				; old val
	pop r8				; begin
	pop r9				; ref
	pop r10				; cmp
	pop r11				; free
	cmp r13, 0			; struct* == NULL
	je end					; return
	push r11			; free
	push r10			; cmp
	push r9				; ref
	push r8				; begin
	push r12			; push old val
	push r13			; push current val
	mov rdi, r9			; param1 = ref
	mov rsi, [r13]		; param2 = struct->data
	call r10
	cmp rax, 0
	je remove
	pop r13				; current val
	pop r12				; old val
	mov r12, r13
	mov r13, [r13 + 8]
	push r12			; push old val
	push r13			; push current val
	jmp iter

remove:
	pop r13				; current val
	pop r12				; old val
	pop r8				; begin
	push r8				; begin
	push r12			; push old val
	push r13			; push current val
	cmp r12, 0			; old == NULL
	je removeStart			; rm at begin
	push r13			; toDelete
	mov r13, [r13 + 8]	; current = current->next
	mov [r12 + 8], r13	; old->next = current
	pop r15
	pop r11
	pop r14
	push r12
	push r13
	push r15
	jmp removeNode

;	Entry:
;	Stack		Type		Use
;	TOP
;	current		node*
;	old			node*
;	END
;	Exit:
;	Stack		Type		Use
;	TOP
;	toDelete	node*		Create
;	current		node*		Modify
;	old			node*		N
;	END
removeStart:
	pop r13				; current
	mov rdi, r13		; toDelete
	mov r13, [r13 + 8]	; next
	mov [r8], r13		; start = current
	push r13			; new current
	push rdi			; toDelete
	jmp removeNode


;	Entry:
;	Stack		Type		Use
;	TOP
;	toDelete	node*		Y
;	current		node*		N
;	old			node*		N
;	END
;	Exit:
;	Stack		Type		Use
;	TOP
;	current		node*		N
;	old			node*		N
;	END

removeNode:
	pop rdi				; get	toDelete
	pop r13				; current val
	pop r12				; old val
	pop r8				; begin
	pop r9				; ref
	pop r10				; cmp
	pop r11				; free
	push r11			; free
	push r10			; cmp
	push r9				; ref
	push r8				; begin
	push r12			; push old val
	push r13			; push current val
	push rdi			; save	toDelete
	mov rdi, [rdi]		; toDelete.data
	call r11			; free(toDelete.data)
	pop rdi				; toDelete
	xor rcx, rcx
	push rsp
	call _free			; free(rdi)				Why !!!! free data but not node, why not !!!
	pop rsp
	jmp iter

end:
	ret
