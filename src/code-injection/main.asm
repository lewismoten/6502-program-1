; Start at address 0x0F00
; Create a jump instruction at 0x0401 to jump to the start of our project
; Jump to 0x0401
; Repeatedly
; Everything else is no-operation instructions
; 64kb file


; Set default value to no-operation instruction
FILLVALUE $EA

; start assembling at address 0
ORG $0000

; Fill no-op instructions to address 3840
PAD $0F00

; start of program
main:

; ------- Inject jmp main at 0x0400 -------

; Load accumulator with value of a JMP instruction
lda #$4C ; A9 4C

; Store accumulator at address 1024
sta $0400 ; 8D 00 04

; Load accumulator with value of least significant byte of 'main' label (0x0400) 00
lda #$00 ; A9 00

; Store value in accumulator at address 1025
sta $0401 ; 8D 01 04

; Load accumulator with value of most significant byte of 'main' label (0x0F00)
lda #$0F ; A9 0F

; Store value in accumulator at address 1026
sta $0402 ; 8D 02 04

; ------- Jump to the injected code -------

; Jump to the instruction we stored at 0x0400
jmp $0400 ; 4C 00 04

; Fill memory with no-operation instructions up to 1 less than entry address
PAD $FFFA

; set start of program at address 3840
; hack - set jump instruction just before it
jmp main ; 4C 00 0F

; set rest of memory up to 64kb with no-operation instructions
ALIGN $10000
