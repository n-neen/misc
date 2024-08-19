lorom

!location  = $f000         ;place in 8f for the thing
!xpos      = $0100         ;samus x position to check for
!scrollnum = $10           ;xth screen to change scroll of

org $8f0000+!location
    lda $0af6
    cmp #$!xpos
    bmi setscroll
    rts
    setscroll:
    sep #$20
        lda #$02
        sta $7ecd20+!scrollnum
    rep #$20
    stz $07df
    rts
    