lorom

org $AAC91E


LDA $09A2		;equipped items
ORA #$4000		;OR against grapple bit
STA $09A2		;store again

LDA $09A4		;collected items
ORA #$4000		;OR against grapple bit
STA $09A4		;store again

RTL			;return


;LDA #$4000
;STA $09A2

;LDA #$4000
;STA $09A4

;RTL

