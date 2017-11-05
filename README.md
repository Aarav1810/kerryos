# KERRYOS

<p>First of all, let's clear up the name. 'Kerry' was just a name I thought of randomly.
This is an operating system which boots up in 16-bit real mode, gives you an option to
reboot or to 'continue booting' into the kernel. The plan then is to write the kernel
after the bootsector in the 'loader.s' file, get a basic shell with some basic programs
going, and then to eventually move the kernel to a separate file. The pre-built '.flp'
file of the latest release is provided too, but if you would like to build it yourself
using the NASM Assembler, use the following commands on Unix-like systems:</p>
<code>nasm -fbin loader.s -o loader.bin</code>
<br>
<code>dd status=noxfer conv=notrunc if=loader.bin of=os.flp</code>
<br>
<code>qemu-system-i386 -fda os.flp</code>
<br>
# BUILD REQUIREMENTS
<br>
Please install the following:
<br>
`sudo apt install nasm`
<br>
`sudo apt install build-essential`
<br>
`sudo apt install qemu`
<br>
<br>
Happy booting!
