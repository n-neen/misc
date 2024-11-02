lorom

incsrc ./macros.asm

!samusx             =   $0af6
!samusy             =   $0afa

!torizohitcounter   =   $0364
!handletorizohit    =   $888fba

;==========================================================bt

org $aac90f
    nop #4          ;skip haze


org $aac95f         ;starting location
    dw $00e5        ;x position
org $aac963
    dw $01a2        ;y position

org $a0bab1
    and #$007f
org $a0bab5         ;drop spawn positions
    adc !samusx     ;x
    skip 5
    and #$0f00
org $a0bac2
    adc !samusy     ;y
    
;==========================================================gt
    
;gt palette

macro torizo_palette_copypaste()
    sta $7ec340,x       ;target palette 2
    skip 3
    sta $7ec3e0,x       ;target palette 7
endmacro

org $aac257
    %torizo_palette_copypaste()

org $aac29f
    %torizo_palette_copypaste()
    
org $aac287
    %torizo_palette_copypaste()
    
org $aac26f
    %torizo_palette_copypaste()
    
org $aac2b7
    sta $7ec140,x       ;palette 2
    skip 3
    sta $7ec1e0,x       ;palette 7
    
org $aac8c8             ;this forces palette (inside init routine)
    nop #3

org $aab271
    lda #$8400          ;$8000 = palette 7, $0400 = palette 2
                        ;individual bits here before calling a palette fade routine in $82

;gt starting location

org $aac961
    dw $0300        ;x
    
org $aac965
    dw $0030        ;y
    
org $aad5ca         ;gt samus x position trigger
    lda #$0300
    cmp $0af6
    bmi $0c
    
org $aacad1
    cmp #$0170      ;gt fall check
    bpl $05
    
    
;gt hurt reaction

org $aad3bd
    jsr gthurtreaction

org $aaff00
    gthurtreaction:
    
    jsr $c620
    
    lda !torizohitcounter
    clc
    adc #$0003
    sta !torizohitcounter

    rts
    

org $8ff8a0         ;main room routine for gt's room
    lda !torizohitcounter
    beq +
    
    sep #$20
    lda $77
    eor #%00001000        ;#$08
    sta $77
    rep #$20
    
    dec !torizohitcounter
    rts
    
+   stz $77
    rts



;==========================================================STATUE CRASH

org $84d3c3
    dw $86bc        ;skip music change from bt crumbling plm

org $86a4c3+4
    dw $832d

org $86a4d4+4
    dw $832d

org $86a4e5+4
    dw $832d

org $86a4f6+4
    dw $832d

org $86a507+4
    dw $832d

org $86a518+4
    dw $832d

org $86a529+4
    dw $832d

org $86a53a+4
    dw $832d

org $86a54b+4
    dw $832d

org $86a55c+4
    dw $832d

org $86a56d+4
    dw $832d

org $86a57e+4
    dw $832d

org $86a58f+4
    dw $832d

org $86a5a0+4
    dw $832d

org $86a5b1+4
    dw $832d

org $86a5c2+4
    dw $832d

