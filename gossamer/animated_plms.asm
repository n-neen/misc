lorom

!plmentry = $f3a8                           ;draygon head facing left

org $840000+!plmentry

    dw #setup, #leftinst

    setup:
        rts
    
    leftinst:
        dw $0200, #leftframeone             ;draw frame one for $708 frames
        dw $0002, #leftframetwo             ;draw frame two for $4 frames
        dw $0005, #leftframethree           ;draw frame three for $20 frames
        dw $8724, #leftinst                 ;return to top
    
    leftframeone:
        dw $0002, $81e7, $81e8              ;two tiles, in row, solid ($8000), tiles $1e7 and $1e8 in SCE
        db $00, $01                         ;next row
        dw $0002, $8207, $8208              ;two tiles, in row, solid ($8000), tiles $207 and $208
        dw $0000                            ;terminator
    leftframetwo:
        dw $0001, $81e9, $0000              ;one tiles, solid, tile $1e9 (closing eye)
    leftframethree:
        dw $0001, $81ea, $0000              ;one tile, solid, tile $1ea (closed eye)

;$f3d9                                    ;draygon head facing right

    dw #setup, #rightinst

    rightinst:
        dw $0200, #rightframeone             ;draw frame one for $708 frames
        dw $0002, #rightframetwo             ;draw frame two for $4 frames
        dw $0005, #rightframethree           ;draw frame three for $20 frames
        dw $8724, #rightinst                 ;return to top

    rightframeone:
        dw $0002, $81e8, $85e7               ;two tiles, in row, solid ($8000), tiles $1e8 and $1e7 (h flip = $0400)
        db $00, $01                          ;next row
        dw $0002, $8208, $8607               ;two tiles, in row, solid ($8000), tiles $208 and $207 (h flip = $0400)
        dw $0000                             ;terminator
    rightframetwo:
        dw $0002, $81e8, $85e9, $0000        ;two tiles, in row, solid ($8000), tiles $1e8 and $1e9 (h flip)
    rightframethree:
        dw $0002, $81e8, $85ea, $0000        ;two tiles, in row, solid ($8000), tiles $1e8 and $1ea (h flip)

;f40d

    dw #chozosetup, #chozoinst
    
    chozosetup:
        rts
    
    chozoinst:
        dw $0050, #chozoframeone
        dw $0008, #chozoframetwo
        dw $0008, #chozoframethree
        dw $0008, #chozoframefour
        dw $0014, #chozoframefive
        dw $0006, #chozoframefour
        dw $0006, #chozoframethree
        dw $0006, #chozoframetwo
        dw $8724, #chozoinst
        
    chozoframeone:
        dw $0002, $8360, $8361, $0000
        
    chozoframetwo:
        dw $0002, $8362, $8363, $0000
    
    chozoframethree:
        dw $0002, $8364, $8365, $0000
        
    chozoframefour:
        dw $0002, $8366, $8367, $0000
    
    chozoframefive:
        dw $0002, $8368, $8369, $0000