lorom

org $88803e+$0e
    dw #ethereal
    
org $88803e+$12
    dw #light
    
org $88803e+$1e
    dw #lightwater
    
org $88803e+$20
    dw #dark
    
org $88803e+$30
    dw #fogboss
    
org $88803e+$22
    dw fogboss2
    
org $88803e+$24
    dw fogboss3
    
org $88ee32
    ethereal:               ;0e
        lda #%00010011          ;main screen
        sta $69
        
        lda #%00000100          ;subscreen
        sta $6b
        
        lda #%00000010          ;enable color math
        sta $70
        
        lda #%00111111          ;color math layers
        sta $73
        
        rts
    
    
    light:                  ;$12
        lda #%00010010          ;main screen        00010010
        sta $69
        
        lda #%00010111          ;subscreen          00010111
        sta $6b
        
        lda #%00000010          ;enable color math
        sta $70
        
        lda #%00111111          ;color math layers
        sta $73
        rts
    
    
    lightwater:             ;1e
        lda #%00010010          ;main screen
        sta $69
        
        lda #%00010111          ;subscreen
        sta $6b
        
        lda #%00000010          ;enable color math
        sta $70
        
        lda #%00111111          ;color math layers
        sta $73
        rts
    
    dark:                   ;$20
        lda #%00000001          ;main screen
        sta $69
        
        lda #%00000110          ;subscreen
        sta $6b
        
        lda #%00000010          ;enable color math
        sta $70
        
        lda #%10111011          ;color math layers
        sta $73
        
        rts
    
    fogboss:                ;$30
        lda #%00010001          ;main screen
        sta $69
        
        lda #%00000110          ;subscreen
        sta $6b
        
        lda #%00000010          ;enable color math
        sta $70
        
        lda #%10111011          ;color math layers
        sta $73
        
        rts
        
    fogboss2:               ;$22            ;this gets loaded on death
        lda #%00010001          ;main screen
        sta $69
        
        lda #%00000100          ;subscreen
        sta $6b
        
        lda #%00000010          ;enable color math
        sta $70
        
        lda #%10111101          ;color math layers
        sta $73
        
        rts
        
        
    fogboss3:               ;$24            ;this gets loaded on hit
        lda #%00010011          ;main screen
        sta $69
        sta $6a
        
        lda #%00000100          ;subscreen
        sta $6b
        
        lda #%00000010          ;enable color math
        sta $70
        
        lda #%10111101          ;color math layers
        sta $73
        
        rts
        
org $89aa02

;  0        2                      8                      Eh                     14h                    1Ah
dw $0000,   $0E3F, $0D7F, $0000,   $6318, $6318, $0000,   $6318, $6318, $0000,   $6318, $6318, $0000,   $6318, $6318, $0000 ; 0
dw $3800,   $314A, $20C6, $0820,   $1d8e, $0d0b, $0ca8,   $6318, $6318, $0000,   $001f, $5c05, $0843,   $7fff, $6318, $0000 ; 20h
dw $3800,   $0400, $1C63, $0000,   $28E3, $1C60, $0000,   $2485, $3D88, $0000,   $0880, $0420, $0000,   $28E3, $1C60, $0000 ; 40h
dw $3800,   $20A5, $1C84, $1024,   $1087, $14A8, $0844,   $6318, $6318, $0000,   $6318, $6318, $0000,   $6318, $6318, $0000 ; 60h
dw $3800,   $6318, $6318, $0000,   $6318, $6318, $0000,   $6318, $6318, $0000,   $6318, $6318, $0000,   $6318, $6318, $0000 ; 80h
dw $3800,   $6318, $6318, $0000,   $0420, $241c, $0587,   $6318, $6318, $0000,   $6318, $6318, $0000,   $6318, $6318, $0000 ; A0h
dw $3800,   $0020, $000d, $03e0,   $0420, $241c, $056c,   $6318, $6318, $0000,   $6318, $6318, $0000,   $6318, $6318, $0000 ; C0h
dw $3800,   $0400, $18A2, $0000,   $0020, $0C62, $0000,   $0400, $1C45, $0000,   $6318, $6318, $0000,   $6318, $6318, $0000 ; E0h