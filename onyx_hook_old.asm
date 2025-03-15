lorom

;onyx hook
;this is the old version of this with manually written doors
;yuriks had an idea to use the load point list to grab a door from
;so we can do away with constantly updaying the below define
;if you  aren't using smart and your room header isn't constantly moving
;you could probably just use this version


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
        
        lda.w #hook_door
        sta $078d       ;door pointer
        
        lda #$e17d
        sta $099c       ;door transition function pointer
        
    +   rtl
    }
    
    org $83ad66
    .door: {
        dw !roompointer
        db $00                  ;elevator properties
        db $02                  ;direction
        db $00                  ;x
        db $00                  ;y
        db $04                  ;x screen
        db $04                  ;y screen
        dw $8000                ;distance
        dw $0000                ;door asm
    }
    
    org $828b4b
    .hijack: {
        jsl hook_jump
        nop #5
    }
}