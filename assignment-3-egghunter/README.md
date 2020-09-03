# Usage
1. Assemble & link: `./compile.sh egghunter`
2. Replace the shellcode in the `code` variable in `shellcode.c` with the output from the compile script.
5. Compile shellcode.c: `gcc -fno-stack-protector -z execstack shellcode.c -o shellcode`
6. Start listener: `nc -nvlp 4455`
7. Run shellcode to execute reverse shell: `./shellcode`

_Note: The shellcode used in this assignment is a reverse shell that will connect to port 4455 the localhost._
