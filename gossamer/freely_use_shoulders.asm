lorom

org $82f5d0
	bra $2f

org $82f5d5
	bra $2a

org $82f607
	bra $2f

org $82f60c
	bra $2a

org $918247
	bra $00

org $91825d
	bra $00

org $9182b2
	bra $00

org $9182c8
	bra $00

;hex tweak version:

;$175D0 from F0 to 80
;$175D5 from F0 to 80
;$17607 from F0 to 80
;$1760C from F0 to 80
;$88247 from F0 07 to 80 00
;$8825D from F0 07 to 80 00
;$882B2 from F0 07 to 80 00
;$882C8 from F0 07 to 80 00
;note from Vener: BRA $00 is one cycle faster than NOP NOP