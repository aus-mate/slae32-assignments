# Usage
1. Assemble & link each of the files: 
    * `./compile.sh tiny_read_poly`
    * `./compile.sh execve_poly`
    * `./compile.sh chmod_poly`
    * `./compile.sh chmod_shortened`
2. Execute:
    * `./tiny_read_poly` - Will execute `cat /etc/passwd`
    * `./execve_poly` - Will execute `/bin/sh`
    * `./chmod_poly` & `./chmod_shortened` - Will `chmod 0666 /etc/shadow`
