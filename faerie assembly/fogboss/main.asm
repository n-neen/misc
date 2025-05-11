lorom


landing: {
    .main: {
        ;$8687
        ;warn pc
        jsr fog_main
        rtl
    }
    
    .shot: {
        ;$868b
        jsr fog_shot
        rtl
    }
    
    .init: {
        ;$868f
        ;warn pc
        jsr fog_init
        rtl
    }
}

fog: {
    .main: {
        ;
        rts
    }
    
    .shot: {
        ldx $0e54
        lda $0f8c,x             ;enemy health before shot
        pha
        
        jsl $a0802d             ;normal enemy shot
        
        pla                     ;retrieve enemy health from before shot was processed
        beq ++
        cmp $0f8c,x
        beq +
        
        ldy.w #hurtglow         ;spawn hurt glow pfo
        jsl $8dc4e9
        
        
    +   rts
    
    ++  jsr fog_death
        rts
    }
    
    .init: {
        ldx $0e54
        lda.w #fog_list         ;set instruction list pointer
        sta $0f92,x
        
        jsr fog_tilemapupload
        
        rts
    }
    
    .list: {
        !goto   =   $80ed
        !sleep  =   $812f
        
        ;stuff that needs to happen after init but not part of main instruction list loop
        dw fog_palettesetup
        
        
        ..loop:
        dw #fog_aimain
        dw $0001, #spritemap_dummy
        dw !goto, #..loop
        dw !sleep
    }
    
    .aimain: {
        ;todo:
        ;scroll
        ;maybe turn around and scroll tother way
        ;maybe blink?
        
        
        
        rtl
    }
    
    .palettesetup: {
        ;rtl
        
        lda $7ec030
        sta $7ec0f0
        
        lda $7ec032         ;copy 4 colors from palette blend (bg3 palette 6, bg1 palette 1)
        sta $7ec0f2         ;to bg1 palette 7
        
        lda $7ec034
        sta $7ec0f4
        
        lda $7ec036
        sta $7ec0f6
        
        rtl
    }
    
    .death: {
        ;spawn explosion
        ;clear bg2 tilemap
        ;spawn drops
        ;maybe change music
        rts
    }
    
    .tilemapupload: {
        ;copy bg2 tilemap from rom to $7e2000
        ;size = $1000
        phx
        
        lda #$1000              ;size of the following
        sta $179a
        
        
        ldx #$1002
    -   lda bg2tilemap-2,x      ;copy tilemap into wram buffer
        sta $7e1ffe,x
        dex : dex
        bne -
        
        lda #$0080              ;signal for nmi handler to transfer the above to vram
        sta $0e1e
        
        sep #$20
        
        stz $b5
        stz $b5                 ;temp scroll whatever
        
        lda $59
        ora #$01
        sta $2108               ;tilemap size select
        
        rep #$20
        
        plx
        rts
    }
}







bg2tilemap: {
    incsrc "./bg2tilemap.asm"
}

spritemap: {
    .dummy: {
        dw $0000
    }
}
