lorom

!bossindex      =       $09ec

org $b88000
    bossbit:
        .check:
            sep #$30
            ldx !bossindex
            lda .ordertable,x
            cmp #$ff
            beq +
            inc
            tax
        .toggle:
            lda $7ed828,x
            bit #$01
            beq +
            eor #$01
            sta $7ed828,x
+       rep #$30
        rtl
        
        .ordertable:
            db $01, $03, $04, $02, $01, $03, $04, $01, $02, $03, $04, $01, $03, $02, $04, $01, $03,
               $01, $04, $02, $03, $01, $04, $03, $02, $01, $04, $03, $01, $02, $04, $03, $01, $ff
           
            ;boss order:
            ;k p d r k p d k r p d k p r d k p k d r p k d p r k d p k r d p k  ;letters
            ;1 2 3 4 1 2 3 1 4 2 3 1 2 4 3 1 2 1 3 4 2 1 3 2 4 1 3 2 1 4 3 2 1  ;traditional boss order index
            ;1 3 4 2 1 3 4 1 2 3 4 1 3 2 4 1 3 1 4 2 3 1 4 3 2 1 4 3 1 2 4 3 1  ;area index for boss
            
            
org $828b4b
    jsl writehud
    nop #5

org $80cd8e
    writehud:
    lda #$9dd3      ;digit tile pointers
    sta $00
    lda #$0080
    sta $02
    
    phx
    ldx !bossindex
    lda.l bossbit_ordertable,x
    bpl +
    
    lda #$0099
    
+   and #$00ff
    
    ldx #$00ae		;location
    jsr $9d98		;"draw two hud digits"
    plx
    rtl

org $a7c597                     ;kraid hijack
    jsr kraidhijack
    nop
    
org $a7db65                     ;phantoon hijack
    jsr phantoonhijack
    nop

org $a7ff82
    kraidhijack:
        jsl bossbit
        inc !bossindex
        jsl $a0ba71             ;(the thing we overwrote) drops routine
        rts
    
    phantoonhijack:
        jsl bossbit
        inc !bossindex
        jsl $a0ba0b             ;(the thing we overwrote) drops routine
    
    
org $a592e2
    jsr draygonhijack
    nop
    
org $a5f95a
    draygonhijack:
        jsl bossbit
        inc !bossindex
        jsl $a0bb3d             ;(the thing we overwrote) drops routine
        rts
    
org $a6c5e6
    jsr ridleyhijack
    nop
    
org $a6febc
    ridleyhijack:
        jsl bossbit
        inc !bossindex
        jsl $a0b9a5
        rts