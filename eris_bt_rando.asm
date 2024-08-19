lorom

org $84free

;$7ed870,x
;bomb item=$32

    phx
    ldx #$0032
    jsl $80818e
    lda $7ed870,x
    and $05e7
    plx
    rts