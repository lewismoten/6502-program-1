; 32KB
; Offset 0x8000.

; Set default value for padding as no-op instruction
FILLVALUE $EA

; start assembling at address 0
ORG $0000

; Load accumulator with value of 0x42
lda #$42 ; A9 4C

; store value in accumulator at address 6000
sta $6000

; Skip to entry address
PAD $7FFC

; Now at entry address (0xFFFC and 0xFFFD)
; start program at 0x8000
HEX 0080

; Fill to 32K
PAD $8000
