lorom

org $828b4b
    jsl iceshield
    nop #5


org $90f63b
    iceshield:
    lda $0bf0+6         ;projectile index is always 6 (per setup) so this is a known spot. good.
    bne +
    jsr $cdaa
+   rtl

org $90ac39
    lda #$0002
    sta $09a6
    sta $09a8
    sec
    rts