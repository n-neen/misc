org $82e767
hijack: {
    jsr slopulator
    ;this is about as late as possible anything in a door transition can be
    ;this is right at the point where game state is changed back to 'main gameplay' (8)
}

org $82f800
slopulator: {
    sta $0998                   ;the thing we overwrote
    
    phy                         ;registers we clobber
    phx
    phb
    
    lda $07b9                   ;x = level data size
    ;asl
    ;inc a
    tax
    inx
    
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
    
    rts
    
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