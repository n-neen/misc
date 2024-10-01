lorom

org $8f91ec     ;skip spawning ridley eye animated tile object
    nop #7
    
org $aad765     ;phantoon palette
    dw $3800, $4776, $1756, $0a92, $01ef, $0128, $0084, $0022, $0000, $001f, $0012, $0009, $0014, $000e, $0006, $0002
    
org $86b91e     ;eye breaking particle colors
    dw $001f, $0012, $0009, $0002  ; Phantoon
    dw $7F5F, $7C1F, $5816, $300C  ; Ridley
    dw $7F5A, $7EC0, $6DE0, $54E0  ; Draygon
    dw $6BFA, $3BE0, $2680, $1580  ; Kraid
    
org $88dbe3     ;nop out ridley statue check
    nop #9
    
org $8783cd     ;83d8-11
    db $04      ;phantoon area = 4 (maridia)
    
org $878435     ;8440-11
    db $02      ;ridley area = 2 (unchanged, norfair)
    
org $87849d     ;84a8-11
    db $01      ;kraid area = 1 (unchanged, brinstar)
    
org $878505     ;8510-11
    db $00      ;draygon area = 0 (crateria)