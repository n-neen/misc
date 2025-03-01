lorom

;got bored of this pretty quick
;gachatroid disassembly of some plm whatever

org $848968                 ;hijacking etank collection
    jsr $f1f7
    jsr $f030
    rts
    
org $84f1f7
    php
    sep #$20
    
    lda $7ed8ae
    inc
    sta $7eedae
    
    lda $7ed892
    cmp #$01
    bcc +
    dec
    sta $7ec892
    
    rep #$20
    
    jsr $f0c0
    
    plp
+   rts
