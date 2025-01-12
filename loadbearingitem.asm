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
            lda $1dc7,y
            sta $16                     ;back up plm argument
            ldx $1c87,y                 ;plm block index
            lda $7f0002,x               ;level data word for the tile where the plm is
            cmp $16                     ;check [plm room argument]
            bne +                       ;if not matching, exit
            
            lda #$ffff                  ;if matching,
            sta $1840                   ;set earthquake timer
            tyx
            stz $1c37,x                 ;delete plm
            lda #$c131
            sta $07df                   ;set main room routine pointer to generate explosions
            
+           ply
            plx
            
            rts
            
    
    ;warn pc ;8232 is end of free space