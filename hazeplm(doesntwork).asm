lorom

org $84f700

hazeplm:
    dw .setup, .instlist
        
    .setup:
        jsl $88dd32
        rts
        
    .instlist:
        dw .setup
        dw $86bc       ;delete
        
org $88dd43
    lda #$0032          ;layer blending type for haze