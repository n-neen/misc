lorom

;polly esther (monogamous)
;taken from gossamer

;========================subtractive math, no math on bg2========================
;replaces the vanilla layer blending type $24

;without layer 3 this looks like $16
;with water this has color math on layer 3 and 1 but not 2. neat effect not obtainable with vanilla code
;wrote this a long time ago, some of this doesn't make sense to include, like the window stuff
;but i don't feel like looking critically at it rn.
;also newblend is a copy/paste of this with layer 3 disabled

org $88803e+$30
    dw #newblend


org $888156         ;have space until $817a
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

org $8880d4
    lda #$bf
    
org $88f200         ;have space until $817a
    newblend:
	lda #$00
	sta $6d         ;don't disable any of the subscreen area
	lda #$13
	sta $69         ;direct coor, enable subscreen, enable sprites in window area
	lda #$02
	sta $6b         ;subscreen layers = bg2, bg3
	lda #$a1
	sta $71         ;force main screen black inside window, color math in window, direct color
	lda #$95
	sta $73         ;subtractive, enable math on: sprites, bg3, bg1 = 95
    ;ldy #$02
rts