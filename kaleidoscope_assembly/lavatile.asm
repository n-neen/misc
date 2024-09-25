lorom

!94free = $94b22b

org $9498ac+8               ;air fool xray bts 04
    dw #tile
    
org !94free
    tile:
        jsl $808111
        and #$2fff
        clc
        adc $0a4e
        sta $0a4e
        
        ;lda #$0002
        ;sta $0ad2
        
        rts
        