lorom

;unfinished start of a weird idea
;idea was:
;tile type $6 now becomes air if [event]
;if ![event], it is solid
;or he other way around. whatever. i barely wrote anything so this does not work or do a dang thing

org $somewhere
    ldx $7f0000
-
    lda $7f0002,x
    and #$f000
    cmp #$6000
    beq +
    bne -
    
+   dex : dex
    bne -
    rts
    