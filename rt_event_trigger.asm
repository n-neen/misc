lorom

!84free = $84efff
!94free = $94dc00
!event  = #$0020

org !84free
    blankplm:
    
    dw .setup, .inst
    
    .setup:
        rts
        
    .inst:
        dw $0001, .draw
        dw $86bc
        
    .draw:
        dw $0001, $00ff, $0000
    
        
org $9498ac+8                       ;spike air (air fool x-ray) bts 04
    dw btsreaction
    
org !94free
    btsreaction:
    lda !event
    jsl $8081fa
    
    lda.w #blankplm
    jsl $8484e7
    rts
    