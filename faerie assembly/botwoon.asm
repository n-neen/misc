lorom

;edit high byte
!kxscreen       =       $0100
!kyscreen       =       $0100
!kyscreenxba    =       !kyscreen>>8


;botwoon hole locations
org $b3949b
        ;left,          right,          top,            bottom boundary
    dw  $003c|!kxscreen,$0044|!kxscreen,$006c|!kyscreen,$0074|!kyscreen,    ; left hole
        $007c|!kxscreen,$0084|!kxscreen,$00ac|!kyscreen,$00b4|!kyscreen,    ; bottom hole
        $009c|!kxscreen,$00a4|!kxscreen,$005c|!kyscreen,$0064|!kyscreen,    ; top hole
        $00dc|!kxscreen,$00e4|!kxscreen,$008c|!kyscreen,$0094|!kyscreen     ; right hole

org $86eba8         ;botwoon body contact damage
    db $20

org $86ec50         ;botwoon spit damage
    db $20

org $b3971b         ;botwoon health-based palettes
    ;dw $0000, $001A, $0008, $0000, $0000, $4455, $380C, $1800, $0000, $680F, $5008, $3000, $1800, $0000, $5F57, $0000
    ;dw $0000, $0858, $0007, $0000, $0000, $4094, $342B, $1400, $0000, $5C2E, $4827, $2800, $1400, $0000, $5F57, $0000
    ;dw $0000, $14B5, $0846, $0000, $0000, $40F3, $308B, $1442, $0000, $4C8D, $3847, $2021, $1000, $0000, $6358, $0000
    ;dw $0000, $2112, $0C66, $0000, $0000, $4152, $2CCA, $1463, $0000, $40CC, $3087, $1C42, $0C21, $0000, $6358, $0000
    ;dw $0000, $2951, $0C65, $0000, $0000, $4191, $2CEA, $1463, $0000, $38EB, $28A7, $1863, $0C21, $0000, $6759, $0000
    ;dw $0000, $318F, $1085, $0000, $0000, $41D0, $290A, $1484, $0000, $310A, $20C7, $1463, $0821, $0000, $6759, $0000
    ;dw $0000, $35AE, $1085, $0000, $0000, $41F0, $292A, $1484, $0000, $2D2A, $20C7, $1063, $0821, $0000, $6759, $0000
    ;dw $0000, $39CE, $14A5, $0000, $0000, $4210, $294A, $14A5, $0421, $294A, $1CE7, $1084, $0842, $0000, $6B5A, $0000
    
;health thresholds (for the above palettes):
    dw $0400, $0380, $0300, $0280, $0200, $0180, $0100, $0080
    
;death sequence body segment explosions

org $b39a86     ;clamp botwoon y coord
    cmp #$00c8|!kyscreen
    skip 2
    lda #$00c8|!kyscreen

;body projectiles

org $86eb4c     ;clamp body projectile y coord
    cmp #$00c8|!kyscreen
    skip 2
    lda #$00c8|!kyscreen
    
    
org $b3958f     ;botwoon's init routine
    nop #18     ;this is where the wall plm is spawned
                ;and also where the scroll is changed
                
org $b39add     ;botwoon death routine
    nop #8      ;this is where the wall crumbler is spawned
                ;drops happen immediately after
                
org $a0ba4f
    adc #$0040|!kxscreen        ;drops x position range
    
org $a0ba5c
    adc #$0080|!kyscreen        ;drops y position range