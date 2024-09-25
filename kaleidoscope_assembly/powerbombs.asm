lorom

;changing the hdma targets is the main focus of this patch
;you can have the hdma write to any of the registers that it is capable of
;i won't list them all here; but they start at $2100.

;some examples of ones i think are cool:
;2d, 06: subscreen layers + mosaic
;05, 06: drawing mode + mosaic
;06, 06: both mosaic
;(07, 08, 09), (07, 08, 09): delicious garbage tiles on layers 1, 2, or 3 (respectively)


org $888211                         ;pointers to the four types of pb layer blending
                                    ;y = 0, 2, 4, 6
    dw $80ca, $80ca, $80ca, $80ca
    ;$80ca = pointer to blending type $16 (the good one)
    ;for the hack this patch was intended for, for simplicity's sake,
    ;i just made all of these the same
    ;UPDATE: this is made useless by the following rts:
    
org $8881fe                         ;don't change any layer blending for pbs
    rts
    
org $888aba                         ;power bomb hdma object types and targets
    db $40, $32                     ;$(21)2d = subscreen layers
    skip 6
    db $40, $06                     ;$(21)06 = mosaic control register

org $888b98                         ;this branch skips some of the ending power bomb
    bra end                         ;stuff, so it ends more quickly.
    
org $888bdb                         ;target for the branch above
    end:

org $888aa9
    lda #$004e                      ;sound index to play. vanilla is #$0001
    jsl $8090a3                     ;queue that sound.    vanilla is $888435
                                    ;(see bank $80 disassembly for info on playing sound)
    
org $888de5
    dw $0000                        ;power bomb radius initial speed. vanilla = 0000
    dw $0008                        ;power bomb radius acceleration.  vanilla = 0030
    
org $888b24
    lda #$0000                      ;power bomb stage 1 radius. vanilla = 0400
    
org $888b39
    lda #$0500                      ;power bomb stage 3 radius. vanilla = 0400
    
    
;instruction list, big thanks to pjboy

org $888ace
    instlist:
        dw $8655 : db $89     ; HDMA table bank = $89
        dw $866A : db $7E     ; Indirect HDMA data bank = $7E
        dw $85B4 : dl $888B14 ; Power bomb explosion - stage 1 setup (pre-explosion - white)
        dw $8570 : dl $8890DF ; Pre-instruction = power bomb explosion - stage 1 - pre-explosion - white
        dw $8682              ; Sleep
        dw $85B4 : dl $888B32 ; Power bomb explosion - stage 2 setup (pre-explosion - yellow)
        dw $8570 : dl $8891A8 ; Pre-instruction = power bomb explosion - stage 2 - pre-explosion - yellow
        dw $8682              ; Sleep
        dw $85B4 : dl $888B39 ; Power bomb explosion - stage 3 setup (explosion - yellow)
        dw $8570 : dl $888DE9 ; Pre-instruction = power bomb explosion - stage 3 - explosion - yellow
        dw $8682              ; Sleep
        dw $85B4 : dl $888B47 ; Power bomb explosion - stage 4 setup (explosion - white)
        dw $8570 : dl $888EB2 ; Pre-instruction = power bomb explosion - stage 4 - explosion - white
        dw $8682              ; Sleep
        dw $8570 : dl $888B98 ; Pre-instruction = power bomb explosion - stage 5 - after-glow
        dw $8682              ; Sleep
        dw $85B4 : dl $888B4E ; Power bomb explosion - clean up and try crystal flash
        dw $8682              ; Sleep
        dw $8569              ; delete
        

        ;warn pc
        
        ;85ec = goto