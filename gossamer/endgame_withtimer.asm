lorom

!endcounter = $0611

org $8fff00			; main room asm, once per frame
	inc !endcounter
	lda #$0100		; frames to wait until ending game
	cmp !endcounter
	bmi	endgame
	rts
	
endgame:
        lda $0998
        cmp #$0008
        bne nope
	lda #$0026		; set game mode to $26 (transition to ending)
	sta $0998
    nope:
	rts
	
	
;setup for endgame counter
org $8fff90
	lda #$0000
	sta !endcounter		;make damn sure counter is 0
	rts