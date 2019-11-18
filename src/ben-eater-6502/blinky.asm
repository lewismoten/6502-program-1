; 32KB ROM for 6502
; Offset 0x8000.
; Interface I/0 at address 0x6000

; Set default value for padding as no-op instruction
FILLVALUE $EA

; start assembling at address 0
ORG $0000

; ----------------------------------------
; Set all bits for Register "B" as output
; ----------------------------------------
;
; All bits will be output (B11111111 - 0xFF)
; Load accumulator
lda #$FF ; A9 FF

; Interface starts at 0x6000
; Set data direction for I/0 Register "B" as output (RS Coding 0010)
; 0x6000 (I/0 Address) + B0010 = 0x6002
; store value from accumulator at address 0x6002
sta $6002 ; 8D 02 60

; ----------------------------------------
; Alternate off/on to output register "B"
; ----------------------------------------
;
; Alternate off/on output (B01010101 = 0x55)
; Load accumulator
lda #$55 ; A9 55

; Interface starts at 0x6000
; Output to Register "B" (RS Coding 0000)
; 0x6000 (I/0 Address) + B0000 = 0x6000
; store value from accumulator at address 0x6002
sta $6000 ; 8D 00 60

; ----------------------------------------
; Alternate on/off to output register "B"
; ----------------------------------------
;
; Alternate on/off output (B10101010 = 0xAA)
; Load accumulator
lda #$AA ; A9 AA

; Interface starts at 0x6000
; Output to Register "B" (RS Coding 0000)
; 0x6000 (I/0 Address) + B0000 = 0x6000
; store value from accumulator at address 0x6002
sta $6000 ; 8D 00 60

; ----------------------------------------
; Loop back to start of output pattern
; ----------------------------------------
;
jmp $8005 ; 4C 05 80


; Skip to entry address
PAD $7FFC

; Now at entry address (0xFFFC and 0xFFFD)
; start program at 0x8000
HEX 0080 ; 00 80

; Fill to 32K
PAD $8000
