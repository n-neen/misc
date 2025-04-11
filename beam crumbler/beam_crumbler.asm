lorom

org $94a175     ;horizontal shot reaction functions
shot: {
    .hotizontal: {
        dw #bumbler_spawn+8,  ;0    ;point at the "sec : rts"
           #bumbler_spawn,    ;1
           #bumbler_spawn,    ;2
           #bumbler_spawn,    ;3
           #bumbler_spawn,    ;4
           #bumbler_spawn,    ;5
           #bumbler_spawn,    ;6
           #bumbler_spawn,    ;7
           #bumbler_spawn,    ;8
           #bumbler_spawn,    ;9
           #bumbler_spawn,    ;a
           #bumbler_spawn,    ;b
           #bumbler_spawn,    ;c
           #bumbler_spawn,    ;d
           #bumbler_spawn,    ;e
           #bumbler_spawn     ;f
    }
   
    .vertical: {
        dw #bumbler_spawn+8,  ;0
           #bumbler_spawn,    ;1
           #bumbler_spawn,    ;2
           #bumbler_spawn,    ;3
           #bumbler_spawn,    ;4
           #bumbler_spawn,    ;5
           #bumbler_spawn,    ;6
           #bumbler_spawn,    ;7
           #bumbler_spawn,    ;8
           #bumbler_spawn,    ;9
           #bumbler_spawn,    ;a
           #bumbler_spawn,    ;b
           #bumbler_spawn,    ;c
           #bumbler_spawn,    ;d
           #bumbler_spawn,    ;e
           #bumbler_spawn     ;f
    }
}

org $94b19f
bumbler: {
    .spawn: {
        lda.w #bumbler_plm
        jsl $8484e7
        sec
        rts
    }


org $84efd3
    .plm: {
        dw #..init, #..list
        
        ..init: {
            rts
        }
        
        ..list: {
            dw $0004, #..draw_one
            dw $0004, #..draw_two
            dw $0004, #..draw_three
            dw $86bc    ;delete
        }
        
        ..draw: {
            ...one: {
                dw $0001, $0053, $0000
            }
            
            ...two: {
                dw $0001, $0054, $0000
            }
            
            ...three: {
                dw $0001, $00ff, $0000
            }
        }
    }
}

org $828b4b
hijack: {
    lda $09e2       ;if japanese text = on, 
    beq +
    jsr beamler     ;force wave beam
    nop 
    +
}
    
org $82f70f
beamler: {
    ;forced wavinization
    lda $09a6
    ora #$0001
    sta $09a6
    
    lda $09a8
    ora #$0001
    sta $09a8
    rts
}