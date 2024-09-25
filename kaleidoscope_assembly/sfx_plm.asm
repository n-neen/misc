lorom

!timer = $033e

org $84efd3
    dw #setup, #instlist

    setup:
        stz !timer
        
        sep #$20
        lda #%00101011
        sta $57
        rep #$20
        rts
        
    instlist:
        dw $86b4
