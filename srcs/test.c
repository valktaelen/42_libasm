#include <unistd.h>
#include <errno.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

ssize_t	ft_write(int fildes, const void *buf, size_t nbyte);

void test_write_asm(int fildes, const void *buf, size_t nbyte) {
	errno = 0;
	printf("code: %zd\n", ft_write(fildes, buf, nbyte));
	perror(buf);
	printf("errno code: %d\n\n", errno);
}

void test_write_std(int fildes, const void *buf, size_t nbyte) {
	errno = 0;
	printf("code: %zd\n", write(fildes, buf, nbyte));
	perror(buf);
	printf("errno code: %d\n\n", errno);
}

void test_write(int fildes, const void *buf, size_t nbyte) {
	ft_write(2, "########################################################\n", 58);
	ft_write(2, "asm:\n", 6);
	test_write_asm(fildes, buf, nbyte);
	ft_write(2, "std:\n", 6);
	test_write_std(fildes, buf, nbyte);
	ft_write(2, "########################################################\n", 58);
}

ssize_t	ft_read(int fildes, void *buf, size_t nbyte);

void test_read_asm(int fildes, void *buf, size_t nbyte) {
	errno = 0;
	printf("code: %zd\n", ft_read(fildes, buf, nbyte));
	perror(buf);
	printf("errno code: %d\n\n", errno);
}

void test_read_std(int fildes, void *buf, size_t nbyte) {
	errno = 0;
	printf("code: %zd\n", read(fildes, buf, nbyte));
	perror(buf);
	printf("errno code: %d\n\n", errno);
}

void test_read(int fildes, void *buf, size_t nbyte) {
	ft_write(2, "########################################################\n", 58);
	ft_write(2, "asm:\n", 6);
	test_read_asm(fildes, buf, nbyte);
	ft_write(2, "std:\n", 6);
	test_read_std(fildes, buf, nbyte);
	ft_write(2, "########################################################\n", 58);
}
typedef struct s_list
{
void *data;
struct s_list *next;
} t_list;
void	ft_list_remove_if(t_list **rdi, void *rsi, int (*rdx)(), void (*rcx)(void*));
int cmp(char *t1, char* t2) {return *t1 == *t2;}
int		ft_atoi_base(char const *str, char const *base);
int main() {
	/*printf("######################################################## write\n");

	test_write(-1, "Test 1", 8);
	test_write(1, "Test 2", 7);
	test_write(10, "Test 3", 7);
	test_write(429496729, "Test 4", 7);
	test_write(1, "Test 5", 0);

	printf("######################################################## read\n");
	char	buf[50];

	sprintf(buf, "%s", "Test 1");
	test_read(-1, buf, 8);

	sprintf(buf, "%s", "Test 2");
	test_read(0, buf, 7);

	sprintf(buf, "%s", "Test 3");
	test_read(1, buf, 7);

	sprintf(buf, "%s", "Test 4");
	test_read(429496729, buf, 7);

	sprintf(buf, "%s", "Test 5");
	test_read(1, buf, 0);

	sprintf(buf, "%s", "Test 6");
	test_read(0, buf, 4);

	printf("%d\n", strcmp("Tripouille", "tripouille"));*/
	printf("%d\n", (ft_atoi_base("11", "01")));

}