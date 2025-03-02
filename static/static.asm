lorom

;fx type $e

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
        
        jsl $8483d7
        db $00, $00 : dw #scrollerplm        ;the plm that randomly moves the tilemap
        
        rtl
    }
     
    org $8ae980
    .tilemap: {
        incbin "./noisetilemap.map"
    }
}

org $84f000

scrollerplm: {
    .header: {
        dw .init, .list
    }
    
    .init: {
        rts
    }
    
    .list {
        dw $86c1, #.preinst     ;set pre-instruction
        dw $86b4                ;sleep
    }
    
    .preinst: {
        ;writes to the post-hud portion of the indirect hdma table
        ;for the bg3 scrolls
        ;see noise_spawn for the addresses you would write to, here
        
        ;lda !someflag          ;if [condition], do fixed scroll
        ;beq +
        
        ;else, do random scroll
        jsl $808111
        xba
        sta $7ecadc             ;x scroll
        
        jsl $808111
        xba
        and #$0e0e
        ora #$e0e0
        sta $7ecade             ;y scroll
        
        rts
        
    +
        lda $b1
        sta $7ecadc
        rts
        
    }
}
