lorom

!exp = $05ed
!lvl = $05ef
!expincamount = $7f6402		;starting location of where BTS data is loaded

org $A0A40A
	jsr enemycounter

org $A0B800
	enemycounter:
	clc
	lda !expincamount	;get bts value (not type) from top left (first in room) tile, and use this to increase exp
	adc !exp			;add this to exp counter
	sta !exp
	jsl lvlcheck
	jsl exphud			;go to exp hud drawing
	inc $0e50
rts

org $80CD8E			;$80 freespace
	exphud:
	LDA #$9DD3		;ifb told me to put this here
	STA $00			;|
	LDA #$0080		;|
	STA $02			;_
	
	lda !exp		;value to draw (current xp)
	ldx #$00ac		;location
	jsr $9D78		;"draw three hud digits"
	
	LDA #$9DD3		;ifb told me to put this here
	STA $00			;|
	LDA #$0080		;|
	STA $02			;_
	
	lda !lvl		;value to draw (current level)
	ldx #$002c		;location
	jsr $9d98		;"draw two hud digits"
rtl


org $82f800
	lvlup:
	inc !lvl		;make level one more
	jsl exphud
	
	lda #$0017		;msg box index 17. former save box
	jsl $858080		;display it
	
	;delay some frames so message box is not accidentally cleared. but how? no clue but it will go here
	
	cmp #$0000		;previous routine returns A as 0 or 2 depending on msg box selection
	beq lvl_tank
	
	lvl_missile:
		inc $09c6		;$Samus missiles
		inc $09c8		;Samus max missiles
		lda.w #$0037	;sound 37 (hud selection click)
		jsl $809021		;queue sound, library 1, max sounds allowed=15
		jsl $8099CF		;add missiles to hud
		jmp endlvl
	lvl_tank:
		lda $09c2			;Samus health
		CLC : ADC #$000F
		sta $09c2
		lda $09c4			;Samus max health
		CLC : ADC #$000F
		sta $09c4
		lda.w #$0001		;sound 01 (health pickup)
		jsl $8090AD			;queue sound, library 2, max sounds allowed=9
	endlvl:
rtl

org $82f857
	lvlcheck:
	lda !lvl			;current lvl, starts at 0, cleared below at clearexpandlvl
	asl					;shift left = multiply by 2
	tax
	lda.l exptable,x	;look at table at lvl*2th entry
	cmp !exp			;compare to current exp
	bmi lvlup			;if table entry is lower, then we've passed threshold for current lvl, goto lvlup
rtl
			
org $82ff00
	exptable:
	dw $000a, $0018, $002d, $0040, $0064, $00a4, $00c8, $00ff, $00ff, $00ff, $00ff, $00ff, $00ff, $00ff, $00ff
	;10, 25, 45, 64, 100, 164, 200, 255
	;only levels up when the exp becomes larger than these numbers, not reaches them

;clear exp and lvl on death
org $8193F6
	jsl clearexpandlvl		;hijack

org $81ff60
	clearexpandlvl:
	JSL $808FC1				;this is what we overwrote so put it back here
	lda #$0000				;zero get
	sta !lvl				;zero write
	sta !exp
rtl