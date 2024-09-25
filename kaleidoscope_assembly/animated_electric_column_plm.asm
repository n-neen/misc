lorom

;animated column of electric tube plm

!84free = $84f9a0
!goto   = $8724

org !84free
    plm:
        dw #init, #inst
        
    init:
        rts
        
    inst:
        dw $0004, #draw_1
        dw $0004, #draw_2
        dw $0004, #draw_3
        dw !goto, #inst
        
    draw:
        .1:
            dw $8002, $8085, $8885, $0000
            
        .2:
            dw $8002, $8086, $8886, $0000
            
        .3:
            dw $8002, $8087, $8887, $0000
        