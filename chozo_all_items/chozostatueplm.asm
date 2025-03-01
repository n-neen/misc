lorom

org $84e007+$f
    dw #drawhijack, #drawhijack

org $84f000

    chozo:
        dw #.init, #.inst
        
        .init:
            rts
        
        .inst:
            dw $0001, #.draw                ;draw instruciton
            dw $86bc                        ;delete
        
        .draw:
            dw $0003, $80ff, $8045, $8046   ;top of chozo head
            db $00, $01                     ;relative location
            dw $0003, $8064, $8065, $8066   ;chozo hand, arm, back
            db $00, $02                     ;relative location
            dw $0003, $8047, $8048, $8049   ;chozo foot, leg, ass
            dw $0000
        
    drawhijack:
        phx
        lda $0dc4               ;back up block index
        pha
        
        ldx $1c27
        lda $1c87,x             ;get plm index
        lsr
        sta $0dc4               ;put in block index
        
        lda.w #chozo            ;spawn chozo plm at block index
        jsl $8484e7
        iny : iny
        
        pla
        sta $0dc4
        plx
        rts
        