NAME		:=	libasm.a
DIR_OBJ		:=	objs
DIR_SRCS	:=	srcs
SRCS_FILES	:=	\
				_test.s	\
#				ft_write.s	\
#				ft_strlen.s	\
#				ft_read.s	\
#				ft_strcmp.s	\
#				ft_strcpy.s	\
#				ft_strdup.s	\

SRCS		:=	$(addprefix $(DIR_SRCS)/, $(SRCS_FILES))
OBJS		:=	$(addprefix $(DIR_OBJ)/, $(SRCS_FILES:.s=.o))
#DEBUG		:=	-g

UNAME_S := $(shell uname -s)
	ifeq ($(UNAME_S),Linux)
		ASM_FORMAT	:=	elf
	endif
	ifeq ($(UNAME_S),Darwin)
		ASM_FORMAT	:=	macho64
	endif
ASM_C		:=	nasm -f $(ASM_FORMAT) $(DEBUG)


all:	$(NAME)

$(DIR_OBJ):
	mkdir -p $(DIR_OBJ)

$(NAME):	$(DIR_OBJ)	$(OBJS)
	ar rc $(NAME) $(OBJS)

$(DIR_OBJ)/%.o:	$(DIR_SRCS)/%.s
	$(ASM_C) $< -o $@

clean:
	rm -rf $(DIR_OBJ)

fclean:	clean
	rm -rf $(NAME)
