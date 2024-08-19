lorom

;=========================================================================================================bomb torizo

;skip making bt haze
org $aac90f
	nop : nop : nop : nop
    
;=========================================================================================================phantoon

;avoid phantoon room palette change
org $a7db56
	nop : nop : nop
	nop : nop

;skip phantoon music change
org $a7d542
	nop #7

;phantoon flames
org $869c31
	dw $8014		;damage is second byte
org $869c3f
	dw $4014		;damage is second byte
    
;=========================================================================================================kraid

;avoid kraid music change at start
org $a7c8b2	
	nop : nop : nop : nop
    

;kraid room turns on lights after death (overwrites music change)
org $A7C81B
	lda #$002a
	sta $1982
	nop
    
;=========================================================================================================message boxes

;skip missile station message box
org $848cda
    nop : nop : nop : nop : nop : nop : nop

;skip energy station message box
org $848cb9
    nop : nop : nop : nop : nop : nop : nop

;skip save station saved game message
org $84b026
    nop : nop : nop : nop : nop : nop : nop

;skip gunship message boxes
org $a2ab1f
	nop #12

;skip map station message box
org $848c9f
	lda #$0001
	jsl $90f084

;skip save station message box
org $848cf6
	lda #$0000 : nop
    
;=========================================================================================================item amounts

;chozo missile = 20 instead of 5
org $84e4a6
	dw $0014

;chozo e tank = 3 tanks
org $84e474
	dw $012c

;=========================================================================================================uncategorized D:

;checksum game name
org $80ffc0					;21 characters
	db "ghos a mer           "
	;db $67, $68, $6f, $73, $20, $61, $20, $6d, $65, $72, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20		;ghos a mer

;shak thorns
org $aaf7d3
	jsl $aadf34				;do normal shak touch routine, returns with long so gotta call long
	lda $0c2c				;samus projectile damage, probably
	lsr
	jsl $91df51				;i am rubber you are glue
rtl

org $84d6de		;mother brain glass tank plm entry (plm $d6de)
	dw $d5f6, $d20d
		;first word is setup routine pointer, unchanged
		;second word is instruction list pointer, vanilla is d202
		;changing to d207 skips the first part which deletes the plm if the main boss (type 010 is dead in the area)
		;update: changed to d20d to skip event check

org $88de80
	lda #$002a			;haze layer blending type

org $88de10
	lda #$00a0			;haze color

;=========================================================================================================prufrock reveal room setup routine
org $8ff200
	lda #$0000
	tax
	sep #$30
		loop:
			lda #$ff
			sta $07f7,x
			inx
			cpx #$fe
		bne loop
	rep #$30
rts

;=========================================================================================================hud

!hudoffset = #$00ca

;if you want to use this with message boxes be prepared to fix it

org $888331
    jsr hijack
    lda #$0000
    nop

org $88ee90
    hijack:
        lda !hudoffset
        sta $7ecad8
    rts

org $888383					;this fixes door transition redraw
    lda !hudoffset
    sta $b9
    nop : nop : nop

org $82a100					;this stops it updating during pausing
    nop : nop

;=========================================================================================================shot block item softlock prevention

org $84e03b
    dw $8a3a                ;return instruction in list
                            ;overwriting timer instruction


;etecoons

org $a7e910
    dw $0000            ;they hop up and down in place but do not run
    
;============================================================================================================title screen

;don't play baby metroid sounds
org $8BA25B
rts
org $8BA263
rts
org $8BA26B
rts

;don't spawn baby metroid
org $8B9A31
nop
nop
nop