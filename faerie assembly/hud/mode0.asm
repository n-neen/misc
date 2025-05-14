lorom

!bg4tilemapvram     =   $4000
!hudflag            =   $a1     ;whether or not we want to change drawing mode, etc. checked in nmihijack, set in flagset
!bg1xscrollbackup   =   $c1
!bg1yscrollbackup   =   $c3
!hudcolormath       =   $0e
!hudbitmaskpermode  =   $0336   ;whether or not we want to blank out the line below the hud
                                ;if game mode = 3, this is 0
                                ;otherwise, it is $80

;todo:
;       check draygon interrupts

org $80cd8e


irqcleanup: {
    ;8 bit A here
    
    
    ;we enter this routine with a known A
    ;to be stored in $212c
    ;however, we need to turn off the screen as fast as possible
    ;so keep it in x then do it after. i can't believe it matters
    
    tax
    
    lda !hudbitmaskpermode
    ora $51
    sta $2100
    
    txa
    sta $212c       ;the thing we overwrote (this hijack gets used several times!)
    
    ;this is where you get the fblank to do stuff
    lda $6b
    sta $212d       ;restore subscreen layers
    
    lda #$01
    sta $2105       ;mode back to 1
    
    ;lda $73
    ;sta $2131

-   lda $4212
    bit #$40
    beq -
    
    lda $51
    sta $2100
    
+   rts
}

waitforhblank: {
    ;ended up pasting this above to do away with the jsr/rts for timing reasons
    .end: {
    -   lda $4212
        bit #$40
        beq -
        rts
    }
    
    .start {
    -   lda $4212
        bit #$40
        bne -
        rts
    }
}

kraidcase:
    jmp kraidhandle

bg4handler: {
    ;we rep #$30'd right before coming here
    inc $05b6           ;the thing we overwrote
    
    
    jsr flagset         ;determine if we want to update the hud's bg4 in the current game mode
    
    lda $079f
    tax
    lda bg4tilemap_colormath,x
    sta !hudcolormath
    
    lda $179c
    cmp #$0003
    beq kraidcase
    
    lda !hudflag
    beq +
    
    .dma: {
        lda $079f                   ;area index as index into
        asl                         ;the hud tilemap pointer list
        tax
        
        lda.w bg4tilemap_list,x     ;2      source addr
        sta $4302
        
        lda.w #!bg4tilemapvram      ;2      dest base addr
        sta $2116
    
        lda #$0100                  ;2      transfur size
        sta $4305
    
        sep #$20                    ;width  register
        
        lda #$80                    ;1      dma control
        sta $2115
        
        lda #$01                    ;1      transfur mode
        sta $4300
        
        lda #$18                    ;1      register dest (vram port)
        sta $4301
        
        lda #$80                    ;1      source bank
        sta $4304
        
        lda #$01                    ;1      enable transfur on dma channel 0
        sta $420b
    }

    .baseaddresses: {
        ;cut these out of .hudsetup to remove cycles from hud start irq
        lda.b #!bg4tilemapvram>>8
        sta $210a       ;set bg4 tilemap base addr
        sta $5c
        
        lda.b #%01000100
        sta $210c       ;set bg4 tiles base addr
    }

    .screenlayers: {
        ;we run this in nmi for more time
        ;the hud is always the first thing that gets rendered,
        ;so who cares if this gets run at the end of nmi always
        ;oh shit what about pausing
        
        lda !hudflag
        beq +
        
        lda #%00000100  ;main screen: bg3, bg4
        sta $212c
        
        lda #%00001000  ;subscreen: bg4
        sta $212d
        
        lda #%00000011  ;enable subscreen
        sta $2130
        
        stz $2105       ;drawing mode = 0

        lda !hudcolormath
        sta $2131       ;previously set from list at bg4tilemap_colormath
        
        rep #$20
    }
    
    ;the following stuff does this:
    ;if game mode = 3, then !hudbitmaskpermode = 0
    ;else, it = $80
    ;this gets written to $2100 for a single scanline after the hud
    
+   
    lda $0998
    cmp #$03
    beq ++
    
        
    sep #$20
    lda #$80
    sta !hudbitmaskpermode
    rep #$20
    rts
    
++  rep #$20
    stz !hudbitmaskpermode
    rts
    
}

kraidhandle: {
    lda $179c
    cmp #$0003
    bne +
    ;warn pc
    sep #$20
    lda $51
    ora #$80
    sta $2100
    rep #$20
    stz !hudflag
    
+   rts
}

;game mode flag setting
;only want to run our nmi routine if we are in a mode where the hud exists

flagset: {
    lda $0998
    tax
    lda flagchecktable,x
    and #$00ff
    sta !hudflag
    ;lda $0998
    rts
}

flagchecktable: {
    ;list of booleans for whether we want to update hud with dma during nmi
    ;boolean   game mode
    db  $00,  ;0
        $00,  ;1
        $00,  ;2
        $01,  ;3    ;demoscene
        $00,  ;4
        $00,  ;5
        $01,  ;6    ;fadein
        $01,  ;7    ;fadein
        $01,  ;8    ;gameplay
        $01,  ;9    ;start of door
        $01,  ;a    ;door
        $01,  ;b    ;also door
        $01,  ;c    ;pausing fadeout
        $01,  ;d    ;load pause menu
        $01,  ;e    ;still loading pause menu
        $01,  ;f    ;paused
        
        $01,  ;10   ;unpausing
        $01,  ;11   ;unpausing
        $01,  ;12   ;unpausing
        $01,  ;13   ;unsure about death stuff, check this
        $01,  ;14
        $00,  ;15
        $00,  ;16
        $00,  ;17
        $00,  ;18
        $00,  ;19   ;death modes end here
        $00,  ;1a
        $01,  ;1b   ;reserve tanks auto filling
        $00,  ;1c
        $00,  ;1d
        $00,  ;1e
        $00,  ;1f
        
        $01,  ;20   ;made it to ceres elevator
        $00,  ;21
        $00,  ;22
        $00,  ;23
        $00,  ;24
        $00,  ;25
        $00,  ;26
        $00,  ;27
        $00,  ;28
        $00,  ;29
        $01,  ;2a   ;demo
        $00,  ;2b
        $00,  ;2c
        $00,  ;2d
        $00,  ;2e
        $00   ;2f
}

badhijack: {
    sta $2130
    
    lda $51
    ora #$80
    sta $2100
    rts
}

bg4tilemap: {
    .list: {
        dw #.crateria, #.brinstar, #.norfair
    }
    
    .colormath: {
           ;what to write to $2131
           ;crateria, brinstar.  norfair
        db %00001100, %00001100, %10001100      ;10001100
    }
    
    .crateria: {
        incbin "./bg4tilemap_crateria.map"
    }
    
    .brinstar: {
        incbin "./bg4tilemap_brinstar.map"
    }
    
    .norfair: {
        incbin "./bg4tilemap_norfair.map"
    }
}
;warn pc

;interrupt hijacks:

org $809692         ;skip changing color math and screen layers in the start hud irq for main gameplay
    bra +           ;11 bytes here. we actually want to bra over it to save cycles
    nop #6
+   jsr bg4handler_screenlayers

    skip 8
    ldx #$0098      ;h counter target for next interrupt (hud end) vanilla = $98. $88?
    
org $8096cf
    ldx #$0078      ;h counter target for begin hud drawing interrupt. vanilla = 98

org $8096ad
    jsr badhijack

org $8096bc         ;end hud irq hijack to prepare for gameplay, which is in drawing mode 1
    jsr irqcleanup  ;and put mode back
    
org $8096da         ;start of door: begin hud drawing
    nop #11

org $809703         ;start of door: end of hud interrupt
    jsr irqcleanup
    
org $809783         ;vertical door: end of hud interrupt
    jsr irqcleanup

org $80975c         ;vertical door: begin hud drawing
    nop #9
    
org $8097ec         ;horizontal door: end of hud interrupt
    jsr irqcleanup

org $8097c5         ;horizontal door: begin hud drawing
    nop #9

org $8095f4         ;main nmi hijack
    jsr bg4handler
    
org $8092cf         ;vanilla's nmi bg4 udpate
    bra +
    nop #18
    + 

org $809590
    jsr kraidhandle
    
    ;nop #4
    
    ;lda #$0000
    ;tcd

;pause menu edits

org $828dfc         ;changes drawing mode during pausing backup
    nop #5
    
org $82a0cb         ;changes bg4 tilemap base address for some reason
    nop #7
    
org $8290f6         ;nop out call to "update hud tilemap"
    nop #4
    
org $82ab4c
    ;normally, for some reason, the game backs up bg1 scroll positions to
    ;the bg4 scroll buffers. this is now a problem for us, so put them somehwere else
    sta !bg1xscrollbackup
    skip 2
    sta !bg1yscrollbackup
    
org $8293c9
    lda !bg1xscrollbackup
    skip 2
    lda !bg1yscrollbackup
    
org $8882fd         ;for some reason the hdma thing here sets the address to $2113 (bg4 x scroll)
    nop : nop
    