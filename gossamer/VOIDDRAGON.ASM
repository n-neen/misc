;================================================VOIDDRAGON================================================

org $A6A450					;music change on ridley appear
nop : nop : nop : nop		;skip music change on ridley appear

org $A6C0B6
nop : nop : nop : nop		;skip music change on death

org $A6DFF1
lda #$0030		;ridley tail damage
nop

org $869408					;ridley flame damage
dw $5003, $5020, $5050		;second byte of the middle one


org $A6C5ED         ;this used to be music change on ridley death. this is when we will SOMEHOW EXIT THE ROOM
jsl voiddeathdoor
nop

org $84efd3
voiddeathdoor:      ;there. this is much easier than botwoon wall plm. blegh

    jsl $8483d7     ;spawn plm
    db $01, $16     ;location
    dw $f33e        ;from wallcrumbler.asm, the wall crumbler to air
    
    jsl $8483d7
    db $00, $16
    dw $f370        ;from wallcrumbler.asm, the door tiles delete the graphics but reamain door tiles
    
    rtl

org $A6D47A
	cpy #$ffff		;skip right to what is normally the half health palette

