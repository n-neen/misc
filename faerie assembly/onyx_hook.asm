lorom

;onyx hook

org $8ff000
hook: {
    
    .jump: {
        lda $09b6       ;dash binding
        ora #$0830      ;L+R+up
        cmp $8b         ;if not pressing L+R+[dash]+up, exit
        bne +
        
        ;warn pc
        ..short:
        
        lda #$0009
        sta $0998       ;change game mode to start door transition
        
        lda $80c4b5     ;pointer to crateria load point list
        tax
        lda $800010,x   ;door pointer for crateria load point 1
        sta $078d       ;door pointer for upcoming transition
        
        lda #$e17d
        sta $099c       ;set initial door transition function pointer
        
    +   rtl
    }
    
    .mainroutine: {     ;magicant main room main asm
       ;warn pc         ;f023 currently
        sep #$20
        lda $51
        bmi +
    -   rep #$20
        stz $07df
        rts
    +   and #$7f
        sta $51
        bra -
    }
}
    
    org $828b4b
    .hijack: {
        jsl hook_jump
        nop #5
    }
}