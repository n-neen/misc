lorom

;da crumblah redux

org $9494d5+16
    dw #crumbler
    
org $9494f5+16
    dw #crumble2
    
org $94dc00
    crumbler:
        lda #hcrumb     ;horizontal
        jsl $8484e7     ;spawn crumble reaction block plm
        jmp $8f49
    crumble2:
        lda #vcrumb     ;vert
        jsl $8484e7     ;spawn crumble reaction block plm
        jmp $8f82


org $84fa00
    hcrumb:
        dw .setup, $dfa9
        
        .setup:
            rts

    vcrumb:
        dw $ce37, .inst
        
        .inst:
            dw $8c7c : db $0a       ;crumblesound
            dw $0008, .draw         ;eight frames of solid ground
            dw $0004, $a345         ;crumble animation frame one
            dw $0004, $a34b         ;                        two
            dw $0004, $a351         ;                        three
            dw $0001, $a357         ;                        four (air tile)
            dw $86bc                ;delete
            
        .draw:
            dw $0001, $80bc, $0000  ;one solid tile, tile $bc (crumble)
            