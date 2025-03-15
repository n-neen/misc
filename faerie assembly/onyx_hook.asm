lorom

;onyx hook

!roompointer        =       $8027

org $8ff000
hook: {
    
    .jump: {
        lda $09b6       ;dash binding
        ora #$0830      ;L+R+up
        cmp $8b         ;if not pressing L+R+[dash]+up, exit
        bne +
        
        lda #$0009
        sta $0998       ;change game mode to start door transition
        
        lda $80c4d5     ;load station crateria #1 door pointer
        sta $078d
        
        lda #$e17d
        sta $099c       ;door transition function pointer
        
    +   rtl
    }
    
    org $828b4b
    .hijack: {
        jsl hook_jump
        nop #5
    }
}