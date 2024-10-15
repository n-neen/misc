lorom

!samusx         =   $0af6
!samusy         =   $0afa

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
    


org $aacad1
    cmp #$0170      ;gt fall height
    bpl $05
    
;gt palette

macro torizo_palette_copypaste()
    sta $7ec300,x       ;target palette 0
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
    sta $7ec100,x       ;palette 0
    skip 3
    sta $7ec1e0,x       ;palette 7
    
org $aac8c8         ;this forces palette (inside init routine)
    nop #3

;gt starting location

org $aac961
    dw $0300    ;x
    
org $aac965
    dw $0030    ;y
    
org $aad5ca     ;gt samus x position trigger
    lda #$280
    cmp $0af6
    bmi $0c

;=============================STATUE CRASH

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

