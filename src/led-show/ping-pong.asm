  .org $8000
main:
  lda #$FF
  sta $6002 ; set all "port B" bits as output

one_left_to_right:
  lda #$80
  sta $6000
  ror
  sta $6000
  ror
  sta $6000
  ror
  sta $6000
  ror
  sta $6000
  ror
  sta $6000
  ror
  sta $6000
  ror
  sta $6000
one_right_to_left:
  lda #$01
  sta $6000
  rol
  sta $6000
  rol
  sta $6000
  rol
  sta $6000
  rol
  sta $6000
  rol
  sta $6000
  rol
  sta $6000
  rol
  sta $6000
byte_left_to_right:
  lda #$80
  sta $6000
  lda #$C0
  sta $6000
  lda #$E0
  sta $6000
  lda #$F0
  sta $6000
  lda #$F8
  sta $6000
  lda #$FC
  sta $6000
  lda #$FE
  sta $6000
  lda #$FF
  sta $6000
  lsr
  sta $6000
  lsr
  sta $6000
  lsr
  sta $6000
  lsr
  sta $6000
  lsr
  sta $6000
  lsr
  sta $6000
  lsr
  sta $6000
  lsr
  sta $6000
byte_right_to_left:
  lda #$01
  sta $6000
  lda #$03
  sta $6000
  lda #$07
  sta $6000
  lda #$0F
  sta $6000
  lda #$1F
  sta $6000
  lda #$3F
  sta $6000
  lda #$7F
  sta $6000
  lda #$FF
  sta $6000
  asl
  sta $6000
  asl
  sta $6000
  asl
  sta $6000
  asl
  sta $6000
  asl
  sta $6000
  asl
  sta $6000
  asl
  sta $6000
  asl
  sta $6000
  jmp one_left_to_right

; Move to the entry address (0xFFFC and 0xFFFD)
  .org $FFFC

  ; set entry address to reset label (0x8000)
  .word main ; 00 80

; Fill to 32K
  .word $0000 ; 00 00
