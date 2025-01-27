;this version checks the plm's tile for airness



lorom

org $848116
    plm:
        dw #.init, #.inst
        
        .init:
            rts
            
        .inst:
            dw $86c1, #.check           ;set preinstruction to our routine
            dw $86b4                    ;sleep
            
        .check:
            phx
            phy
            
            ldy $1c27                   ;plm index
            ldx $1c87,y                 ;plm block index
            lda $7f0002,x               ;level data word for the tile where the plm is
            bit #$f000                  ;check collision nibble for zeroness (0 = air)
            bne +                       ;if not air, exit
            
            lda #$ffff                  ;if air,
            sta $1840                   ;set earthquake timer
            tyx
            stz $1c37,x                 ;delete plm
            lda #$c131
            sta $07df                   ;set main room routine pointer to generate explosions
            
+           ply
            plx
            
            rts
            
    
    ;warn pc ;8232 is end of free space