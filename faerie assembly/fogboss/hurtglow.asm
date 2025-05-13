lorom


;instructions

!setindex   =   $c655
!done       =   $c595
!goto       =   $c61e
!delete     =   $c5cf

macro colorentry(color, diff, times)
    dw (<color>)+((<diff>)*(<times>))
endmacro

org $8d8000
    hurtglow:
        dw #.preinst, #.inst
        
    .preinst:
        rts
        
    .inst:
        dw !setindex, $00f2
        
        ;8 steps
        
        dw $0001
        dw $0063, $0000, $1863, $0000
        dw !done
        
        dw $0001
        dw $0000, $28A6, $0000, $72D4
        dw !done
        
        dw $0001
        dw $2D8D, $0000, $398D, $0000
        dw !done
        
        dw $0001
        dw $0000, $5AD8, $0000, $5AD8
        dw !done
        
        dw $0002
        dw $631A, $0000, $631A, $0000
        dw !done
        
        dw $0001
        dw $0000, $4E53, $0000, $66F8
        dw !done
        
        dw $0001
        dw $31AE, $0000, $3DAE, $0000
        dw !done
        
        dw $0001
        dw $0000+!colorshift, $0060+!colorshift, $347c+!colorshift, $0063+!colorshift
        dw !done
        
        yadone:
        dw !delete
        
        ;warn pc        ;805d
        

;dw $0063, $1800, $1863, $7EF3
;dw $14E8, $28A6, $28E8, $72D4
;dw $2D8D, $396C, $398D, $6AD5
;dw $5AD8, $5AD8, $5AD8, $5AD8

;dw $631A, $631A, $631A, $631A
;dw $4A54, $4E53, $4E54, $66F8
;dw $31AE, $3D8D, $3DAE, $6EF6
;dw $0063, $1800, $1863, $7EF3

;5AD8, 5AD8, 5AD8, 5AD8
;0063, 1800, 1863, 7EF3
