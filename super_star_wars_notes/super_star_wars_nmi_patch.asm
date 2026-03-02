;nmi handler patch

;vanilla game does

;sep #$20
;lda #$80
;pha
;plb
;rep #$20

;but also never switches from bank $00 (where the interrupt vector places us)
;to fastrom (bank $80)

org $80a038             ;8 bytes here
    jml fastrom         ;4
    fastrom:            ;
    phk                 ;1
    plb                 ;1
    bra $00             ;2