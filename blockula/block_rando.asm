lorom

;blockula

optimize dp always
optimize address mirrors

;ram labels
w_counter       =       $0336
w_ramdraw       =       $07ed
l_levelata      =       $7f0002
l_bts           =       $7f6402

org $82eebb             ;smile 2.5 ceres skip
db $05

org $828b8e             ;hijack for main
    jsr main
    nop #7

org $82eb8b             ;hijack in door transition
    jsr clearcounter
    nop

org $82f800             ;freespace in $82 for our main routine =========

main: {
    lda.w w_counter
    inc
    sta.w w_counter
    ;cmp #$1000
    ;bpl .end
    
    lda $0dc4
    pha
    
    jsl $808111
    cmp #$6402
    bmi +
    
    sec
    sbc #$6402
    
    cmp #$6402
    bmi +
    
    sec
    sbc #$6402
    
    +
    lsr
    sta $0dc4
    
    lda.w #climb
    jsl $8484e7
    
    pla
    sta $0dc4
    
    rts
    
    .end:
    rts
}

clearcounter: {
    stz w_counter
    
    jsl $8fe8a3
    rts
}

; ================================================ bank $84 ================================================

org $84b78b
dw phantoondoorbtsfix       ;init routine for plm type $b78b (phantoon door)

org $84efd3

climb: {
    dw .init, .list
    
    .init: {
        ;y = plm index
        ;x = plm type for some reason
        
        phx
        phy
        
        ;lda $1c87,y
        ;write a loop to iterate over the plm array for block indices and check for an extant plm
        
        
        lda $05b8               ;nmi counter
        bit #$0001              ;if &1
        bne .delete             ;return
        
        eor $05e5               ;else, 
        sta $05e5               ;eor nmi counter with random number then generate random number
        
        jsl $808111             ;random number
        and #$0007              ;clamp to 7
        
        asl
        tax
        
        ;construct a draw instruction in ram
        lda #$0001              ;$0001
        sta w_ramdraw
        
        lda.l climb_typelist,x  ;$[block type and gfx index]
        sta w_ramdraw+2
        
        stz w_ramdraw+4          ;terminator
        
        ;write bts
        lda.l climb_btslist,x
        and #$00ff
        pha
        
        lda $1c87,y             ;plm block index
        lsr
        tax
            
        pla                     ;bts from stack
        sep #$20
        sta.l l_bts,x           ;write bts (one byte)
        rep #$20
        
        ply
        plx
        rts
        
        .delete:
        
        ply
        plx
        tyx                     ;plm index was in y, now in x for deletion
        jsr $86bc
        rts
    }
    
    .list: {
        dw $0001, w_ramdraw         ;draw instruction
        ;dw $8af1 : db $04          ;set bts (not used)
        dw $86bc                    ;delete
    }
    
    .draw: {
        ;not used anymore
        dw $0001, $f05f             ;blomb blockm tile $5f (cre block)
        dw $0000
    }
    
    .typelist:
    dw $a056,       ;normal spike
       $2856,       ;air spike
       $805f,       ;solid
       $f058,       ;bomb
       $f058,       ;bomb
       $c052,       ;shot
       $c052,       ;shot
       $b0bc        ;crumble
    
    .btslist:
    dw $0000,       ;normal spike
       $0002,       ;air spike
       $0000,       ;solid
       $0004,       ;bomb
       $0004,       ;bomb
       $0004,       ;shot
       $0004,       ;shot
       $0004        ;crumble
}

phantoondoorbtsfix: {
    ;y = plm index
    
    phx
    
    lda $1c87,y                 ;plm index
    
    lsr                         ;/2 for bts index
    tax
    
    sep #$20
    {
        lda #$00
        sta.l l_bts,x           ;bts of plm tile
        sta.l l_bts+$10,x       ;one tile down
        sta.l l_bts+$20,x       ;two tiles down
        sta.l l_bts+$30,x       ;three tiles down
    }
    rep #$20
    
    plx
    rts
}


;chargeblock: {
;maybe not a good idea
;    dw .init, .list
;    
;    
;    .init: {
;        ;
;        rts
;    }
;    
;    .list: {
;        dw $0001, chargeblock_draw  ;draw instruction
;        dw $8af1 : db $4e           ;bts = $4e
;        dw $86bc                    ;delete
;    }
;    
;    .draw: {
;        dw $0001, $c05f     ;block type $c (shot), tile graphic $5f
;        dw $0000
;    }
;}
;
;org $949ea6+($4e*2)
;dw chargebts