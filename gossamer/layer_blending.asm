lorom

;polly esther (monogamous)

;========================inverted color========================
;inverted color at $02

;jump pointer table is at $88803e

org $888040
dw #nonpbinverted		;this is the second entry in the table
                    ;transparency A or B: $02 in editor

org $88ee32			;in 8 bit mode here, sep (#$30)
inverted:
	lda #$06        ;06
	sta $69			;main screen=2,3
	
	lda #$13        ;13
	sta $6b			;subscreen=1, sprites
	
	lda #$13
	sta $6e 		;restrict color math to inside window
	
	lda #$bf		;bf
	sta $71			;color math on bg1,2,3, sprites 4-7, backdrop, subtractive math
    
    ;abandon all hope ye who enter here, the windowing settings
    
    lda #$02        ;window layer 1/2=
    sta $60
    
    lda #$c0        ;window layer 3=
    sta $61
    
    lda #$81        ;enable color math mask window 2
    sta $62
    
    lda #$30        ;window mask logic bg layers
    sta $67
    
    lda #$02        ;window mask logic sprites   
    sta $68
    
    lda #$00        ;main screen windowing disabling
    sta $6c
    
    lda #$04        ;subscreen windowing disabling
    sta $6d
rts

org $8880ca         ;type $16
    ldy #$06        ;now y = 6 instead of 4


;========================xray
org $88801f
;jsr twentyfour
;jsr $817b           ;can show blocks, vanilla
;jsr $8189            ;vanilla but skip masking
jsr inverted
;nop : nop : nop

org $88802b
;jsr twentyfour
;jsr $817b           ;can show blocks, vanilla
;jsr $8189            ;vanilla but skip masking
jsr inverted
;nop : nop : nop

org $88818b
    lda #$04        ;subscreen layers for xray, written to $6b color math register
org $888193
    lda #$04


;========================suit collection and pb changes========================
org $8880ab				;layer blending type $0A (i never use this normally)
	lda #$ff
	sta $71
rts

org $8880B8			;suit collection layer blending
	;jmp $80b0		;jmp to type $0c instead
	jmp nonpbinverted

org $888219	        ;pb color math when y = 0 or 2
    jmp $81db       ;subtractive
    ;jmp $ee32      ;inverted

org $88823e         ;pb color math when y = 4
    jmp $81db       ;subtractive pb
    ;jmp $ee32      ;inverted

org $888263         ;pb color math when y = 6
    jmp $81db
    ;jmp $ee32       ;inverted
	
	;possible pb color math replacements (all in 88)
	;80b0 - layer blending type $0c
	;817b - x-ray can show blocks (super cool)
	;81a4 - x-ray but can't show blocks
	;81db - x-ray in fireflea. i think this is the one
	;ee32 - new code, inverted color, see above


;========================subtractive math, no math on bg2========================
;replaces the vanilla layer blending type $24

;without layer 3 this looks like $16
;with water this has color math on layer 3 and 1 but not 2. neat effect not obtainable with vanilla code


org $888156		;have space until $817a
    twentyfour:
	lda #$00
	sta $6d			;don't disable any of the subscreen area
	lda #$13
	sta $69			;direct coor, enable subscreen, enable sprites in window area
	lda #$06
	sta $6b			;subscreen layers = bg2, bg3
	lda #$a1
	sta $71			;force main screen black inside window, color math in window, direct color
	lda #$95
	sta $73			;subtractive, enable math on: sprites, bg3, bg1 = 95
    ldy #$02
rts



;original research: "hey this is the first use of this phrase, here's a forum thread, i can find no earlier reference therefore it is true"
;not original research: "this notable publication did some research and i am including this in the article since it is thought to be true"
			;in 8 bit mode here, sep (#$30)
nonpbinverted:
    lda #$06
	sta $69			;main screen=2,3
	
	lda #$13
	sta $6b			;subscreen=1, sprites
	
	lda #$23
	sta $6e			;enable color math everywhere
	
	lda #$bf		;bf
	sta $71			;color math on bg1,2,3, sprites 4-7, backdrop, subtractive math
    
    ldy #$06
rts
