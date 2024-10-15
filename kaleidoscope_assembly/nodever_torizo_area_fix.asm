;You know how torizo acts differently based on area?
;Pretty annoying.
;This code simply replaces all area checks in Torizo's AI to check his speed value instead.
;In SMILE's enemy editor when you place Torizo in a room, change the speed value to change his behavior.
;0000 = he acts like BT
;anything else = he acts like GT.

;asm by Nodever2.
;Please let me know if there are any issues.

lorom

!AAFreeSpace = $AAF820

;THESE FIRST TWO SECTIONS ARE COMMENTED OUT, just are helpful torizo hex tweaks:
;To allow it to be placed correctly in SMILE: {
;org $AAC8E0 : db $EA, $EA, $EA			;9D 7A 0F to EA EA EA
;org $AAC8E6 : db $EA, $EA, $EA			;9D 7E 0F to EA EA EA
}


;Remove the gray haze from the bomb Torizo's room: {
;org $AAC90F : db $6B					;22 to 6B
}


;MAKES TORIZO CHECK SPEED ENEMY VARIABLE INSTEAD OF AREA FOR BEHAVIOR. USES FREESPACE IN $AA. {
;accompished by taking original values were LDA $079F, changing to run the subroutine LoadSpeed (which now loads Torizo speed variable into A)
;SPEED VALUES: 0000 = BT, anything else = GT.

org $AAB25E : JSR LoadSpeed						;torizo drop spawn routine
org $AAC2E0 : JSR LoadSpeed						;???
org $AAC620 : JSR LoadSpeed						;runs every frame?
org $AAC895 : JSR MoveSpeed : NOP : NOP : NOP	;seems to be the init check
org $AAC97C : JSR LoadSpeed						;shot reaction AI
org $AAC9C2 : JSR LoadSpeed						;???

;org $AAC907 : JSR LoadSpeed        ;This is for haze; use the above commented hex tweak to remove haze instead. THIS LINE OF CODE IS UNTESTED.
;org $AAE7AF : LDX $079F            ;DO NOT UNCOMMENT THIS, it would break things


org !AAFreeSpace
LoadSpeed:
PHX : LDX $0E54 : LDA $7E7804,x	;load enemy's speed variable into A
PLX : CMP #$0000 : RTS			;return, make sure zero flag is based on A and not that PLX

MoveSpeed:
PHA
LDX $0E54						;original code that was replaced by hijack, we need it here too anyways
LDA $0FB4,x : STA $7E7804,x		;move speed value to extra enemy RAM variable
LDA $7E7804,x : TAY
PLA : RTS						;return
}
