;================================================VOIDDRAGON================================================

org $A6A450					;music change on ridley appear
nop : nop : nop : nop		;skip music change on ridley appear

org $A6C0B6
nop : nop : nop : nop		;note to self: comment what this does

org $A6DFF1
lda #$0020		;ridley tail damage
nop

org $869408					;ridley flame damage
dw $5003, $5001, $5050		;second byte of the middle one


org $A6C5ED			;this used to be music change on ridley death. this is when we will SOMEHOW EXIT THE ROOM
jsl voiddeathdoor
nop

org $84efd3
voiddeathdoor:		;there. this is much easier than botwoon wall plm. blegh
	jsl $8483D7
	db $01,$17		;location
	dw $C848		;grey door facing right
	rtl

