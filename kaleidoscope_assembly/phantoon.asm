lorom

incsrc ./macros.asm

!counter = $9e

;$09C4

;room changer hijack
org $a7db56     ;5 bytes
    jsr roomchange
    nop #2
    
	;nop : nop : nop : nop : nop
    
org $a7ff82
    roomchange:
    
    %laypowerbomb(0180, 0090)
    
    ;lda #$0180      ;power bomb explosion x position
    ;sta $0ce2
    ;lda #$0090      ;power bomb y position
    ;sta $0ce4
    ;jsl $888aa4     ;spawn pb explosion
    
    lda.w #roomasm  ;pointer to the below routine
    sta $07df       ;set main room routine pointer
    
    stz !counter
    
    rts
    
        
org $8ff800                     ;see "phantoon_roomdrawing_plm.asm"
roomasm:
    lda !counter                ;number of frames to wait before spawning plms
    inc                         ;this is to wait until the pb is at maximum fuzz
    sta !counter
    cmp #$0067                  ;$67 frames seems good. worried that lag might move this around
    bmi +
    
    jsl $8483d7
    db $10, $00 : dw $fb00      ;main screen drawing
    
    jsl $8483d7
    db $20, $02 : dw $fda5      ;one column just to the right of that
    
    sep #$20
    lda #$01
    sta $7ecd22                 ;unlock third screen
    rep #$20
    
    stz $07df                   ;zero main room routine pointer (don't run after this)
    
+   rts

org $a0ba1c
    adc #$0140                  ;+$100 to vanilla value. phantoon drops x location

;phantoon flames
org $869c31
	dw $8014		;damage is second byte
org $869c3f
	dw $4014		;damage is second byte
    
;phantoon transparency hdma object layer blend changings:

org $88e45e         ;6 bytes "vanilla = $0004, bg2 disabled"
    lda #$0004
    
org $88e466
    lda #$0016      ;our modified $04 tho

org $88e46e         ;"vanilla = $0004, bg2 disabled"
    lda #$0004
    
    
org $88803e+4       ;layer blend table, type 4 pointer
    dw #newfour
    
org $88f000
    newfour:
        lda #$11
        sta $69
        lda #$04
        sta $6b
        lda #$bf
        sta $71
        rts
    
    
;position fix (phantoon)

org $a7d881
    lda #$0180      ;vanilla = #$0080. phantoon x position
    
org $a7d849
    cmp #$0180
    
org $a7d705
    lda #$0130
    
org $a7d6f1
    lda #$01d0      ;vanilla = d0
    
org $a7dafe
    ;lda #$0280
    
org $a7d937
    cmp #$0160          ;adding $100 to vanilla cmps
    bmi $0b
    cmp #$01a0
    
;position fix (projectiles)

org $a7cdad+2       ;flame table. only touching x positions
    dw $0180
    skip 6
    dw $01a8
    skip 6
    dw $01d0
    skip 6
    dw $01a8
    skip 6
    dw $0180
    skip 6
    dw $0158
    skip 6
    dw $0130
    skip 6
    dw $0158

org $8698e0             ;flame rain x position fix
    jsr flamemover
    nop #6
    
org $86f500
    flamemover:
        lda $98f7,x         ;same as vanilla but with an added ``adc #$0100``
        and #$00ff
        clc
        adc #$0100
        rts
    
    flamemover2:
        ;lda #$0180
        lda $0f7a
        clc
        adc #$0100          ;same as vanilla but with an adc #$0100
        sta $1a4b,y
        rts
    
;org $869832
;    dw $983a, $986d    ;flame type pointer list

org $86989c
    jsr flamemover2
    nop #3

org $869922
    jsr flamemover2
    nop #3
    
org $869a63             ;enraged flame x position
    lda $0f7a
    
org $869a6e
    cmp #$0200          ;vanilla = #$0100. check x position of
                        ;enrage-mode flame to check for deletion
                        
org $869b17
    cmp #$0200          ;same as above but for the eye-open spiral