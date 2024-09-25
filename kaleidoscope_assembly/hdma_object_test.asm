lorom

;test hdma object, spawned by plm

!84free  = $f400
!88free  = $ee32


!scanone = $bf
!scantwo = $10

;plm-------------------------------------------------------------------

org $840000+!84free

    plm:
        dw .setup, .instlist
        
        .setup:
            jsl spawn
            rts
            
        .instlist:
            dw $86bc        ;delete
            
            ;warn pc
            
;hdma object-----------------------------------------------------------

org $880000+!88free

    spawn:
        jsl $888435
        db $00, $00 : dw hdma_instlist
        rtl
        

    hdma:
        .instlist:
            dw $8655 : db $88       ;direct hdma table in bank $88
            .loop:
            dw $7777, .direct       ;direct hdma table location
            dw $85ec, .loop         ;goto loop
                      
        .direct:
            db $1f, $0f         ;under hud
            db $40, $07         ;outside tube
            
            db $02, $07
            db $02, $08         ;gradient
            db $02, $09
            db $02, $0a
            db $02, $0b
            db $02, $0c
            db $02, $0d
            db $02, $0e
            
            db $20, $0f         ;tube
            
            db $01, $0e         ;gradient
            db $01, $0d
            db $02, $0c
            db $02, $0b
            db $02, $0a
            db $02, $09
            db $02, $08
            db $02, $07
            db $02, $06
            db $02, $05         ;remainder of screen
            
            db $00              ;terminator
            
            ;warn pc