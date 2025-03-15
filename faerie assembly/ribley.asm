lorom

;ridley area checks.

!kridleyarea    =       #$0000
!ridleyawake    =       $09ec

org $a6a15f
    cmp !kridleyarea
    
org $a6a36c
    cpy !kridleyarea
    
org $a6a427
    cmp !kridleyarea
    
org $a6a46c
    cmp !kridleyarea
    
org $a6a47b
    cmp !kridleyarea
    
org $a6d917
    cmp !kridleyarea
    
org $a6d93e
    cmp !kridleyarea
    
org $a6df8d
    cmp !kridleyarea
    
org $a6e4d5
    cmp !kridleyarea
    
;ridley palette fade-in (bg1/2, not sprite palettes)

org $a6a4d6
    rts
    
org $a6a1e0
    nop #8
    
    
org $a6a360
    lda #sleep
    
org $a6febc     ;18 bytes
    sleep: {
        lda !ridleyawake
        beq +
        
        lda #$a377
        sta $0fa8       ;ridley function = a377
        
    +   rts
    }