lorom

org $8488aa
    jsr itemhud
    nop
    
    

org $84ff00             ;x = plm room argument
    itemhud:
    STA $7ED870,x       ;vanilla line we overwrote
    
    lda $1dc7,x
    and #$00ff          ;value to draw = x = plm argument low byte
    ldx #$002c          ;location to draw at
    jsl $809d78         ;draw three hud digits
    rts