lorom

;ridley area checks. just change all check for area 2 into 5

org $a6a15f
    cmp #$0005
    
org $a6a36c
    cpy #$0005
    
org $a6a427
    cmp #$0005
    
org $a6a46c
    cmp #$0005
    
org $a6a47b
    cmp #$0005
    
org $a6d917
    cmp #$0005
    
org $a6d93e
    cmp #$0005
    
org $a6df8d
    cmp #$0005
    
org $a6e4d5
    cmp #$0005
    
;ridley palette fade-in (bg1/2, not sprite palettes)

org $a6a4d6
    rts
    
org $a6a1e0
    nop #8
    
