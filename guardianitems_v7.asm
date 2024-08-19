lorom

; `^,._.,^`^,._^`^,._.,^`^,._ chozo guardians as items _.,^`^,._.,^`^,._^`^,._.,^`
;for redesign rando

;version 6, rewritten plm

;plm type f627
;the chozo head item replacement for setting the event bits
    ;room argument:
    ;high byte  = unused
    ;low byte   = event index

;event bits used for the guardians in redesign are $30-3b.
;so the plm arguments you must supply to the 12 (or fewer) instances of this item are in the range $0030-003b
;3c marks tourian entrance as open, but has not been fully researched what crumbles the blocks

;the assembler will print out the location where the 16-bit value will need to be written
;for the number of guardians that are required to open tourian

;the original chozo guardian statues will not spawn, except the last one which unlocks tourian

;------------known issues:------------
;if you set the number of required guardians to 0, it will work but only if you do not collect any
;if you collect any then the seed will become permanently unbeatable (probably)
;the tourian entrance guardian will not tell you the correct number required for entry
;message boxes displayed when touching the item will not display correct sector numbers and area names

;==============================================DEFINES================================================

;redesign $84 freespace. two locations
!84freespaceone      = $f627            ;local address is plm type
!84freespacetwo      = $f800

;==============================================PLM================================================

org $840000+!84freespaceone
    chozoheadplm:
        dw .setup, .inst
    
    .setup:
        lda #$000a                    ;gfx index. todo: figure out whuh
        jmp $ee5f                     ;set gfx index and do standard item setup
    
    .inst:
        dw $887c, #.end               ;goto .end when room argument item is collected
        dw $8a24, #.link              ;set link instruction
        dw $86c1, $df89               ;set pre-instruction: go to link instruction when triggered
        .idle:
        dw $0001, #.chozodraw         ;draw instruction
        dw $8724, #.idle              ;loop while waiting
        .link:
        dw $8899                      ;set item as collected
        dw #.seteventinst
        .end:
        dw $8724, $dfa9               ;goto dfa9 (inst list for blank tile)
        
    .chozodraw:                       ;draw instruction
        dw $0001, $b045, $0000        ;one tile, item tile (type b), tile $45 (chozo head, face)
        
    .seteventinst:                    ;sets event bit from room argument and displays message box
        
        ldx $1c27
        lda $1dc7,x     ; \
        and #$00ff      ;  set event bit stored in plm argument low byte
        jsl $8081fa     ; /

        lda #$0020      ;message box $20
        jsl $858080
        
        rts
        
;==============================================CHOZO STATUE ENEMY==============================================

org $aae74f                 ;chozo statue init routine. overwrote some stz
    jsr inithijack
    
org $aae760                                     ;8 bytes here
    jsr handhijack
    nop #5
    
org $aaf7d7
    inithijack:
        phx
        phy
    
        stz $0f9a               ;the thing we overwrote
        lda $079b               ;room header pointer
        cmp #$a66a              ;tourian entrance chozo statue room
        beq .end                ;if we are in that room, end
    
        lda $0f86,x
        ora #$2200              ;200 bit = mark to delete. 2200
        sta $0f86,x             ;otherwise, delete enemy
    .end:
        ply
        plx
        rts
    
org $aaf927
    handhijack:
        lda $079b                   ;room header pointer
        cmp #$a66a                  ;tourian entrance chozo statue room
        bne .end                    ;if we are not in that room, end

        jsl $8483d7                 ;otherwise, we are in that room, spawn plm
        db $00, $00 : dw $d6d6      ;type d6d6, inexplicably at 00, 00; but this is what is in the hack so i trust in kej
    .end:
        rts
    
    
;==============================================CHOZO STATUE PLM==============================================
    
org $84d1b1
    jsr flexibleguardianamount
    nop #20
    
    
org $840000+!84freespacetwo     ;loop concept by strotlog
    flexibleguardianamount:
    phx
    phy
    
    lda.l $7ed826               ;this specific area of the event table we're talking about
    and.w #$0fff                ;reducing a to exactly the bits we care about
    
    ldx #$ffff                  ;initialize x for loop
    .loopinc:
    inx                         ;increment x for loop
    .loopnoinc:
    lsr                         ;shift a bit into carry if it exists
    bcs .loopinc                ;if it does then advance to the next bit by looping
    bne .loopnoinc              ;if 0, loop but do not increase x
    cpx numberofguardians       ;if x = the required number, then
    bpl .basedtourian           ;branch to set event 3c
    
    ply
    plx
    rts
    
    .basedtourian:
        lda #$003c
        jsl $8081fa             ;set event 3c
        ply
        plx
        rts
    
    org $84fffd
    numberofguardians:
        print "location to write guardian variable: ", pc
        dw $000c
    
;for inserting into game for testing purposes:
;org $8ffc36         ;landing site missile
;    dw $f627        ;plm type
;    db $4d, $4d     ;x,y - this is in the ground next to the ship
;    dw $0030        ;argument
    
;org $8ffc4e          ;landing site grey door top left
;    dw $f627
;    db $4f, $4d
;    dw $0035
