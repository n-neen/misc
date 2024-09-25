lorom

;skip missile station message box
org $848cda
    nop : nop : nop : nop : nop : nop : nop

;skip energy station message box
org $848cb9
    nop : nop : nop : nop : nop : nop : nop

;skip save station saved game message
org $84b026
    nop : nop : nop : nop : nop : nop : nop

;skip gunship message boxes
org $a2ab1f
	;nop #12            this is now handled in ship.asm

;skip map station message box
org $848c9f
	lda #$0001
	jsl $90f084

;skip save station message box
org $848cf6
	lda #$0000 : nop
    
;hdma object hijack:---------------------------------------------------------------
    

;org $858089
;    jsr spawnobject
;    nop
    
    
;org $858148
;    jsr $8136
    
org $85817b  ;21 bytes
    ;nop #6
    nop #21

;xray notably absent from the following
;org $8488e1                 ;beam collection
;    jsl $88f100             ;see messagebox_hdma
;org $848908                 ;generic equipment
;    jsl $88f100             ;see messagebox_hdma
;org $848933                 ;grapple
;    jsl $88f100             ;see messagebox_hdma
;org $848978                 ;etank
;    jsl $88f100             ;see messagebox_hdma
;org $84899b                 ;reserve
;    jsl $88f100             ;see messagebox_hdma
;org $8489c4                 ;missile
;    jsl $88f100             ;see messagebox_hdma
;org $8489ed                 ;super
;    jsl $88f100             ;see messagebox_hdma
;org $848a16                 ;pb
;    jsl $88f100             ;see messagebox_hdma