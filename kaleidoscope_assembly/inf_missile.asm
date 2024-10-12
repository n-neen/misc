lorom

!84free         =       $84fdd0
!80free         =       $80d100
    
org $809c10
    jsr infcheck
    nop #3
    
org !80free
    infcheck:
    
    lda $09c8           ;if max missiles > #$0064 (100)
    cmp #$0064
    
    bpl +
    lda $09c6           
    ldx #$0094          ;otherwise, write missile count as normal
    jsr $9d78
    rts

+   ldx #$8000          ;somehow this worked (move it way far away)
    jsr $9d78
    lda #$8000          ;keep missiles infinite
    sta $09c6
    sta $09c8
    
    lda #$2c0f          ;blank out missile digits
    sta $7ec608+$94
    sta $7ec608+$96
    sta $7ec608+$98
    
    rts