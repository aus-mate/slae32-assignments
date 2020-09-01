; Filename:	decrypter.nasm
; Author:	aus-mate
; Purpose:	This code was written for assignment #7 of the SecurityTube Linux Assembly Expert certification.
; Student ID:	SLAE-1555

global _start

section .text

_start:

	;void rc4_init(unsigned char *key, unsigned int key_length) {
    	;	for (i = 0; i < 256; i++)
  	;      		S[i] = i;
 	;
    	;	for (i = j = 0; i < 256; i++) {
        ;		j = (j + key[i % key_length] + S[i]) & 255;
        ;		swap(S, i, j);
    	;	}
    	;	i = j = 0;
	;}

	; edi point to S array
	; ebx will be j
	; ecx will be a counter
	; edx is i

	
	xor ecx, ecx		; clear ecx
	mov cl, 0xff		; store 256 in ecx for loop
	inc ecx
	xor edx, edx		; clear edx
	mov edi, esp		; point edi at the S array
	dec ebx
s_arr:	
	mov byte[esp-1], dl	; push bytes onto the stack to populate S array
	dec esp			; adjust stack
	inc edx			; increment edx
	loop s_arr		; loop for (i = 0; i < 256; i++)
	mov ecx, edx		; move 256 into ecx for next loop

	xor edx, edx		; clear edx
	xor ebx, ebx		; clear ebx
swap:
	add ebx, ebx		; + j
		
	loop swap		; loop for (i = j = 0; i < 256; i++)			
