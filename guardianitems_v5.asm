lorom

; `^,._.,^`^,._^`^,._.,^`^,._ chozo guardians as items _.,^`^,._.,^`^,._^`^,._.,^`
;for redesign rando

;plm type f627
;the chozo head item replacement for setting the event bits
    ;room argument:
    ;high byte  = unused
    ;low byte   = event index

;don't put two in the same room

;event bits used for the guardians in redesign are $30-3b.
;so the plm arguments you must supply to the 12 (or fewer) instances of this item are in the range $0030-003b
;3c marks tourian entrance as open, but does not iteself crumble the pathway

;the assembler will print out the location where the 16-bit value will need to be written
;for the number of guardians that are required to open tourian

;the original chozo guardian statues will not spawn, except the last one which unlocks tourian

;------------known issues:------------
;if you set the number of required guardians to 0, it will work but only if you do not collect any
;if you collect any then the seed will become permanently unbeatable (probably)
;the tourian entrance guardian will not tell you the correct number required for entry

;==============================================DEFINES================================================

;redesign $84 freespace. two locations
!84freespaceone      = $f627            ;local address is plm type
!84freespacetwo      = $f800

!plmID               = $093d            ;hopefully we don't find a comflict with already-used redesign things

;instruction pointers
!writebts            = $8af1
!goto                = $8724
!delete              = $86bc

;==============================================PLM================================================

org $840000+!84freespaceone
    chozoheadplm:
        dw .setup, .inst
    
    .setup:
        phx                     ;i don't think we need to push x here?
        phy
        
        sty !plmID
        
        ldx $1c27
        lda $1dc7,x             ;if [low byte of plm room arguemnt]th event
        and #$00ff              ;is set, then delete plm
        jsl $808233
        bcs .delete
        
        ply
        plx
        rts
    
    .delete:
        ldx $1c27
        stz $1c37,x
        stz !plmID
        ply
        plx
        rts

    .inst:
        dw $0001, .chozodraw         ;draw instruction
        dw !writebts : db $04        ;bts = 4
        dw !goto, .inst              ;return to top

    .chozodraw:                      ;draw instruction
        dw $0001, $2045, $0000       ;one tile, air fool xray (type 2), tile $45 (chozo head, face)
    
    
    emptytile:
        dw .setup, .inst
        
    .setup:
        rts
            
    .inst:
        dw $0001, .emptydraw
        dw !writebts : db $00
        dw !delete

    .emptydraw:
        dw $0001, $00ff, $0000          ;one air tile, blank graphics (tile $FF, last of the CRE)

;==============================================BTS================================================

org $9498b4         ;air fool xray inside reaction pointer table, entry 4
    dw #guardianhead

org $94dc00         ;routine to run when samus touches bts $04 air fool xray tile (air spike)
    guardianhead:

    lda !plmID
    beq .end
    tax

    lda $1dc7,x     ; \
    and #$00ff      ;  set event bit stored in plm argument high byte
    jsl $8081fa     ; /
    
    lda #$0020
    jsl $858080     ;display message box 20                    ;how to know which one
    
    lda !plmID
    bne .delete
    
    .end:
        rts
    
    .delete:
        tax
        stz $1c37,x               ;delete plm
        
        lda.w #emptytile          ;draw an air tile with bts 00 in its place
        jsl $8484e7
        
        stz !plmID
        rts

;==============================================DOOR HIJACK==============================================

org $82e1c4
    jsr doorhijack

org $82f927
    doorhijack:
    stz $05f7               ;the thing we overwrote
    stz !plmID              ;we need to clear this during every room transition
    rts                     ;it will be written to during the PLM setup if one exists in the room
                            ;this happens later in the door transition
    
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
    
    
org $840000+!84freespacetwo                     ;by strotlog
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
    beq .basedtourian           ;branch to set event 3c
    
    ply
    plx
    rts
    
    .basedtourian:
        lda #$003c
        jsl $8081fa             ;set event 3c
        ply
        plx
        rts
    
    numberofguardians:         ;84f824
        print "guardian constant location: ", pc
        dw $0001
    