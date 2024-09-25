!plmentry = $f200

lorom

org $840000+!plmentry
    
    dw setup, inst
    
    setup:
        rts
    
    inst:           ;1, 6, 7, 12, 13, 18, 19
        .top
        dw $0008, draw_1
        dw $0004, draw_2
        dw $0004, draw_3
        dw $0004, draw_4
        dw $0004, draw_5
        dw $0008, draw_6
        dw $0008, draw_7
        dw $0004, draw_8
        dw $0004, draw_9
        dw $0004, draw_10
        dw $0004, draw_11
        dw $0008, draw_12
        dw $0008, draw_13
        dw $0004, draw_14
        dw $0004, draw_15
        dw $0004, draw_16
        dw $0004, draw_17
        dw $0008, draw_18
        dw $0008, draw_19
        dw $0004, draw_20
        dw $0004, draw_21
        dw $8724, .top
        
    draw:
    .1:    dw $0001, $81a0, $0000      ;palette 0
    .2:    dw $0001, $81a1, $0000
    .3:    dw $0001, $81a2, $0000
        
    .4:    dw $0001, $81c2, $0000      ;palette 1
    .5:    dw $0001, $81c1, $0000
    .6:    dw $0001, $81c0, $0000
        
    .7:    dw $0001, $81e0, $0000      ;palette 2 
    .8:    dw $0001, $81e1, $0000
    .9:    dw $0001, $81e2, $0000
        
    .10:   dw $0001, $8202, $0000      ;palette 3
    .11:   dw $0001, $8201, $0000
    .12:   dw $0001, $8200, $0000
        
    .13:   dw $0001, $8220, $0000      ;palette 4
    .14:   dw $0001, $8221, $0000
    .15:   dw $0001, $8222, $0000
        
    .16:   dw $0001, $8242, $0000      ;palette 6
    .17:   dw $0001, $8241, $0000
    .18:   dw $0001, $8240, $0000
        
    .19:   dw $0001, $8260, $0000      ;palette 5
    .20:   dw $0001, $8261, $0000
    .21:   dw $0001, $8262, $0000
    