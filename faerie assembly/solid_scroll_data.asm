lorom

org $8fe99b

solidscrolldata: {
    .parlor: {
        db $07, $01     ;8th screen = blue
        db $80
        
        db $02, $02     ;3rd screen = green
        db $80
    }
    
    .postspeed: {
        ;warn pc
        db $05, $00     ;5th-9th screens = red
        db $06, $00
        db $07, $00
        db $08, $00
        db $09, $00
        db $80
        
    }
}