lorom

!dontrunagain = $0336
!dontroaragain = $0338

org $9498b4			;air fool xray type 04 in table
	dw $b1ff

org $9498b6			;air fool xray type 05 in table
	dw $b209

org $9498b8			;type 06
	dw $b212

org $94b1ff			;what to do when samus touches air fool xray 04
	lda #$0006		;music track 6 (collection 24 already loaded in horror room)
	jsl $808fc1		;queue
	rts

org $94b209			;what to do when samus touches air fool xray 05
	lda #$0014
	jsl $8081fa		;set event $14 (use to wake up ship)
	rts

org $94b212			;type 06 - cf check in screw unlock room
	lda !dontrunagain
	cmp #$0000
	bne end
	
	lda $0a1c					; samus' pose
	cmp #$00d3					; crystal flash pose
	beq unlock
	cmp #$00d4					; crystal flash pose
	beq unlock
	
	end:
	rts
	
	unlock:
		lda #$0062				;maridia torizo dead (aka event $62) (does not exist)
		jsl $8081fa				;set it to unlock grey door
	
		lda #$0019				;sound $0019, g4 gem breaking, wooshing
		jsl $8090cb				;play it (library 2)

		lda #$0001
		sta !dontrunagain
		
		jsl $8483c3             ;clear plms
		
		rts
