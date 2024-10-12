lorom

incsrc ./macros.asm

!84free         =       $84fdd0
!80free         =       $80d100

;set $4000 bit of plm argument to make this item give infinite missiles

org $84e4a4         ;in missile (chozo orb) instruction list
                    ;overwrites the "collect missile tank" instruction pointer
    dw #newinst
    
org !84free
    newinst:
    phx
    phy
    
    ldx $1c27
    lda $1dc7,x
    bit #$4000
    beq +
    
    lda #$8000      ;tack on #$8000 to the value loaded by the following jsr
    sta $09c8       ;the hud routine will just check if this is negative, and if so, don't draw digits at all
    sta $09c6
    
    ;%loadby_y(#$8000, $14)
    jsr $89a9
    
    ply
    plx
    iny : iny
    rts
    
+   plx
    jsr $89a9
    rts
    
org $809c10
    jsr infcheck
    nop #3
    
org !80free
    infcheck:
    
    lda $09c8           ;if max missiles > $7FFF
    bmi +               ;goto negative branch
    lda $09c6           
    ldx #$0094          ;otherwise, write missile count as normal
    jsr $9d78
    rts

+   ldx #$8000          ;somehow this worked (move it way far away)
    jsr $9d78
    lda #$8000          ;keep missiles infinite
    sta $09c6
    
    lda #$2c0f          ;blank out missile digits
    sta $7ec608+$94
    sta $7ec608+$96
    sta $7ec608+$98
    
    rts