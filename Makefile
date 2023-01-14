# Common

DIR_OBJ		:=	objs
DIR_SRCS	:=	srcs

# Mandatory

NAME		:=	libasm.a
SRCS_FILES	:=	ft_write.s	\
				ft_read.s	\
				ft_strlen.s	\
				ft_strcmp.s	\
				ft_strcpy.s	\
				ft_strdup.s
SRCS		:=	$(addprefix $(DIR_SRCS)/, $(SRCS_FILES))
OBJS		:=	$(addprefix $(DIR_OBJ)/, $(SRCS_FILES:.s=.o))

# Bonus

NAME_BONUS			:=	libasm.a
SRCS_FILES_BONUS	:=	$(SRCS_FILES)				\
						ft_list_struct.s			\
						ft_list_size_bonus.s		\
						ft_list_push_front_bonus.s	\
						ft_list_remove_if_bonus.s	\
						ft_list_sort_bonus.s		\
						ft_atoi_base_bonus.s
SRCS_BONUS		:=	$(addprefix $(DIR_SRCS)/, $(SRCS_FILES_BONUS))
OBJS_BONUS		:=	$(addprefix $(DIR_OBJ)/, $(SRCS_FILES_BONUS:.s=.o))

# Tests

SRCS_TEST	:=	srcs/test.c
OBJS_TEST	:=	$(SRCS_TEST:.c=.o)

# FLAGS

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

# Rules

all:	$(NAME)

bonus:	$(NAME_BONUS)

test: $(NAME_BONUS) $(OBJS_TEST)
	gcc -Wall -Werror -Wextra $(DEBUG_TEST)  $(NAME_BONUS) $(OBJS_TEST) -o test

$(DIR_OBJ):
	mkdir -p $(DIR_OBJ)

$(NAME):	$(DIR_OBJ)	$(OBJS)
	ar rc $(NAME) $(OBJS)

$(NAME_BONUS):	$(DIR_OBJ)	$(OBJS_BONUS)
	ar rc $(NAME_BONUS) $(OBJS_BONUS)

%.o:	%.c	Makefile
	gcc -Wall -Werror -Wextra $(DEBUG_TEST) -c $< -o $@

$(DIR_OBJ)/%.o:	$(DIR_SRCS)/%.s	Makefile
	$(ASM_C) $< -o $@

clean:
	rm -rf $(DIR_OBJ) $(OBJS_TEST)

fclean:	clean
	rm -rf $(NAME) test
