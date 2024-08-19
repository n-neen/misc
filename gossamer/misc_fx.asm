lorom

; oscillating transparency rewritten as a plm, see specialfx_plm_rewrite.asm

; ================================================================ pirate glow
;used in: maridia elevator, and any room using the next routine below
org $8ff144					;enemy 1 and drops color flash. use for yellow pirates post-draygon. main room asm
	lda $7ec12a
	inc
	sta $7ec12a				;enemy 1 palette c12a is good
	sta $7ec124
	
	ora $197C
	sta $7ec1a0				;sprite 5, drops, etc
	
	jsl $808111
	ora $05e5
	sta $7ec1a2
	
	jsl $808111
	ora $05e5
	sta $7ec1a4
	
	jsl $808111
	ora $05e5
	sta $7ec1a6
	
	jsl $808111
	ora $05e5
	sta $7ec1a8
	
	jsl $808111
	eor $05e5
	sta $7ec1aa
	
	jsl $808111
	eor $05e5
	sta $7ec1ac
	
	jsl $808111
	eor $05e5
	sta $7ec1ad
	
rts

;================================================================scrolling sky and pirate glow
;used in: predarkrit, challenge crag
org $8ff1a6				;don't forget to set init asm for scrolling sky
	jsr $c116			;scrolling sky main room routine
	jsr $f144			;pirate glow main room routine (above)
rts

;================================================================set backdrop
;init pointer gets run too early i guess so do this in main room code? lol ok
;used in: color hall, blue sidehoppers, bluroom
;could be replaced by the plm but whateverrrrr
org $8ff1ad
	lda $7f6402		;grab first tile of room, bts value
	sta $7ec000
rts


	;possible pb color math replacements (all in 88)
	;80b0 - layer blending type $0c
	;817b - x-ray can show blocks (super cool)
	;81a4 - x-ray but can't show blocks
	;81db - x-ray in fireflea. i think this is the one



	;0afa samus y
	;0AF6 samus x
		; 7ec000 backdrop
		; $7E:C032: FX primary (palette blend colour 0)
		; $7E:C034: FX secondary (palette blend colour 1)
		; $7E:C036: FX background (palette blend colour 2)
		;     $7E:C002: Acid highlight (02DFh)
        ;     $7E:C004: Acid bubbles (01D7h)
        ;     $7E:C006: Acid background (00ACh)


