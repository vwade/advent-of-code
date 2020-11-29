#include <sys/stat.h>
#include <unistd.h>
#include <fcntl.h>
#include <stdio.h>

int
main(void)
{
	int			fd;
	char		buf;
	unsigned	result;

	result = 0;
	fd = open("input", O_RDONLY);
	while (read(fd, &buf, 1) > 0)
	{
		result += buf == '('; 
		result -= buf == ')'; 
	}
	printf("%u\n", result);
}