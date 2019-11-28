.org $8000

; IO pins to Display
; PB0-7 = DB0-7
; PA5 = RS (0 instructions, 1 data)
; PA6 = R/W (0 = Write)
; PA7 = Enable (1 start data read/write)

; Display:  RS|RW|E |D0|D1|D2|D3|D4|D5|D6|D7|
; I/O Port: A5|A6|A7|B0|B1|B2|B3|B4|B5|B6|B7|

main:
lda #$FF
sta $6002 ; set all "port B" bits as output
lda #$FF
sta $6003 ; set all "port A" bits as output

text:

command_function_set:

; D5 - Function Set
;    D4 - 1: 8-bit 0: 4-bit
;    D3 - 1: 2 lines; 0: 1 Line
;    D2 - 1: 5x10 dots; 0: 5x7 dots
; PB = 00111100
lda #$3C
sta $6000

; Enable
lda #$80
sta $6001
lda #$00
sta $6001

command_display_on_off_cursor:
; D3 - Display On/Off & Cursor
;   D2 - 1: On; 0: Off
;   D1 - 1: Cursor Underline On; 0: Off
;   D0 - 1: Cursor Blink On; 0: Off

; port B = 11110000
lda #$0F
sta $6000

; Enable
lda #$80
sta $6001
lda #$00
sta $6001

command_entry_mode_set:
; D2 - Entry Mode Set
;   D1: 1: Incriment by 1; 0: Decrement
;   D0: 1: Shift to left; 0: Right

; port B = 00000110
lda #$06
sta $6000

; Enable
lda #$80
sta $6001
lda #$00
sta $6001

write_H:

; port B (H) = 01001000
; H = 1000:0100 (lower:upper)
lda #$48
sta $6000
; Enable / Data
; 10100000
lda #$A0
sta $6001
lda #$00
sta $6001

write_e:

; port B (e) = 01100101
; e = 0101:0110 (lower:upper)
lda #$65
sta $6000
; Enable / Data
; 10100000
lda #$A0
sta $6001
lda #$00
sta $6001

write_ll:

; port B (l) = 01101100
; l = 1100:0110 (lower:upper)
lda #$6C
sta $6000
; Enable / Data
; 10100000
lda #$A0
sta $6001
lda #$00
sta $6001
lda #$A0
sta $6001
lda #$00
sta $6001

write_o:

; port B (o) = 01101111
; o = 1111:0110 (lower:upper)
lda #$6F
sta $6000
; Enable / Data
; 10100000
lda #$A0
sta $6001
lda #$00
sta $6001

write_space:

; port B (space) = 00100000
; space = 0000:0010 (lower:upper)
lda #$20
sta $6000
; Enable / Data
; 10100000
lda #$A0
sta $6001
lda #$00
sta $6001

write_W:

; port B (W) = 01010111
; W = 0111:0101 (lower:upper)
lda #$57
sta $6000
; Enable / Data
; 10100000
lda #$A0
sta $6001
lda #$00
sta $6001

write_o2:

; port B (o) = 01101111
; o = 1111:0110 (lower:upper)
lda #$6F
sta $6000

; Enable / Data
; 10100000
lda #$A0
sta $6001
lda #$00
sta $6001

write_r:

; port B (r) = 01110010
; r = 0010:0111 (lower:upper)
lda #$72
sta $6000

; Enable / Data
; 10100000
lda #$A0
sta $6001
lda #$00
sta $6001

write_l2:

; port B (l) = 01101100
; l = 1100:0110 (lower:upper)
lda #$6C
sta $6000
; Enable / Data
; 10100000
lda #$A0
sta $6001
lda #$00
sta $6001

write_d:

; port B (d) = 01100100
; d = 0100:0110 (lower:upper)
lda #$64
sta $6000
; Enable / Data
; 10100000
lda #$A0
sta $6001
lda #$00
sta $6001

brk
;jmp text

; Move to the entry address (0xFFFC and 0xFFFD)
.org $FFFC

; set entry address to reset label (0x8000)
.word main ; 00 80

; Fill to 32K
.word $0000 ; 00 00
