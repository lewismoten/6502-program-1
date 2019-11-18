; Set default value to no-operation instruction
FILLVALUE $EA

; start assembling at address 0
ORG $0000

; Fill no-op instructions to 32K
PAD $8000
