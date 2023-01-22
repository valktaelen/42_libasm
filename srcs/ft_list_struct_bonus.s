;typedef struct	s_list
;{
;	void *data;
;	struct s_list *next;
;}				t_list;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
struc	_t_list
	data:	resq	1	; 1 pointer = 1 quad	[+0[bytes]]
	next:	resq	1	; 1 pointer = 1 quad	[+8[bytes]]
endstruc
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
