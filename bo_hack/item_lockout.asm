lorom

!locked_items           =       $09a0
!equipped_items         =       $09a2
!collected_items        =       $09a4
!free_dp                =       $c2

!ammotable              =       $74a0           ;in 7e
!maxammotable           =       $7500           ;in 7e

;according to:                  index into ammo table (our item ID)
;        $1: Varia suit         0
;        $2: Spring ball        1
;        $4: Morph ball         2
;        $8: Screw attack       3
;        $10                    
;        $20: Gravity suit      4
;        $40                    
;        $80                    
;        $100: Hi-jump boots    5
;        $200: Space jump       6
;        $400                   
;        $800                   
;        $1000: Bombs           7
;        $2000: Speed booster   8
;        $4000: Grapple         9
;        $8000: X-Ray           A

org $b88000
    
    checkammo:
        ;takes arguments:
        ;   X = item ID
        ;returns:
        ;   carry clear = no ammo
        ;   carry set   = yes ammo
        
        txa
        asl
        tax
        lda $7e0000+!ammotable,x
        sec
        bne +
        clc
+       rtl


    resetammo:
        ;reset all items to max
        phx
        phy
        
        ldx #$0000
        .loop:
        lda $7e0000+!maxammotable,x
        sta $7e0000+!ammotable,x
        inx : inx
        cpx #$0016          ;we inx after sta so need to go one word beyond
        bne .loop
        
        ply
        plx
        rtl
        
        
    giveammo:
        ;takes arguments:
        ;   X = item ID
        ;   A = amount of ammo
        sta !free_dp
        
        lda $7e0000+!ammotable,x
        clc
        adc !free_dp
        sta $7e0000+!ammotable,x
        
        lda $7e0000+!maxammotable,x
        clc
        adc !free_dp
        sta $7e0000+!maxammotable,x
        
        rtl
        