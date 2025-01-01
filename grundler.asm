lorom

;the grundler

!drawdone = $0000

org $a0c859
    dw #grundle, #grundle, #grundle, #grundle, #grundle, #grundle, #grundle, #grundle, 
       #grundle, #grundle, #grundle, #grundle, #grundle, #grundle, #grundle, #grundle
       
org $a0f7d3
    grundle:
        lda.w #grundler     ;d094 = normal enemy breakable tile plm
        jsl $8484e7
        lda #$8000
        sta $20
        clc
        rts
    
org $84efd3
    grundler:
        dw .init, .list     ;inst list from normal 2x2 crumble $caca
                            ;                      1x2 crumble $cab5
    
    .init:
        rts
        
    .list:
        dw $8c7c : db $0a       ;play crumblesound
        dw $0004, .draw_one     ;draw instructions
        dw $0004, .draw_two
        dw $0004, .draw_three
        dw $0001, .draw_blank
        dw $86bc                ;delete
        
    .draw:
        ..one:
            dw $8001, $0053     ;one tile, column, tile $53
            db $00, $ff         ;position for next draw
            dw $8001, $0053     ;one tile, column, tile $53
            db $00, $01         ;position for next draw
            dw $8001, $0053     ;the tile there
            dw !drawdone
        ..two:
            dw $8001, $0054
            db $00, $ff
            dw $8001, $0054
            db $00, $01
            dw $8001, $0054
            dw !drawdone
        ..three:
            dw $8001, $0055
            db $00, $ff
            dw $8001, $0055
            db $00, $01
            dw $8001, $0055
            dw !drawdone
        ..blank:
            dw $8001, $00ff
            db $00, $ff
            dw $8001, $00ff
            db $00, $01
            dw $8001, $00ff
            dw !drawdone