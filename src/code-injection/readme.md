# Code Injection

My first assembly file for a 6502 CPU built from scratch without following a tutorial. This simple program adds a jump command while to program is running and executes it.

* Start at address 0x0F00 (3,840)
* Store jump instruction at 0x0400 (1,024) to jump to 0x0F00 (3,840)
* Jump to 0x0400 (1,024)
* in a 64kb file

# Warning
Instructions have not been tested.

# 16-bit numbers
Note that 16 bit numbers are written out as little-endian where the most significant byte is first, and the least significant byte is last.

| Decimal | Hex | big-endian | little-endian |
| - | - | - | - |
| 1,024 | 0x0400 | 0x04 0x00 | 0x00 0x04 |

# Instructions Used

| Hex | Instruction | Name | Details | Operands |
| - | - | - | - | - |
| 0xEA | NOP | No operation | Do nothing | None |
| 0xA9 | LDA | Load Accumulator | Load a value into the accumulator | 8-bit value |
| 0x8D | STA | Store Accumulator | Store value in accumulator at specified address | 16-bit address |
| 0x4C | JMP | Jump | Jump to specified address | 16-bit address |

# Output

Note that the 6502 chip looks for the first address to read stored at 0xFFFB and 0xFFFC (decimal 65,531) after initialization.

## HEX Dump

65,536 bytes (64K)

| Address | 0x0 | 0x1 | 0x2 | 0x3 | 0x4 | 0x5 | 0x6 | 0x7 | 0x8 | 0x9 | 0xA | 0xB | 0xC | 0xD | 0xE | 0xF |
| --- | - | - | - | - | - | - | - | - | - | - | - | - | - | - | - | - |
| 0x0000 | 0xEA | * |  |  |  |  |  |  |  |  |  |  |  |  |  |  |
| 0x0F00 | 0xA9 | 0x4C | 0x8D | 0x00 | 0x04 | 0xA9 | 0x00 | 0x8Dx | 0x01 | 0x04 | 0xA9 | 0x0F | 0x8D | 0x02 | 0x04 | 0x00  |
| 0x0F10 | 0x0F | 0xEA | * |
| 0xFFF0 |  |  |  |  |  |  |  |  |  |  | 0x4C | 0x00 | 0x0F | 0xEA | * | |
| 0x10000 | **EOF** |


## Instructions

| Address | 0x0 | 0x1 | 0x2 | 0x3 | 0x4 | 0x5 | 0x6 | 0x7 | 0x8 | 0x9 | 0xA | 0xB | 0xC | 0xD | 0xE | 0xF |
| --- | - | - | - | - | - | - | - | - | - | - | - | - | - | - | - | - |
| 0x0000 | NOP | * |  
| 0x0400 | NOP *JMP* | NOP *0xF00* | NOP | * |  
| 0x0F00 | LDA | *JMP* | STA | 0x400 | | LDA | 0x00 *0x0F[00]* | STA | 0x401 | | LDA | 0x0F *0x[0F]00* | STA | 0x402 | | JMP |
| 0x0F10 | 0x0400 |  | NOP | * |  |
| 0xFFF0 |  |  |  |  |  |  |  |  |  |  | JMP | 0xF00 | | NOP | * | |
| 0x10000 | **EOF** |

**NOTE**: `NOP` instructions at address `0x0400` to `0x0402` change to `JMP 0x0F00`

### Strategy
Note that the last `JMP` instruction at `0x0FFA` isn't necessary (but the address is) as the 6502 CPU will always read the entry address from `0x0FFB` & `0x0FFC` to determine where the program starts. The CPU will never read the `JMP` instruction at `0x0FFA` since we have a `JMP` instruction at the end of our program at `0x0F0F`. It was added to simplify the assembly code that knew the address of the `main:` label. It could have been hard-coded, but using labels allows additional code to be added later without having to determine and edit the entry address.

## Verbose Instructions

| Step | 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 | 10 | 11 | 12 | 13 | 14 | 15 |
| --- | - | - | - | - | - | - | - | - | - | - | - | - | - | - | - | - |
| 0 | Do nothing | * |
| 1,024 | Do nothing *becomes Jump* | Do nothing *becomes step 3,840* | Do nothing | * |
| 3,840 | Remember number | 76 *(JMP)* | Replace step | 1,024 | | Remember number | 0 | Replace step | 1,025 || Remember number | 15 | Replace step | 1,025 | | Go to step |
| 3,856 | 1,024 |  | Do nothing | * |  |  |
| 65,520 |  |  |  |  |  |  |  |  |  |  | Go to step | 3,840 | | Do nothing | * | |
| 65,536 | **EOF** |

## Verbose Steps

* Step 0. Do nothing
* ...
* Step 1,024. Do nothing *(re-written as* `Go to step 3,840` *)*
* ...
* Step 3,840. Remember 76 (a jump instruction)
* Step 3,842. Replace step 1,024 with 76
* Step 3,845. Remember 0 (low byte of 3,840)
* Step 3,847. Replace step 1,025 with 0
* Step 3,850. Remember 15 (high byte of 3,840)
* Step 3,852. Replace step 1,026 with 15
* Step 3,855. Go to step 1,024
* Step 3,858. Do nothing
* ...
* Step 65,530. Go to step 3840 *(cpu first step)*
* Step 65,533. Do nothing
* Step 65,534. Do nothing
* Step 65,535. Do nothing
