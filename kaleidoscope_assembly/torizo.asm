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

