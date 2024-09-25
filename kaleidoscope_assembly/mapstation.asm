lorom

;map station draw instructions

org $849f25                 ;idle frame one
    dw $0001, $8225
    db $ff, $00
    dw $0001, $8224
    dw $0000
    
org $849f31                 ;idle frame two
    dw $0001, $8245
    db $ff, $00
    dw $0001, $8244
    dw $0000
    
org $849f3d                 ;idle frame three
    dw $0001, $8265
    db $ff, $00
    dw $0001, $8264
    dw $0000

org $849f49                 ;activation right side
    dw $0001, $8227
    db $fd, $00
    dw $0001, $8627
    dw $0000
;9f55
    dw $0001, $8246         ;gun turret, right side
    dw $0000
;9f5b
    dw $0001, $8627         ;activation left side
    db $03, $00
    dw $0001, $8227
    dw $0000
;9f67
    dw $0001, $8646         ;gun turret, left side
    dw $0000
    