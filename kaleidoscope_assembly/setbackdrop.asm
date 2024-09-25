;================================================================set backdrop
;THIS IS NOW SETUP ASM, PLEASE UPDATE ALL ROOMS TO USE SETUP, NOT MAIN



org $8ff1ad
	lda $7f6402     ;grab first two tiles of room, bts value
    xba             ;do xba so we don't have to store the word endianly
	sta $7ec200     ;backdrop target
rts

;warn pc        ;f1b7
    lda $7ec192
    sta $7ec034
    rts
    
    
;warn pc         ;f1c0

    lda $7f6402
    sta $7ec000
    rts