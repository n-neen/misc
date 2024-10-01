lorom

org $a8f9be			;a8 version

	lda #$0017		; sound 17 (space pirate lazer)
	jsl $80912F		; queue sound, library 3, max sounds allowed=9
				; 1c in library 2 (chozo hand sound) also good

	jsl $a0a477						; normal touch
	lda $09c4						; samus max energy
	dec								; reduce by one
	sta $09c4						; store
	rtl


org $a2f498			;a2 version

	lda #$0017		; sound 17 (space pirate lazer)
	jsl $80912F		; queue sound, library 3, max sounds allowed=9
				; 1c in library 2 (chozo hand sound) also good

	jsl $a0a477						; normal touch
	lda $09c4						; samus max energy
	dec								; reduce by one
	sta $09c4						; store
	rtl


org $b2feaa			;b2 version

	lda #$0017		; sound 17 (space pirate lazer)
	jsl $80912F		; queue sound, library 3, max sounds allowed=9
				; 1c in library 2 (chozo hand sound) also good

	;jsl $a0a477						; normal touch
	lda $09c4						; samus max energy
	dec								; reduce by one
	sta $09c4						; store
	rtl
