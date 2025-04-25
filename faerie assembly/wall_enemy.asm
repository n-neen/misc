lorom
org $a8fa00

wall: {
    .init: {
        ldx $0e54
        
        lda #wall_list
        sta $0f92,x
        
        sep #$20
        lda $7ed829
        bit #$02
        rep #$20
        bne ..die
        
        rtl
        
        ..die:
        jsl $a0807c     ;delete
        rtl
    }
    
    .main: {
        ;warn "main - ", pc
        
        ldx $0e54
        stz $0fa2,x     ;shake timer = 0. thanks, mysty
        
        lda $0e50       ;botwoon does not normally increment this
        beq +           ;see botwoon.asm
        
        ldx $0e54       ;x = enemy index
        lda #$0004      ;a = 4 (for enemy explosion type)
        jsl $a0a3af     ;death
        
    +   rtl
    }
    
    .list: {
        dw $0001, #wall_spritemap
        dw $80ed, #wall_list
    }
    
    .spritemap: {
        DW $002A
        DB $F8,$01,$F8,$00,$01
        DB $F8,$01,$F0,$01,$01
        DB $00,$00,$F0,$02,$01
        DB $00,$00,$F8,$03,$01
        DB $F0,$01,$F0,$04,$01
        DB $F0,$01,$F8,$05,$01
        DB $08,$00,$F0,$06,$01
        DB $08,$00,$F8,$07,$01
        DB $F0,$01,$00,$08,$01
        DB $F8,$01,$00,$09,$01
        DB $00,$00,$00,$08,$01
        DB $08,$00,$00,$07,$01
        DB $F0,$01,$08,$06,$01
        DB $F8,$01,$08,$05,$01
        DB $00,$00,$08,$04,$01
        DB $08,$00,$08,$03,$01
        DB $F0,$01,$10,$02,$01
        DB $F8,$01,$10,$01,$01
        DB $00,$00,$10,$00,$01
        DB $08,$00,$10,$01,$01
        DB $F0,$01,$E8,$02,$01
        DB $F8,$01,$E8,$03,$01
        DB $00,$00,$E8,$04,$01
        DB $08,$00,$E8,$05,$01
        DB $E8,$01,$E8,$0A,$01
        DB $E8,$01,$F0,$0B,$01
        DB $E8,$01,$F8,$0A,$01
        DB $E8,$01,$00,$0B,$01
        DB $E8,$01,$08,$0A,$01
        DB $E8,$01,$10,$0B,$01
        DB $10,$00,$E8,$00,$01
        DB $18,$00,$E8,$01,$01
        DB $10,$00,$F0,$02,$01
        DB $18,$00,$F0,$03,$01
        DB $10,$00,$F8,$04,$01
        DB $18,$00,$F8,$05,$01
        DB $10,$00,$00,$06,$01
        DB $10,$00,$08,$07,$01
        DB $10,$00,$10,$08,$01
        DB $18,$00,$00,$09,$01
        DB $18,$00,$08,$08,$01
        DB $18,$00,$10,$07,$01
    }
}