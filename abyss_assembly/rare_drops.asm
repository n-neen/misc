lorom

; overall effect is that:
; pb and supers will drop regardless of if you have
; collected a tank or not (ignore max)

org $86F1B7
	nop : nop			;skip branch that does not enable supers to be dropped

org $86F1CE
	nop : nop			;skip branch that does not enable pbs to be dropped

org $91E004
	nop : nop			; skip capping pb to max on collect
	jsl handlepb

org $91DFE7
	nop : nop			;skip capping supers to max on collect
	jsl handlesuper

org $90ffee
	handlepb:
	JSL $809A1E			;add pb icon to hud
	inc $09D0			;if it's nonzero the number will be drawn
	rtl

	handlesuper:
	JSL $809A0E			;add super icon to hud
	inc $09CC			;if it's nonzero the number will be drawn
	rtl
