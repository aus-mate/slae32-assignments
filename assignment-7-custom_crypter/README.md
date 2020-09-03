# Usage
1. Generate encrypted shellcode: `python3 encrypter.py`
2. Copy encrypted shellcode & key and replace in the relevant fields within the `decrypter.nasm` file.
3. Assemble & link: `./compile decrypter`
4. Replace the shellcode within `shellcode.c` with the output from the compile script.
5. Execute shellcode: `./shellcode`

_Note: The shellcode used in this assignment will execute `/bin/sh`._
