lorom

!locked_items           =       $09a0
!equipped_items         =       $09a2
!collected_items        =       $09a4
!free_dp                =       $c2

;according to:
;        1: Varia suit
;        2: Spring ball
;        4: Morph ball
;        8: Screw attack
;        20h: Gravity suit
;        100h: Hi-jump boots
;        200h: Space jump
;        1000h: Bombs
;        2000h: Speed booster
;        4000h: Grapple
;        8000h: X-Ray

org $b88000
    lockitem:
        ;arguments:
        ;A = item bits to lock
        
        ora !locked_items               ;!locked_items OR A
        sta !locked_items               ;add bits in A to !locked_items
        
        lda !locked_items
        eor #$ffff                      ;!free_dp = inverted locked_items
        sta !free_dp
        
        lda !equipped_items             
        eor !free_dp                    ;equipped items = equipped items EOR locked items
        sta !equipped_items
        
        rtl
        
    
    checklock:
        ;arguments:
        ;A = lock to check
        ;returns:
        ;carry set = locked
        ;carry not set: not locked
        
        sta !free_dp
        bit !locked_items
        bne +
        clc
        rtl
        
+       sec
        rtl
    
    
    releaselocks:
        lda !locked_items               ;add locked item bits back to equipped item bits
        ora !equipped_items
        sta !equipped_items
        stz !locked_items               ;clear locked item bits
        rts