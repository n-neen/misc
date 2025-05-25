lorom

org $808000

;===========================================================================================
;======================================  DEFINES  ==========================================
;===========================================================================================

!localtempvar           =           $10
!localtempvar2          =           $12


!maincounter            =           $20
!nmiflag                =           $22
!nmicounter             =           $24
!framecounter           =           $26
!democounter            =           $28
!tilecounter            =           $2a
!palette                =           $2c
!paletteshifted         =           $2e
!tilebit                =           $30
!layer2flag             =           $32

!gamestate              =           $34
!debugstate             =           $36

!bg1x                   =           $40
!bg1y                   =           $42
!bg1tilemapshifted      =           !bg1tilemap>>8

!bg2x                   =           $44
!bg2y                   =           $46
!bg2tilemapshifted      =           !bg2tilemap>>8

!backgroundupdateflag   =           $48
!backgroundtype         =           $4a

!spriteaddrshifted      =           !spritestart>>13

!oamwramtable           =           $0500


;===========================================================================================
;======================================  B O O T  ==========================================
;===========================================================================================

seed:       ;some spice for teh graphics algorithm
    dw $6969, $6969


boot:
    sei
    clc
    xce             ;enable native mode
    jml setbank     ;set bank to $80
    setbank:
    
    sep #$20
    lda #$01
    sta $420d       ;enable fastrom
    rep #$30
    
    ldx #$1fff
    txs             ;set initial stack pointer
    lda #$0000
    tcd             ;clear dp register
    

clear7e:
    pea $7e7e
    plb : plb
    ldx #$fffe
-   stz $0000,x     ;loop to clear all of $7e
    dex : dex       ;definitely don't jsr to here or you'll obliterate your return address lol
    bne -
    
clear7f:
    pea $7f7f
    plb : plb
    ldx #$7ffe
--  stz $0000,x
    stz $8000,x
    dex : dex
    bne --
    

init:
    .registers:
        
        phk
        plb                 ;set db
        
        sep #$30
        lda #$8f
        sta $2100           ;enable forced blank
        lda #$01
        sta $4200           ;enable joypad autoread
        rep #$30
        
        
        ldx #$000a
-       stz $4200,x         ;clear registers $4200-$420b
        dex : dex
        bne - 
        
        ldx #$0082          ;clear registers $2101-2183
--      stz $2101,x
        dex : dex
        bne --
        
        sep #$20
        lda #$80            ;enable nmi
        sta $4200
        lda #%00010010      ;main screen = sprites, L2
        sta $212c
        
        lda.b #!spriteaddrshifted   ;sprite size: 8x8 + 16x16; base address c000
        sta $2101
        
        lda #$01                    ;drawing mode
        sta $2105
        
        lda.b #!bg1tilemapshifted   ;bg1 tilemap base address
        sta $2107
        
        lda #$22                    ;bg2/1 tiles base address (nibble apiece)
        sta $210b
        
        lda.b #!bg2tilemapshifted
        sta $2108
        
        lda #$ff                    ;gotta set the bg1 scroll
        sta $210e                   ;to -1 because of course we do
        sta $210e
        sta !bg1y
        sta !bg2y
        rep #$20
        
        jsl dma_clearvram                                      ;uncomment later
        
    ;fall through to main


;===========================================================================================
;======================================  M A I N  ==========================================
;===========================================================================================



main: {
    .stateinit: {
        stz !gamestate
    }
        
    .statehandle: {
        jsr waitfornmi
        inc !maincounter                ;main switch case jump table loop
        lda !gamestate
        asl
        tax
        jsr (main_statetable,x)
        
        jmp .statehandle
    }
        
    .statetable: {
        dw #setup           ;0
        dw #demo            ;1
        dw #gfxmod          ;2
    }
}

;===========================================================================================
;=================================    STATE 0:  SETUP    ===================================
;===========================================================================================

setup: {
    jsr waitfornmi
    jsr screenoff           ;enable forced blank to to the following dmas
    
    ;do stuff here like load graphics
    sep #$20
    lda #$01
    sta $212c
    rep #$20
    
    
    .graphics: {
        ldx #$4000
        -
        lda $8000,x
        sta $7f0000,x
        dex : dex
        bne -
    }
    
    jsr waitfornmi
    jsr screenon
    lda #$0001
    sta !gamestate          ;advance to game state 1 (splash screen)
    rts
}


;===========================================================================================
;===================================  STATE 1:  DEMO  ======================================
;===========================================================================================

reset: {
    ;pla
    ;jml main
    ;jml init
    ;jml boot
}

demo: {
    !kupdatebitmask     =       #$0013;<<2      ;13 is good
    !kmaxtile           =       #$001b
    !kdemolength        =       #$0080
    
    ;demo happens here
    
    lda !layer2flag
    beq .no2
    jsr layer2
    .no2:
    
    lda !maincounter
    bit #$0002
    beq +
    inc !democounter
    
    +
    lda !democounter
    cmp !kdemolength
    beq .changemode
    bit !kupdatebitmask
    bne .noupdate
    
    
    phk
    plb
    
    bra .tilemap_start
    
    .tilemap: {
        --
        stz !tilecounter
        bra +
        
        ..start:
        lda !tilecounter
        inc
        sta !tilecounter
        cmp !kmaxtile
        beq --
        +
    
        ldx #$0800
        -
        lda !tilecounter
        ora !paletteshifted
        ;ora !tilebit
        sta $7f6000,x
        
        lda !tilecounter
        ora !paletteshifted
        ;ora !tilebit
        ora #$c000
        sta $7f6002,x
        
        lda !tilecounter
        ora !paletteshifted
        ;ora !tilebit
        ora #$8000
        sta $7f6004,x
        
        lda !tilecounter
        ora !paletteshifted
        ;ora !tilebit
        ora #$4000
        sta $7f6006,x
        
        dex #8
        bpl -
    }
    
    
    .noupdate:
    
    lda !maincounter
    cmp #$0400
    bmi +
    lda #$0001
    sta !layer2flag
    +
    
    ;lda !maincounter
    ;bit #$0010
    ;beq +
    ;inc !bg2x
    ;bit #$0020
    ;beq +
    ;inc !bg1y
    
    
    +
    rts
    
    .changemode:
    lda #$0002
    sta !gamestate
    rts
}


patterndata: {
    dw $0000, $c000, $8000, $4000
    dw $4000, $8000, $c000, $0000
}

layer2: {
    ldx #$0800
    -
    
    lda !tilecounter
    ora !paletteshifted
    ora #$801d
    sta $7fa004,x
    
    lda !tilecounter
    ora !paletteshifted
    ora #$401d
    sta $7fa006,x
    
    lda !tilecounter
    ora !paletteshifted
    ora #$001d
    sta $7fa000,x
    
    lda !tilecounter
    ora !paletteshifted
    ora #$c01d
    sta $7fa002,x
    
    
    dex #8
    bpl -
    
    rts
}



;===========================================================================================
;==================================  STATE 2:  GFXMOD  =====================================
;===========================================================================================

cleargfx: {
    -
    lda $7e0000,x
    xba
    sta $7e0002,x
    dex : dex
    bne -
    bra gfxmod_backin
}

gfxmod: {
    .left: {
            
        
        lda !nmicounter
        bit #$0080
        bne cleargfx
        
        .backin:
        phx
        clc
        
        ldx #$0200
        
    -   lda $7f0000,x
        asl
        ora #$0001
        bcs +
        sta $7f0000,x
    --  dex : dex
        bne -
        
        plx
        lda #$0001
        sta !gamestate
        stz !democounter
        jsr paletteswitch
        rts
        
    +   sta $7f0000,x
        asl
        clc
        adc #$5555
        asl
        sta $7f0020,x
        bra --
    }
}

paletteswitch: {
    lda !palette
    cmp #$0007
    beq +
    inc
    sta !palette
    xba
    asl #2
    sta !paletteshifted
    inc !tilebit
    rts
    
    
+   stz !palette
    rts
}

;===========================================================================================
;===================================                   =====================================
;===================================    N    M    I    =====================================
;===================================                   =====================================
;===========================================================================================


nmi: {
    php
    phb
    phd
    pha
    phx
    phy
    
    phk         ;db=80
    plb
    lda #$0000
    tcd
    
    sep #$10
    ldx $4210
    ldx !nmiflag
    beq .return
    
    
    jsr updateppuregisters
    jsr layer2check
    ;after this point we abandon the whole sep #$10 thing i guess?
    
    jsl tilemap_upload
    jsl tilemap_upload2
    jsl graphics_upload
    
    ;jsr readcontroller
    ;jsr handlecontroller
    
    
    stz !nmiflag
    
    .return
    rep #$30
    ply
    plx
    pla
    pld
    plb
    plp
    inc !nmicounter
    rti
}

layer2check: {
    lda !layer2flag
    beq +
    
    ldx #$02
    stx $212d
    
    ldx #%10000111
    stx $2131
        
    ldx #%00000010
    stx $2130
    
    inc !bg2x
    ;dec !bg1x
    
+   rts
}


waitfornmi: {
    php
    sep #$20
    lda #$01
    sta !nmiflag
    rep #$20
    
    .waitloop: {
        lda !nmiflag
    } : bne .waitloop
    plp
    rts
}


screenon: {         ;turn screen brightness on and disable forced blank
    pha
    sep #$20
    lda #$0f
    sta $2100
    rep #$20
    pla
    rts
}


screenoff: {        ;enable forced blank
    pha
    sep #$20
    lda #$8f
    sta $2100
    rep #$20
    pla
    rts
}


readcontroller: {
    php
    sep #$20
    lda #$81            ;enable controller read
    sta $4200
    waitforread:
    lda $4212
    bit #$01
    bne waitforread
    rep #$20
    
    lda $4218           ;store to wram
    sta !controller
    plp
    rts
}



updateppuregisters: { ;transfer wram mirrors to their registers
    ldx !bg1x
    stx $210d
    stx $210d
    ldx !bg1y
    stx $210e
    stx $210e
    
    ldx !bg2x
    stx $210f
    stx $210f
    ldx !bg2y
    stx $2110
    stx $2110
    
    ldx #$01
    stx $2133
    rts
}



errhandle: {
    jml errhandle
}


irq: {
    rti
}


;7f0000 =   bg1 graphics buffer
;7f6000 =   bg1 tilemap buffer

;===========================================================================================
;===================================  D E F I N E S  =======================================
;===========================================================================================

;arguments for passing info between dma related routines
    ;(i.e. from loading routines to the dma ones)
!dmaargstart    =                   $80
!dmasrcptr      =                   !dmaargstart+0          ;2
!dmasrcbank     =                   !dmaargstart+2          ;2
!dmasize        =                   !dmaargstart+4          ;2
!dmabaseaddr    =                   !dmaargstart+6          ;2
!dmaloadindex   =                   !dmaargstart+8          ;2


;===========================================================================================
;================================  D M A    R O U T I N E S  ===============================
;===========================================================================================

;initiates up a dma to
    ;vram or cgram
    
    ;dma_vramtransfur
    ;dma_loadpalettes
    
    
dma: {
    .vramtransfur: {        ;for dma channel 0
    
                                                ;register width (bytes)
        !dma_control            =   $2115       ;1
        !dma_dest_baseaddr      =   $2116       ;2
        !dma_transfur_mode      =   $4300       ;1
        !dma_reg_destination    =   $4301       ;1
        !dma_source_address     =   $4302       ;2
        !dma_bank               =   $4304       ;1
        !dma_transfur_size      =   $4305       ;2
        !dma_enable             =   $430b       ;1
                            ;set to #%00000001 to enable transfer on channel 0
                            
                            
                            
        !dmaargstart    =                   $80                     ;start of dma arguments
        !dmasrcptr      =                   !dmaargstart+0          ;2
        !dmasrcbank     =                   !dmaargstart+2          ;2
        !dmasize        =                   !dmaargstart+4          ;2
        !dmabaseaddr    =                   !dmaargstart+6          ;2
        !dmaloadindex   =                   !dmaargstart+8          ;2
        
        
        sep #$20                    ;width  register
        lda.b #$80                  ;1      dma control
        sta $2115
        rep #$20
        
        
        lda !dmabaseaddr            ;2      dest base addr
        sta $2116
        
        sep #$20
        lda #$01                    ;1      transfur mode
        sta $4300
        
        lda #$18                    ;1      register dest (vram port)
        sta $4301
        rep #$20
        
        lda !dmasrcptr              ;2      source addr
        sta $4302
        
        sep #$20
        lda !dmasrcbank             ;1      source bank
        sta $4304
        rep #$20
        
        lda !dmasize                ;2      transfur size
        sta $4305
        
        sep #$20                    ;1      enable transfur on dma channel 0
        lda #$01                    
        sta $420b
        
        rep #$30
        
        
        rtl
    }

    .cgramtransfur: {
        sep #$20                    ;width  register
        
        lda.b !dmabaseaddr          ;1      cgadd
        sta $2121
        
        rep #$20
        
        ;lda !dmabaseaddr           ;2      dest base addr
        ;sta $2116
        
        sep #$20
        lda #$02                    ;1      transfur mode: write twice
        sta $4300
        
        lda #$22                    ;1      register dest (cgram write)
        sta $4301
        rep #$20
        
        lda !dmasrcptr              ;2      source addr
        sta $4302
        
        sep #$20
        lda !dmasrcbank             ;1      source bank
        sta $4304
        rep #$20
        
        lda !dmasize                ;2      transfur size
        sta $4305
        
        sep #$20                    ;1      enable transfur on dma channel 0
        lda #$01                    
        sta $420b
        
        rep #$30
        
        rtl
    }
    
    .clearvram: {
        sep #$20                    ;width  register
        lda.b #$80                  ;1      dma control
        sta $2115
        rep #$20
        
        lda #$0000                  ;2      dest base addr
        sta $2116
        
        sep #$20
        lda #%00011001              ;1      transfur mode
        sta $4300
        
        lda #$18                    ;1      register dest (vram port)
        sta $4301
        rep #$20
        
        lda #..fillword             ;2      source addr
        sta $4302
        
        lda #$fffe                  ;2      transfur size
        sta $4305
        
        sep #$20
        lda #$81                    ;1      source bank
        sta $4304

        
        lda #$01                    ;1      enable transfur on dma channel 0    
        sta $420b
        
        rep #$20
        
        rtl
    
        ..fillword: {
            dw $0000
        }
    }
}



oam: {
    
    .write: {
        phx
        php
        
        sep #$10                    ;8 bit x/y mode
        rep #$20                    ;16 bit A
        
        
        ldx #$00                    ;1      transfur mode
        stx $4300
        
        ldx #$04                    ;1      register dest (oam add)
        stx $4301
        
        ldx #$00                    ;1      source bank
        stx $4304
        
        lda #!oambuffer             ;2      source addr
        sta $4302
        
        lda #$0220                  ;2      transfur size = 544 bytes (oam table size)
        sta $4305
        
        ldx #$01                    ;1      enable transfur on dma channel 0             
        stx $420b
        
        plp
        plx
        rtl
    }
    
}


;===========================================================================================
;===================================  L O A D I N G  =======================================
;===========================================================================================
;set up a dma for a specific purpose


load: {
    ;label 'load' is just here for scope/logical reasons
    
    .graphics: {
        !dmaargstart    =                   $80                     ;start of dma arguments
        !dmasrcptr      =                   !dmaargstart+0          ;2
        !dmasrcbank     =                   !dmaargstart+2          ;2
        !dmasize        =                   !dmaargstart+4          ;2
        !dmabaseaddr    =                   !dmaargstart+6          ;2
        !dmaloadindex   =                   !dmaargstart+8          ;2
        
        
        
        phb
        php
        phx
        
        ;uhh
        
        plx
        plp
        plb
        rtl
    }
}


tilemap: {
    .upload: {
        ;layer 1
        lda #$6000
        sta !dmasrcptr
        lda #$007f
        sta !dmasrcbank
        lda #$0800
        sta !dmasize
        lda #!bg1tilemap
        sta !dmabaseaddr
        
        jsl dma_vramtransfur
        rtl
    }
        
    ..init: {
        ;call from newgame
        ;clear 7f6000-6800 for obj tilemap
        phb
        
        pea $7f7f       ;#$7f7f
        plb : plb
        
        ldx #$0800
    -   stz $6000,x
        dex : dex
        bne -
        
        plb
        rtl
    }
    
    
    .upload2: {
        ;layer 2
        lda #$a000
        sta !dmasrcptr
        lda #$007f
        sta !dmasrcbank
        lda #$0800
        sta !dmasize
        lda #!bg2tilemap
        sta !dmabaseaddr
        
        jsl dma_vramtransfur
        rtl
    }
}


graphics: {
    .upload: {
        lda #$0000
        sta !dmasrcptr
        lda #$007f
        sta !dmasrcbank
        lda #$0800
        sta !dmasize
        lda #!bg1start
        sta !dmabaseaddr
        
        jsl dma_vramtransfur
        rtl
    }
}

;warn pc