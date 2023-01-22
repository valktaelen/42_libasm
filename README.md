# 42_libasm
Petite lib en assembleur x64 intel

`make`

## Mandatory part

Code basics function in asm

```c
ssize_t	ft_write(int fildes, const void *buf, size_t nbyte);	// man 2 write
ssize_t	ft_read(int fildes, void *buf, size_t nbyte);			// man 2 read
size_t	ft_strlen(const char *s);								// man 3 strlen
int		ft_strcmp(const char *s1, const char *s2);				// man 3 strcmp
char*	ft_stpcpy(char * dst, const char * src);				// man 3 strcpy
char*	ft_strdup(const char *s1);								// man 3 strdup
```

## Bonus part

```c
typedef struct	s_list
{
	void*			data;
	struct s_list*	next;
}				t_list;

void	ft_list_push_front(t_list **begin_list, void *data);
int		ft_list_size(t_list *begin_list);
void	ft_list_sort(t_list **begin_list, int (*cmp)());
void	ft_list_remove_if(t_list **begin_list, void *data_ref, int (*cmp)(), void (*free_fct)(void *));

int		ft_atoi_base(char *str, char *base);
```

`ft_list_push_front` allocate a new element of type `t_list` and add to the beginning of the list.

`ft_list_size` return the number of elements in the list.

`ft_list_sort` sorts the list elements by ascending order by comparing 2 elements by comparing their data with a function.

`ft_list_remove_if` removes from the list, all elements
whose data compared to data_ref using cmp, makes cmp return 0.

`ft_atoi_base` ASCII string to integer. If the base is not valid, return 0. A base isn't good if it size is less than 2, if it contain duplicates, if '+' or '-' are present. The number can start with n whitespaces followed by n '+' or '-' and ends by the number.

## Links

[Notes on x86-64 programming](https://www.lri.fr/~filliatr/ens/compil/x86-64.pdf)

[Le langage assembleur intel 64 bits](http://www.lacl.fr/tan/asm)
