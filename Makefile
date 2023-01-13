NAME		:=	libasm.a
DIR_OBJ		:=	objs
DIR_SRCS	:=	srcs
SRCS_FILES	:=	\
				ft_write.s	\
				ft_read.s	\
				ft_strlen.s	\
				ft_strcmp.s	\
				ft_strcpy.s	\
#				ft_strdup.s	\
#				_test.s	\

SRCS		:=	$(addprefix $(DIR_SRCS)/, $(SRCS_FILES))
OBJS		:=	$(addprefix $(DIR_OBJ)/, $(SRCS_FILES:.s=.o))

SRCS_TEST	:=	srcs/test.c
OBJS_TEST	:=	$(SRCS_TEST:.c=.o)

DEBUG		:=	-g
DEBUG_TEST	:=	-fsanitize=address -g3

UNAME_S := $(shell uname -s)
	ifeq ($(UNAME_S),Linux)
		ASM_FORMAT	:=	elf
	endif
	ifeq ($(UNAME_S),Darwin)
		ASM_FORMAT	:=	macho64
	endif
ASM_C		:=	nasm -f $(ASM_FORMAT) $(DEBUG)



all:	$(NAME)

test: $(NAME) $(OBJS_TEST)
	gcc -Wall -Werror -Wextra $(DEBUG_TEST)  $(NAME) $(OBJS_TEST) -o test

$(DIR_OBJ):
	mkdir -p $(DIR_OBJ)

$(NAME):	$(DIR_OBJ)	$(OBJS)
	ar rc $(NAME) $(OBJS)

%.o:	%.c	Makefile
	gcc -Wall -Werror -Wextra $(DEBUG_TEST) -c $< -o $@

$(DIR_OBJ)/%.o:	$(DIR_SRCS)/%.s	Makefile
	$(ASM_C) $< -o $@

clean:
	rm -rf $(DIR_OBJ) $(OBJS_TEST)

fclean:	clean
	rm -rf $(NAME) test
