lorom

!84free       = $84f410
!88free       = $88ee50
!ramtable     = f3a4                     ;this is in 7e. omit the $ to use short or long later
!framecounter = $a1
!lineconst    = #$70                     ;number of scanlines under the hud we're using

;=======================plm======================= 

org !84free
    plm:
        dw .setup, .instlist
        
        .setup:
            lda #$0001
            sta !framecounter
            jsl hdma_spawn
            rts
            
        .instlist:
            dw $86bc                     ;delete
            
;======================hdma=======================
            
org !88free
    hdma:
        .spawn:
            jsl $888435
            db $00, $00 : dw hdma_instlist
            rtl
            
        .instlist:
            dw $8655 : db $7e            ;table bank = 7e
            ..loop:
            dw $8570 : dl hdma_preinst   ;preinstruction (where the table is constructed)
            dw $7777, $!ramtable         ;table location
            dw $85ec, ..loop
            
        ;==============construct hdma table in ram==============
        .preinst:
            phx
            phy
            sep #$20
            
            ldx #$00
            
            lda #$1f                     ;write the starting part of the table
            sta $7e!ramtable,x           ;this is under the hud so whatever
            inx
            lda #$0f
            sta $7e!ramtable,x
            inx
                      
            lda !framecounter            ;we need to add one inc there to avoid writing $00
            inc                          ;because that is the table terminator
            and #$7f
            sta $7e!ramtable,x
            inx
            lda #$00
            sta $7e!ramtable,x
            inx
            
            lda #$30                    ;this is the active (visible) band width <=================================
            sta $7e!ramtable,x
            inx
            lda #$0f                    ;and its brightness value
            sta $7e!ramtable,x
            inx

            lda #$01                    ;one mor line of 00 brightness
            sta $7e!ramtable,x
            inx
            lda #$00                    ;this gets kept for the rest of the lines
            sta $7e!ramtable,x
            inx
            
            lda #$00                    ;table terminator
            sta $7e!ramtable,x
            

            lda !framecounter           ;check counter
            inc                         ;adding more incs increses da speed <======================================
            sta !framecounter
            cmp !lineconst-1
            beq .reset
            
            rep #$20
            plx
            ply
            rtl
             
            .reset:
            stz !framecounter
            rep #$20
            plx
            ply
            rtl
            