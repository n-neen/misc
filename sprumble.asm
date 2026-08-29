lorom

; ========================= configuration ==========================
!bts_normal         =   $09
!bts_respawning     =   $0a
freespace94         =   $94df00     ;free space in bank $94 (4 bytes)
freespace84         =   $84f300     ;free space in abnk $84 ($4c bytes)

; =========================== bank $94 =============================
org $949139+(!bts_normal*2)     ;plm list for block type $b
    dw sprumble                 ;block subtype (bts)
org $949139+(!bts_respawning*2) ;plm list for block type $b
    dw respawning_sprumble      ;block subtype (bts)

org freespace94
spikelongshort: {
    ;the spike routine we want to run returns with rts
    ;so we can call it from an extrnal bank with this wrapper
    ;and avoid copying and pasting it into bank $84
    
    jsr $8e83       ;spike collision reaction
    rtl
}

; =========================== bank $84 =============================
org freespace84
respawning_sprumble: {
    ;plm entry for the respawning sprumble block
    
    ;init routine from the regular sprumble
    dw sprumble_init, respawning_sprumble_list
    
    .list: {
        dw $8c7c : db $0a       ;play crumblesound
        dw $0008, $a345         ;breaking animation frame 0
        dw $0006, $a34b         ;breaking animation frame 1
        dw $0004, $a351         ;breaking animation frame 2
        dw $0008, $a357         ;delay before reforming
        dw $0004, $a351         ;breaking animation frame 2
        dw $0006, $a34b         ;breaking animation frame 1
        dw $0008, $a345         ;breaking animation frame 0
        dw $0001, respawning_sprumble_draw_done
        dw $86bc                ;delete plm
    }
    
    .draw: {
        ..done:
            ;restores the correct tile type and graphic when tile reforms fully
            dw $0001, $b0bc     ;type $b, graphic $bc (crumble block)
            dw $0000            ;end draw instruction
    }
}

sprumble: {
    ;plm entry for the nonrespawning sprumble block
    
    dw .init, $ca8b     ;reuse normal 1x1 crumble instruction list
    
    .init: {     
        lda $0b02       ;collision direction
        and #$000f
        cmp #$0003
        bne ..delete    ;if direction =/= down, goto delete
        
        ;else (direction is down),
        jsl spikelongshort   ;run spike collision (in bank $94)
        
        sec             ;collision reaction plms rely on carry for solidity booleans
        rts             ;carry set = collision is solid
        
        ..delete:       ;delete plm
        lda #$0000
        sta $1c37,y
        
        sec
        rts
    }
}
