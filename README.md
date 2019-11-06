# 6502-program-1
Learning how to write assembly language for the 6502 microprocessor.

# What is 6502
The [6502](https://en.wikipedia.org/wiki/MOS_Technology_6502) is an 8-bit microprocessor designed by MOS Technology in 1975. It's low cost enabled many affordable home PC's to be built. It can be found in devices such as the Atari, Commodore, and NES.

# Programs

* [Code Injection](./src/code-injection/) Modifies memory and executes it as a command.

# Developer Tools

## Assembler

The assembler converts assembly language into machine code, resulting in a `bin` file, often put onto a `ROM` chip that the CPU retrieves its instructions from.

* **Web**: [6502 Assembler](https://www.masswerk.at/6502/assembler.html)
  * Remove comments from asm file
* **Windows**: Use asm6 executable in [./tools/asm6](./tools/asm6). View [readme](./tools/asm6/README.TXT)
  * Command: `.\tools\asm6\asm6.exe .\src\code-injection\main.asm`
  * Creates `.\src\code-injection\main.bin` to put on your ROM.

### Syntax Highlighting

This project contains `asm` files written in assembly language using the 6502 instruction set. Syntax highlighting makes it easier to view the file by applying color to specific commands and values.

* **Atom**: Install the [language-6502asm](https://atom.io/packages/language-6502asm) package for syntax highlighting on `.asm` files.

## Hex Viewer

A hex editor is useful for viewing and editing `bin` files created by the assembler.

* **Web**: [File to hex converter](https://tomeko.net/online_tools/file_to_hex.php?lang=en)
* **Windows**: [Hex Editor Pro](https://www.microsoft.com/en-us/p/hex-editor-pro/9wzdncrdq8l3)
* **PowerShell**: `format-hex -Path .\src\code-injection\main.bin`

## Virtual Machine

* **Web** [virtual 6502](http://e-tradition.net/bytes/6502/)
  * Ignores entry specified at 0xFFFB, 0xFFFC. Starts at address 0x0000

# Tutorial Videos
I'm following [Ben Eater's](https://www.reddit.com/r/beneater/) tutorial videos on YouTube for two of [his kits](https://eater.net/6502).
* 6502 Computer Kit
* Kit 1: Clock module.

## 555 Timer
* [Astable 555 timer - 8-bit computer clock - part 1](https://www.youtube.com/watch?v=kRlSFm519Bov)
* [Monostable 555 timer - 8-bit computer clock - part 2](https://www.youtube.com/watch?v=81BgFhm2vz8)
* [Bistable 555 - 8-bit computer clock - part 3](https://www.youtube.com/watch?v=WCwJNnx36Rk)

## 6502 Kit
* ["Hello, world" from scratch on a 6502](https://www.youtube.com/watch?v=LnzuMJLZRdU)
* [How do CPUs read machine code? - 6502 part 2](https://www.youtube.com/watch?v=yl8vPW5hydQ)

# Personal Note
I've punched in machine code for:
* [COSMAC ELF Membership Card](http://www.sunrise-ev.com/membershipcard.htm)
* [Altair 8800micro](http://www.brielcomputers.com/wordpress/?cat=18)

This is my first experience writing in assembly language directly. In the past I've written machine language out on paper and flipped switches to enter programs manually for an 1802, and emulated 8080 CPU chips. I've only worked out the assembly in reverse afterwards while writing documentation on an 8800. Note that my [Light Switch](https://github.com/lewismoten/Altair8800) program on GitHub was published within a [markdown file](https://github.com/lewismoten/Altair8800/blob/master/light%20switch.md) rather than an `asm` file.

I grew up with, and still have an Atari 400 with 16k of ram. I was unfamiliar with how to write to it in machine language. I am repairing it and hope one day to write programs in assembly. In the mean time, I've purchased a few chips on ebay and a 6502 kit.
