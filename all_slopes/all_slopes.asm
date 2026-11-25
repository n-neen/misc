org $82eb69
hijack: {
    jmp slopulator
}

org $82f800
slopulator: {
    phy                         ;registers we clobber
    phx
    phb

    lda $07b9                   ;x = level data size
    asl
    inc a
    tax
    
    pea $7f7f                   ;db = $7f
    plb
    plb
    
    sep #$20                    ;8-bit A
    
    .loop:
    
    lda $0000,x                 ;entry in level data array
    and #$f0
    cmp #$80
    beq .changetype             ;if 8 (solid), change type/subtype
    
    .typereturn:
    
    dex                         ;x=x-2
    dex
    
    bpl .loop                   ;if x hasn't underflowed, loop
    
    plb
    plx
    ply
    
    rep #$30
    
    rtl                         ;replaces rtl at $82eb6b
    
    .changetype: {
        lda $0000,x             ;in level data array
        and #$0f
        ora #$10
        sta $0000,x
        
        phx
        
        rep #$20
        txa
        lsr                     ;a=x/2
        dec
        tax
        sep #$20
        
        ;lda $6402,x
        ;and #$70
        ;ora #$13
        lda #$13
        sta $6402,x             ;in subtype (bts) array
        
        plx
        
        bra slopulator_typereturn
    }
}