lorom

!pose       = $0a1c
!hyperflag  = $a0
!82free     = $82f000

org $828b92
    nop : nop
    jsr hyper : nop
    
org !82free
    hyper:
        lda !pose
        cmp #$00c9
        beq yup
        cmp #$00ca
        beq yup
        cmp #$00cb
        beq yup
        cmp #$00cc
        beq yup
        cmp #$00cd
        beq yup
        cmp #$00ce
        beq yup
        ;stz !hyperflag
        rts
        
    yup:
        ;lda !hyperflag
        ;beq +
        ldy #$e1f0          ;create palette fx object
        jsl $8dc4e9         ;of type = to plm argument
        
+       rts

org $8dd902
    dw $0022                ;palette starting color for hyper beam palette fx object
                            ;vanilla is 01c2 (beam palette). 0180 is samus palette