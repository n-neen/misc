lorom

;defines-----------------------------------------------------------

!88free             = $88f100
!ramtable           = $d830
!ramtable_long      = $7e0000+!ramtable
!colormathbackup    = $42

;macros-----------------------------------------------------------

macro table_entry(duration, value)
    lda <duration>
    sta !ramtable_long,x
    inx
    lda <value>
    sta !ramtable_long,x
    inx
endmacro
            
;hdma object-----------------------------------------------------------

org !88free

    spawn:
        phy
        jsl $888435
        db $00, $31 : dw hdma_instlist      ;$2131 (backed up to $73)
        jsl $808338
        lda #$0168
        jsl $82e118
        ply
        rtl
        

    hdma:
        .instlist:
            dw .init
            dw $8655 : db $7e               ;direct hdma table in bank $88
            .loop:
            dw $8570 : dl hdma_preinst      ;preinstruction (where the table is constructed)
            dw $7777, !ramtable             ;direct hdma table location
            dw $85ec, .loop                 ;goto loop

        .init:                              ;this is where we backup
            sep #$20
            lda $73
            sta !colormathbackup
            rep #$20
            rts
            
        .preinst:                           ;this is where we construct the table
            sep #$30
            ldx #$00
            
            %table_entry(#$1f, $04)
            %table_entry(#$60, !colormathbackup)
            %table_entry(#$20, $04)
            %table_entry(#$60, !colormathbackup)
            lda #$00
            sta !ramtable_long,x
            
            rep #$30
            rtl
            
            ;dummy table (this is what it should look like)
            ;db $1f, $04                 ;under hud (bg3 only)
            ;db $60, !colormathbackup    ;above box 
            ;db $20, $04                 ;box
            ;db $60, !colormathbackup    ;below box
            ;db $00                      ;terminator
            
            
;misc-----------------------------------------------------------

;remove vanilla code that writes to the area of ram we are using for the table
;probably not necessary, but whatever

org $81b372
    nop #4
org $81b39c
    nop #4
org $8286ff
    nop #4
org $828730
    nop #4