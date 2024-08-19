lorom

!randomdelay = $0362			;delay to play once per room
!delaycounter = $0364			;count frames until you reach the above
;free until 036f

;only works properly in rooms where songset $24 is loaded
;at least for the draygon roar. could be made to do kraid too

org $8fe99b						;random draygon roar init asm :just initializes the counter and picks the number of frames to delay
	jsl $808111					;totally random number
	lsr : lsr : lsr
	sta !randomdelay
	lda #$0000
	sta !delaycounter
rts

org $8FE9AD						;main asm
	ldx !randomdelay			;the number to reach
	inc !delaycounter			;the current frame
	cpx !delaycounter
	bne end
	
	lda #$0073		;draygon roar
	jsl $8090CB		;play library 2 sound, max 6
	jsr $e99b		;run init again to reset counter and pick a new delay
	
	end:
rts