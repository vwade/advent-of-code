#include <sys/stat.h>
#include <unistd.h>
#include <fcntl.h>
#include <stdio.h>

int
main(void)
{
	int			fd;
	char		buf;
	unsigned	result, i;

	i = 0;
	result = 0;
	fd = open("input", O_RDONLY);
	while (read(fd, &buf, 1) > 0)
	{
        i++;
		result += buf == '('; 
		result -= buf == ')';
        if (result == -1)
            printf("%u @%u\n", i, result);
        if (result == -1)
            break ;
	}
}