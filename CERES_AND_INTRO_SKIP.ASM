lorom

;org $8BA592                                ;this part skips the white text at the very beginning

;	LDA #$B72F : STA $1F51					;(set the LDA to #$A5A7 to enable the intro sequence)
											;starts loading green text and intro music

org $82eebb
    db $3a
    
    