; ****************************************
; Move two LED lights to the right and wrap around
; ****************************************
; 32KB ROM for 6502
; Offset 0x8000.
; Interface I/0 at address 0x6000
;
; First call to '.org' tells assembler the first address our memory starts
; This helps it associate labels with the correct addresses offset from
; Memory start address

; ----------------------------------------
; Memory begins at 0x8000
  .org $8000

; Remember the start of our program for later reference
reset:

; ----------------------------------------
; Set all bits for Register "B" as output
; ----------------------------------------
;
; All bits for port "B" will be marked as output (B11111111 - 0xFF)
; Load accumulator
  lda #$FF ; A9 FF

; Interface starts at 0x6000
; Set data direction for I/0 Register "B" as output (RS Coding 0010)
; 0x6000 (I/0 Address) + B0010 = 0x6002
; store value from accumulator at address 0x6002
  sta $6002 ; 8D 02 60

; Now we tell I/O register to set bits on/off for port "B"
; set only two bits on, separated by an off...
; B01010000 = 0x50
  lda #$50
; Set data for I/0 Register "B" (RS Coding 0000)
; 0x6000 (I/0 Address) + B0000 = 0x6000
; store value from accumulator at address 0x6000
  sta $6000 ; 8D 00 60

loop:
; Rotate bits to the right
; A bit in position 0 will move to the carrit bit
; ie - B00000001 carry 0, becomes B00000000 carry 1
; If the carry bit is flagged, then the bit at position 7 will be on
; ie - B00000000 carry 1, becomes B10000000 carry 0
; This essentally gives us "9" bits to rotate, while only displaying 8
; The carry bit is not displayed.
  ror

; store rotated value from accumulator at address 0x6000 (port "B")
  sta $6000 ; 8D 00 60

; jump back to the loop label (0x0580)
  jmp loop ; 4C 05 80

; Move to the entry address (0xFFFC and 0xFFFD)
  .org $FFFC

  ; set entry address to reset label (0x8000)
  .word reset ; 00 80

; Fill to 32K
  .word $0000 ; 00 00
