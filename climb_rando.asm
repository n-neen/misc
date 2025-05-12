lorom

!counter        =       $0336

org $8ff000

main: {
    lda !counter
    inc
    sta !counter
    cmp #$1000
    beq +
    
    lda $0dc4
    pha
    
    jsl $808111
    sta $0dc4
    
    lda.w #climb
    jsl $8484e7
    
    pla
    sta $0dc4
    
    rts
 
+   stz $07dc
    rts
}

org $84efd3

climb: {
    dw .init, .list
    
    .init: {
        ;
        rts
    }
    
    .list: {
        dw $0001, climb_draw        ;draw instruction
        dw $8af1 : db $80           ;set bts to $80 (for slope flip)
        dw $abd6                    ;move plm right one block
        dw $8af1 : db $80           ;set bts to $80 (for slope flip)
        dw $86bc                    ;delete
    }
    
    .draw: {
        dw $0002, $16f5, $12f5
        dw $0000
    }
        
}