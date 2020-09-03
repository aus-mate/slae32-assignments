# Usage
1. Generate encoded shellcode: `python3 encoder.py`
2. Replace the shellcode in `decoder.nasm` with the encoded shellcode output by the previous script.
3. Assemble & link: `./compile.sh decoder`
4. Replace replace the shellcode in the `code` variable in `shellcode.c` with the output from the compile script.
5. Compile shellcode.c: `gcc -fno-stack-protector -z execstack shellcode.c -o shellcode`
6. Execute execve shellcode: `./shellcode`

_Note: The shellcode used in this assignment will execve `/bin/sh`._
