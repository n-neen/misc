lorom

!ramtable       =   f4b0
!value          =   #$00ff              ;what to write to the register for the single active scanline
!88free         =   $88ee71
!84free         =   $84f40f
!clamp          =   #$007f              ;maximum scanline value (oh whoops, table entry max is 7f)
!freeram        =   $9b
!filler         =   #$0000              ;nonactive scanline value (normal) high byte only
!bandwidth      =   #$0001


org !84free
    plm:
        dw #.init, #.inst
        
        .init:
            jsl hdma_spawn
            rts
        
        .inst:
            dw $86bc                    ;delete
        


org !88free
    hdma:
        .spawn:
            jsl $888435
            db $00, $06 : dw hdma_instlist
            rtl
            
        .instlist:
            dw $8655 : db $7e           ;table bank = 7e
            ..loop:
            dw $8570 : dl hdma_preinst  ;preinstruction (where the table is constructed)
            dw $7777, $!ramtable        ;table location
            dw $85ec, ..loop
            
        .preinst:
        
            lda $05b8
            bit #$0002                  ;interval to update
            bne +
        
            sep #$20
            
            jsl $808111                 ;first table line
            and !clamp                  ;[random 0-7f], 00
            sta $7e!ramtable
            dec
            pha
            lda !filler
            sta $7e!ramtable+1
            
            lda !bandwidth              ;active band scanline(s) (second table line)
            sta $7e!ramtable+2
            lda !value                  ;02, [value]
            sta $7e!ramtable+3
            
            pla
            sta !freeram
            sec                         ;7f-scanlinelocation, 00 (third table line, gap betwixt)
            lda !clamp
            sbc !freeram
            sta $7e!ramtable+4
            lda !filler
            sta $7e!ramtable+5
            
            jsl $808111                 ;more filler (fourth table line)
            and !clamp
            sta $7e!ramtable+6
            lda !filler
            sta $7e!ramtable+7
            
            lda !bandwidth              ;active band scanline(s) (fifth table line)
            sta $7e!ramtable+8
            lda !value
            sta $7e!ramtable+9
            
            lda #$0040                  ;final filler (sixth table line)
            sta $7e!ramtable+10
            lda !filler
            sta $7e!ramtable+11
            
            lda #$0000
            sta $7e!ramtable+12         ;terminator
            
            rep #$20
+           rtl
            
