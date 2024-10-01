lorom

!heatdamage = $07D3

org $a0a4af			;running with speed echoes
ldy #$0032

org $a0a4ba			;shinespark
ldy #$0032

org $a0a4cc			;pseudoscrew
ldy #$0028

;;; fix to speed echoes bug when hell running
org $91b629
    db $01

;variable heat damage
org $8DE385
	ADC !heatdamage	;subunit health lost for heated room with no suit. vanilla = $4000

org $8fe99b		; heat damage setting room asm
	lda $0B42	; Samus X extra run speed (due to holding the run button) / shinespark X speed
	xba
	clc
	adc #$000F
	sta !heatdamage
	rts
	
;$0DBC	; samus x speed
;$0B42	; Samus X extra run speed (due to holding the run button) / shinespark X speed

;remove shinespark health drain:
org $90D0CE			;vertical
nop : nop : nop

org $90D0FD			;diagonal
nop : nop : nop

org $90D129			;horizontal
nop : nop : nop

;namihe fireball damage
org $86dfc4
dw $001b