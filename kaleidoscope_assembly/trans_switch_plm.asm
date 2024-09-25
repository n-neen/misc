lorom

;layer blending changer plm
;changes transparency2_B depending on if you are above or below the plm's location
;[also has horizontal mode]
;useful for liquids

;plm argument:
;$8000 bit = horizontal check
;  not set = vertical check
;then that bit is masked out and:
;high byte and low byte are the layer blend mode indices to switch between
;when the plm is passed (i.e., samus' x or y position is greater than
;that of the plm)


;defines
!84free      = $84f9d0
!samusy      = $0afa
!samusx      = $0af6

;plm instructions
!sleep       = $86b4
!setpreinst  = $86c1

org !84free
    plm:
        dw #.init, #.inst
        
    .init:
        rts
        
    .inst:
        dw !setpreinst, #.main
        dw !sleep
        
    .main:
        jsl $848290             ;calculate plm location
        lda $1dc7,x             ;plm argument
        bmi .horiz              ;if $8000 bit, we are using this horizontally
        
        .vert:                  ;else, vertical
            lda $1c2b           ;plm y position
            asl #4
            cmp !samusy
            bra .check
            
        .horiz:
            lda $1c29           ;plm x position
            asl #4
            cmp !samusx
        
        .check:
            bmi .low
            
        .high:
            lda $1dc7,x         ;plm argument
            and #$00ff
            bra .set
        
        .low:
            lda $1dc7,x
            and #$7f00
            xba
            
        .set
            sta $1984           ;transparency2_B
                                ;(only used with layer 3 fx. change to $1982 to use otherwise)
                                
        .exit:       
            rts
            
            
            ;warn pc