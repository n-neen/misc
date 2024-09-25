lorom

org $84f000
    dw setup, inst
    
    setup:
        rts
        
    inst:
        dw $0005, frameone       ;draw frame one, five frames
        dw $0005, frametwo       ;draw frame two, five frames
        dw $8724, inst           ;goto top
        
    frameone:
        dw $0001, $805d, $0000      ;one tile, solid, tile 5d
    frametwo:
        dw $0001, $805e, $0000      ;one tile, solid, tile 5e
        
    ;warn pc: 84f01d