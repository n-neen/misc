lorom

;=============================================================door changer plm===========================================================

;writes bts column, four tiles
;plm argument high byte is the byte to write

;=============================================regular defines
!plmentry =      $f300
!pbmax =         $09D0


;=============================================instructions
!downone =       $ab00
!delete =        $86bc

org $840000+!plmentry

dw #setup, #instructionlist

setup:
    lda !pbmax                  ;if pb max ammount =/= then delete plm
    bne havepeebs
    rts                         ;otherwise, continue
    havepeebs:
        ldx $1c27
        jsr $86bc               ;delete plm
        rts

instructionlist:
    dw #argumentbts, !downone
    dw #argumentbts, !downone
    dw #argumentbts, !downone
    dw #argumentbts, !delete

argumentbts:
    phx
    phy                         ;y=plm instruction list pointer
    ldx $1c27                   ;x=plm id
    lda $1c87,x                 ;a=plm block index
    lsr
    tax                         ;x=plm block index/2
    ldy $1c27                   ;y=plm index
    lda $1dc7,y                 ;a=plm argument
    xba
    sep #$20
        sta $7f6402,x           ;block index
    rep #$20
    ply                         ;restore y
    plx
    rts
;end f33d

;==========================================================================event bit setup===============================================================================

;set event bit $25, init room pointer (setup asm)
;this is the pre-np route event, by entering the DOLLAR AT THE BOTTOM OF THE POOL without pbs

org $8ff214
    lda !pbmax
    bne exit
    lda #$0025
    jsl $8081fa
    exit:
    rts

;next one is at alt space jump room, only reachable if event $25 is set
;event $25 spawns the green gate in red brin room
;then you have to do the gate glitch to reach alt space jump
;once you've done this, all the power bombs in the game despawn via event $26

;f221
    lda #$0026
    jsl $8081fa
    rts

;f230
    ;lda !pbmax              ;this is for dray-adjacent farm room.
    ;cmp #$0000              ;if you do try to leave red brin area with event $25 active
    ;bpl unset               ;in order to collect pbs and come back, this will unset event $25
    ;rts                     ;this room or through alt space jump room are the only ways out
    unset:
    lda #$0025
    jsl $808212
    rts
