lorom

;general boss fixing
;area boss bit setting:
    ;draygon, phantoon, kraid in vanilla don't use the routine at $8081a6 to set boss bits
    
;macro setbossbit()  ;7 bytes in length
;    lda #$0001
;    jsl $8081a6
;endmacro
;
;org $a592d7         ;draygon death routine
;    %setbossbit()
;    nop #4
;    
;org $a7c82e         ;kraid
;    %setbossbit()
;    
;org $a7db7e
;    %setbossbit()
;    nop #4



;g4:
    