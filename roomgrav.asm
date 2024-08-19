lorom

!90free = $90f63a

;to use global gravity from physics table in bank $90, leave the roomvar = 0000
;if the roomvar is nonzero, use that value
;in the case you are using a room gravity and there are liquids,
;water gravity will be one quarter of that
;and lava will be one quarter of normal + 100

;=======================AIR=======================
org $909c7b
    ldy #$0000
    jsr jump
    
;======================WATER======================
org $909c91
    ldy #$0002
    jsr jump

;====================LAVA/ACID====================
org $909c9f
    ldy #$0004
    jsr jump

;=====================ROOMGRAV====================
org !90free                 ;argument:
    jump:                   ;y = 0, 2, 4 for air, water, lava/acid
        phx
        ldx $07bb           ;state header pointer
        lda $8f0010,x       ;roomvar (xray graphics pointer)
        cmp #$0000
        beq .globalgrav     ;if zero, branch down to normal table read
        cpy #$0002          ;if y = 2, we're in water
        beq .water
        cpy #$0004          ;if y = 4, we're in lava or acid
        beq .lava
        sta $0b32           ;else, store roomvar to samus y subunit acceleration
        plx
        rts
    .globalgrav:
        lda $9ea1,y         ;normal jump grav
        sta $0b32
        plx
        rts
    .water:                 ;y=2, a=roomvar
        lsr                 ;\
        lsr                 ; | gravity = roomvar / 4
        sta $0b32           ;/
        plx
        rts
    .lava:                  ;y=4, a=roomvar
        lsr                 ;\
        lsr                 ;|
        clc                 ;| gravity = [roomvar / 4] + $100
        adc #$0100          ;|
        sta $0b32           ;/
        plx
        rts

;=====================ROOMVAR=====================
;remove vanilla usage of roomvar (only in one room anyway)
;just change a BEQ into a BRA
org $84826a
    bra $2c