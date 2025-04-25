lorom

;minimap removal

;remove vanilla minimap enabling spots
org $80c4af
    nop #3
org $828767
    nop #3
org $82e1c4
    nop #3
org $8882f3
    nop #3
;org $90a921     ;main update minimap routine
;    nop #2      ;oops this also stops pause map from working
org $90f233
    nop #3
org $a490c4
    nop #3
    
org $90aa43
    ;rtl
    
org $90a7e2
    rtl

org $809af3
    nop #4
    
org $809aac
    ;cpx #$00c0  ;hud tilemap loop counter. vanilla = $00c0
    
    
;the writes to wram hud tilemap buffer:
org $90aab7
    nop #4
    
org $90aac7
    nop #4
    
org $90aade
    nop #4
    
org $90aaee
    nop #4
    
org $90ab1b
    nop #4
    
org $90ab2b
    nop #4
    
org $90ab59
    nop #4