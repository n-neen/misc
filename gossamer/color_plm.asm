lorom

!plmentry		= $84F200				; this is directly after the special fx plm ends

org !plmentry
	dw #setup, #instructionlist

setup:
	
rts

instructionlist:
	dw $86c1, #main
	dw $86b4

main:
	lda $b5
	;lsr : lsr : lsr : lsr
	and #$000f
	adc $7ec000
	sta $7ec000
rts



;palette blend:
	;7ec032, c034, c036
;backdrop:
	;7ec000
;acid:
	;7ec002/4/6

;samus x
	;$0af6