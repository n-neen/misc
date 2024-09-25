lorom

!counter = $c8

org $8fff80
colorthing:
    ldx !counter
    cpx #$1000
    beq end
    
    lda $7f6402,x                   ;change to some location whose values dynamically change
    and #$001f          ;r
    sta $7ec000,x
    
    lda $7f6402,x
    and #$03e0          ;g
    sta $7ec002,x
    
    lda $7f6402,x
    and #$7c00          ;b
    sta $7ec004,x
    
    inc !counter
    
    rts
    
    end:
    stz !counter
    rts