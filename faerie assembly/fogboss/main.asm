lorom

!amounttomovex      =       $0fa8,x
!amounttomovey      =       $0faa,x
!flashcounter       =       $0fac,x
!scrollycounter     =       $0fae,x


landing: {
    .main: {
        ;$8687
        ;warn pc
        jsr fog_main
        rtl
    }
    
    .shot: {
        ;$868b
        ;warn pc
        jsr fog_shot
        rtl
    }
    
    .init: {
        ;$868f
        ;warn pc
        jsr fog_init
        rtl
    }
    
    .touch: {
        ;8693
        ;warn pc
        jsr fog_touch
        rtl
    }
}

fog: {
    .main: {
        ;todo:
        ;maybe turn around and scroll tother way
        
        ldx $0e54
        
        jsr .layerflash         ;handle layers during hurt flash
        jsr fog_move_update
        
        rts
    }
    
    .touch: {
        jsl $a0a477
        lda $0f8c,x
        beq +                   ;if health = 0
        
        rts
        
        +
        jsr fog_death
        rts
    }
    
    .shot: {
        ;warn pc
        ldx $0e54
        lda $0f8c,x             ;enemy health before shot
        pha
        
        jsl $a0802d             ;normal enemy shot
        
        pla                     ;retrieve enemy health from before shot was processed
        cmp $0f8c,x
        beq +                   ;if health has not changed, return
        
        ;if health has changed,
        
        phx
        ldy.w #hurtglow         ;spawn hurt glow pfo
        jsl $8dc4e9
        lda #$0008
        sta !flashcounter
        plx
        
        lda $0f8c,x             ;if health = 0
        beq ++                  ;goto death routine
        
    +   rts
        
    ++  jsr fog_death
        rts
    }
    
    .layerflash: {
        lda #$0030
        sta $1984
        
        lda $05b6
        bit #$0005
        bne +
        
        lda !flashcounter
        beq +
        dec
        sta !flashcounter
        
        lda #$0024
        sta $1984
        
    +   rts
        
        
    }
    
    .init: {
        ldx $0e54
        lda.w #fog_list         ;set instruction list pointer
        sta $0f92,x
        
        jsr fog_tilemapupload
        jsr fog_move_write
        
        rts
    }
    
    .list: {
        !goto   =   $80ed
        !sleep  =   $812f
        
        ;stuff that needs to happen after init but not part of main instruction list loop
        dw fog_palettesetup
        
        ..loop:
        dw $0001, #spritemap_dummy
        dw !goto, #..loop
        dw !sleep
    }
    
    .move: {
        !bg3xscroll     =       $7ecadc
        !bg3yscroll     =       $7ecade
        !bg2x           =       $b5
        !bg2y           =       $b7
        !enemyx         =       $0f7a,x
        !enemyy         =       $0f7e,x
        !bg3xbackup     =       $05a2
        !bg3ybackup     =       $05a4
        !camerax        =       $0911
        !cameray        =       $0915
        
        ..write: {
            ;this does the alignment of the bg2 tilemap to
            ;the camera and to the enemy hitbox
            
            ldx $0e54
            
            lda #$0000
            clc
            adc !camerax        ;bg2 x scroll = [camerax - enemyx] + $80
            sec
            sbc !enemyx
            clc
            adc #$0080          ;enemy offset from left edge of bg2 tilemap
            sta !bg2x
            
            lda #$0000
            clc
            adc !cameray        ;bg2 y scroll = [cameray - enemyy] + $68
            sec
            sbc !enemyy
            clc
            adc #$0068          ;enemy offset from top of bg2 tilemap
            sta !bg2y
            
            rts
        }
        
        ..update: {
            lda !enemyx
            clc
            adc !amounttomovex
            sta !enemyx
            cmp #$0200
            beq +
            
            lda !enemyy
            clc
            adc !amounttomovey
            sta !enemyy
            cmp #$0100
            beq ++
            
            -
            jsr .move_write
            jsr .move_decidenextmove
            
            rts
            
            +
            stz !enemyx
            bra -
            
            ++
            stz !enemyy
            bra -
        }
        
        ..decidenextmove: {
            lda $05e5
            and #$0002
            sta !amounttomovey
            
            lda $05e5
            xba
            and #$0002
            sta !amounttomovex
            rts
        }
    }
    
    .palettesetup: {
        rtl
        
        lda $7ec030
        clc
        adc #!colorshift
        sta $7ec0f0
        
        lda $7ec032         ;copy 4 colors from palette blend (bg3 palette 6, bg1 palette 1)
        clc
        adc #!colorshift
        sta $7ec0f2         ;to bg1 palette 7
        
        lda $7ec034
        clc
        adc #!colorshift
        sta $7ec0f4
        
        lda $7ec036
        clc
        adc #!colorshift
        sta $7ec0f6
        
        rtl
    }
    
    .death: {
        ;spawn drops
        ;maybe change music
        
        lda #$0022
        sta $1984
        
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

org $8fff10
    jsl fog_palettesetup
    stz $07df
    rts

