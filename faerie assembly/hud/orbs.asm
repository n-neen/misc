lorom

;this is completely unfinished, broken, does not at all work
;this is the code equivalent of someone saying "oh hey, uh"
;and then just never finishing their thought

;variables:
!health         =       $09c2
!maxhealth      =       $09c4
!orbdenominator =       $9b
!orbnumerator   =       $9d
!tempdp         =       $39
!tempdp2        =       $3e
    
;constants:
;dma destination base addresses
!kbg3baseaddr   =       $4000

!khealthrowtop  =       $0580+!kbg3baseaddr
!khealthrowmid  =       $0600+!kbg3baseaddr
!khealthrowbtm  =       $0680+!kbg3baseaddr

!kmanarowtop    =       $0598+!kbg3baseaddr
!kmanarowmid    =       $0618+!kbg3baseaddr
!kmanarowbtm    =       $0698+!kbg3baseaddr


org $85a000

orbs: {
    
    .update: {
        phx
        
        ;waves arms
        
        jsr orbs_determinerows
        jsr orbs_dma
        
        plx
        rtl
    }
    
    .rowtable: {        ;offset list for each row of each orb
        ..health: {
            dw !kbg3baseaddr+$0580, !kbg3baseaddr+$0600, !kbg3baseaddr+$0680
        }
        
        ..mana: {
            dw !kbg3baseaddr+$0598, !kbg3baseaddr+$0618, !kbg3baseaddr+$0698
        }
    }
    
    .determinerows: {
        php
        
        sep #$10
        
        ;healthorbdenominator = maxhealth/20
        lda !maxhealth
        sta $4204
        
        ldx #$14
        sta $4206
        
        nop #8
        
        lda $4214   ;result
        sta !orbdenominator
        
        ;each line of orb is worth [maxhealth/20] health
        
        plp
        rts
    }
    
    .dma: {
        ;uses health/mana value but this is not supplied as an argument
        
        ;calling convention:
        ;ldx #$0000     ;row we are modifying, 0, 1, 2
        ;lda #$0000     ;orb we are modifying: 0 (health), 1 (mana)
        ;jsr orb_dma
        
        
                                                ;register width (bytes)
        !dma_control            =   $2115       ;1
        !dma_dest_baseaddr      =   $2116       ;2
        !dma_transfur_mode      =   $4300       ;1
        !dma_reg_destination    =   $4301       ;1
        !dma_source_address     =   $4302       ;2
        !dma_bank               =   $4304       ;1
        !dma_transfur_size      =   $4305       ;2
        !dma_enable             =   $430b       ;1
                                ;set to #%00000001 to enable transfer on channel 0
                                
        ;lda for orb selection will happen immediately before this is called
        stx !tempdp
        beq ..health
        ;else,
        ..mana:
        inc #3
        ..health:
        clc
        adc !tempdp
        asl
        tax
        lda orbs_rowtable,x
        ;A now contains the vram offset for the following dma
        


        rep #$10        ;x/y = 8 bit
                        ;a = 16 bit
        
                                    ;width  register
        ldy #$80                    ;1      vram main
        sty $2115
        
        
        clc
        adc !kbg3baseaddr           ;2      dest base addr
        sta $2116
        
        ldy #$01                    ;1      transfur mode
        sty $4300
        
        ldy #$18                    ;1      register dest (vram port)
        sty $4301
        
        lda !dmasrcptr              ;2      source addr
        sta $4302
        
        ldy !dmasrcbank             ;1      source bank
        sty $4304
        
        lda !dmasize                ;2      transfur size
        sta $4305
        
        ldy #$01                    ;1      enable transfur on dma channel 0
        sty $420b
        
        rep #$30
        
        
        rts
    }
    
    .graphics: {
        ..top: {
            incbin "./orbs/orb_top_row.gfx"
        }
        
        ..middle: {
            incbin "./orbs/orb_middle_row.gfx"
        }
        
        ..bottom: {
            incbin "./orbs/orb_bottom_row.gfx"
        }
    }
    
}