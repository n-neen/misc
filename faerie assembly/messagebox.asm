lorom

;right out of kaleidoscope

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
    
    
    
;---------------------------------------------------------------   
org $85817b  ;21 bytes
    nop #21                        ;commented out 3/1/25 for testing tundain's patch
;---------------------------------------------------------------   
   
    
    
;tentatively ok, written on feb 15th but commented out for testing:
                                                        ;y increase on return
                                                        
                                                        
;COMMENTED OUT FOR TESTING 3/1/25
org $8488eb                 ;beam                       ;3
    jsr boxhijack
    nop
    
org $848912                 ;major item (xray excluded) ;3
    jsr boxhijack
    nop

org $84897f                 ;etank                      ;2
    jsr boxhijack
    nop
    
org $8489a2                 ;reserve                    ;2
    jsr boxhijack
    nop
    
org $8489cb                 ;missile                    ;2
    jsr boxhijack
    nop
    
org $8489f4                 ;super                      ;2
    jsr boxhijack
    nop

org $848a1d                 ;pb                         ;2
    jsr boxhijack
    nop

    
org $84b7ef : {
    boxhijack: {
        phy
        phx
        
        lda #$0010
        jsl $82e118
        
        jsl $82be17
        
        ldx #$0168
        .loop:
        jsr waitforlag  ;\
        phx             ;|
        jsl $808f0c     ;|
        jsl $8289ef     ;} play [x] lag frames of music and sound effects
        plx             ;|
        dex             ;|
        bne .loop       ;/
        
        plx
        ply
        rts
    }
    
    waitforlag: {
        php
        sep #$20
        lda $05b8
        .loop:
        cmp $05b8
        beq .loop
        plp
        rts
    }
}

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