.org $8000

; IO pins to Display
; PB0-7 = DB0-7
; PA5 = RS (0 instructions, 1 data)
; PA6 = R/W (0 = Write)
; PA7 = Enable (1 start data read/write)

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
lda #$01
sta $6001
lda #$00
sta $6001

command_display_on_off_cursor:
; D3 - Display On/Off & Cursor
;   D2 - 1: On; 0: Off
;   D1 - 1: Cursor Underline On; 0: Off
;   D0 - 1: Cursor Blink On; 0: Off

; port B = 00001111
lda #$0F
sta $6000

; Enable
lda #$01
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
