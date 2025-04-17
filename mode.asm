lorom

!mode = #$05        ;0, 5, and 7 are notable

org $8087b2
    lda !mode

org $828200
    lda !mode
    sta $2105
    sta $55

org $8283cc
    lda !mode

org $828469
    lda !mode

org $8284f6
    lda !mode

org $82a322
    lda !mode
