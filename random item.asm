;random item plm

;unfinished, broken, crashes
lorom

;==================================DEFINES==================================
    !blank              = $0000
    !plmentrylocation   = $f300

;===============================PLM STRUCTURE===============================

org $840000+!plmentrylocation
    plmentry:
        dw #setup, #instructionlist
    
    instructionlist:
        dw $86c1, #main, $86b4

    setup:
        rts
        
    main:
        ldx $1c27               ;x=plm id
        lda $1c87,x             ;a=plm block index in room
        lsr                     ;need to divide by two
        cmp $0dc4               ;compare to samus block
        bne end
        
        again:
        jsl $808111             ;get random number into $05e5
        lda $05e5
        and #$000f              ;take lowest four bits. max f
        lsr                     ;times two
        cmp #$0014
        bmi again               ;reroll if it's over $15 (21)
        tax                     ;into x
        lda items,y             ;
        ldx $1c27
        sta $1cd7,x
        
        
        ;jsr ($0000,x)           ;this crashes the game but why
        
        ldx $1c27               ;x=plm id
        jsr $86bc               ;delete plm
        rts
        
        end:
        rts





;================================ITEM TABLE=================================

items:                                  ;21 ($15) entries. 
    dw $e0b1, $e0d6, $e0fb, $e120       ;etank,  missile, super, pb
    dw $e14d, $e17b, $e1a9, $e1d7       ;bomb, charge, ice, hijump
    dw $e205, $e223, $e261, $e28f       ;speed, wave, spazer, spring ball
    dw $e2c1, $e2f6, $e32b, $e358       ;varia, grav, xray, plasma
    dw $e386, $e3b3, $e3e1, $e40f       ;grapple, space, screw, morph
    dw $e43d                            ;reserve