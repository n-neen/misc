lorom

;fx type $e
;uses liquid flag, the $20 bit

org $83ac18+$0e
functionpointer: {
    dw #noise_spawn
}

org $83abf0+$0e
tilemapointer: {
    dw #noise_tilemap
}

org $88f000
noise: {
    .spawn: {
        jsl $88840a             ;vanilla hdma object for bg3 scroll
        db $43, $11 : dw $d8d0
       
        lda #$0000              ;x value for each bg3 scroll (at hud)
        sta $7ecad8
        lda #$0000              ;y
        sta $7ecada
        lda #$0000              ;x, same for after hud
        sta $7ecadc
        lda #$e0e0              ;y
        sta $7ecade
        
        jsl $888435
        db $00, $85 : dw #scrollerobject    ;the object that randomly moves the tilemap

        rtl
    }
     
    org $8ae980
    .tilemap: {
        incbin "./noisetilemap.map"
    }
}

org $88ee84

scrollerobject: {
    
    ;re-implementing as hdma object that just does pre-inst
    
    .list {
        dw $8570 : dl #.preinst     ;set pre-instruction
        dw $8682                    ;sleep
    }
    
    .preinst: {
        ;writes to the post-hud portion of the indirect hdma table
        ;for the bg3 scrolls
        ;see noise_spawn for the addresses you would write to, here
        
        lda $197e               ;liquid bitflags
        bit #$0020
        bne +
        
        ;if ![$20 bit], do random scroll:
        jsl $808111
        xba
        sta $7ecadc             ;x scroll
        
        jsl $808111
        xba
        and #$0e0e
        ora #$e0e0
        sta $7ecade             ;y scroll
        
        rtl
        
        ;else, do fixed scroll:
    +
        lda $b1
        sta $7ecadc
        
        ;lda $b3
        ;sta $7ecade            ;hmmmmmmmm
        
        rtl
        
    }
}
