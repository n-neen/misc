lorom

org $8f91ec     ;skip spawning ridley eye animated tile object
    nop #7
    
org $aad765     ;phantoon palette
    dw $3800, $4776, $1756, $0a92, $01ef, $0128, $0084, $0022, $0000, $001f, $0012, $0009, $300C, $5294, $39CE, $2108
    
org $86b91e     ;eye colors
    dw $001f, $0012, $0009, $0002  ; Phantoon (yellow)
    dw $7F5F, $7C1F, $5816, $300C  ; Ridley (red)
    dw $7F5A, $7EC0, $6DE0, $54E0  ; Draygon (blue)
    dw $6BFA, $3BE0, $2680, $1580  ; Kraid (green)
    