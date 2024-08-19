lorom

!plmentry       = $f33e

;instruction pointers
!makeair        = $9497         ;current tile
!downone        = $ab00         ;move plm down one block
!frameone       = $9cad         ;first animation frame, vanilla draw instruction
!frametwo       = $9cb3         ;second frame
!framethree     = $9cb9         ;third
!timercheck     = $873f         ;decrement timer and go to [next pointer in list]
!delete         = $86bc
!playsound      = $8c10         ;play sound from library 2

org $840000+!plmentry
    
    dw #setup, #instructionlist
    
    setup:
        rts
    
    instructionlist:
        dw #settimer
        nextblock:
        ;dw !playsound : db $0a      ;block crumble sound
        dw $0006, !frameone
        dw $0006, !frametwo
        dw $0006, !framethree
        dw $0001, !makeair
        dw !downone
        dw !timercheck, #nextblock
        dw !delete
    
    settimer:
        phx
        phy
        sep #$30
            ldx $1c27
            lda $7f6402+2           ;third tile of the top row
            sta $1d77,x             ;set timer to that
        rep #$30
        ply
        plx
    rts

;f370

    dw #doorsetup, #doorinst
    
    doorsetup:
        rts
    
    doorinst:
        dw #settimer
        nextdoor:
        dw $0006, #doorone
        dw $0006, #doortwo
        dw $0006, #doorthree
        dw $0001, #doorfour
        dw !downone
        dw !timercheck, #nextdoor
        dw !delete
        
    doorone:
        dw $0001, $9053, $0000
    doortwo:
        dw $0001, $9054, $0000
    doorthree:
        dw $0001, $9055, $0000
    doorfour:
        dw $0001, $90ff, $0000
