;slow doors

lorom

!counter     = $a0      ;freeram
!waitframes  = #$0002   ;frames to wait during fadein and fadeout

org $82e1d6         ;hijack 1, game state $A
    jsr slowa

org $82e292         ;hijack 2, game state $B
    jsr slowb
    nop #6
    
org $82f900
    slowa:          ;each of these a, b, c functions just restores
        jsr $dfc7   ;whatever code we overwrote, and then go to the main
        jsl slow    ;slowing routine
    rts
    
    slowb:
        jsl slow
        lda $0943
        beq skiptimer
        jsl $809f6c
        skiptimer:
    rts
    
    slow:
        pha
        lda !waitframes
        sta !counter
        .loop:
            jsl $808338
            dec !counter
            bne .loop
        pla
    rtl
    
;bank 80 stuffffffffffffffffffffffffffffff

;org $80aeac
;    jsr slow80
;    nop
    
;org $80f000
;    slow80:
;        pha
;        
;        jsl $808338
;        jsl $808338
;        jsl $80a3a0
;        jsl $808338
;        
;        pla
;    rts