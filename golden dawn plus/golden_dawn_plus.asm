lorom

;save added in the following rooms:                     ;area   index   tested
    ;7b167 before LN elevator (left of ridley's dong)   ;0002   0002    works
    ;799bd outside bombs                                ;0004   0000    works
    ;7cbd5 below phantoon                               ;0003   0000    works
    ;79ad9 eternal hall pruple bubble elevator          ;0001   0000    works
    ;7a815 left of croc                                 ;0000   0001    works
    ;7a4da before mb                                    ;0005   0000    works

;the prephantoon room save station is spawned with room setup routine:
;room argument from a plm spawned this way will be 0 (save index above)

org $8fff00

savespawn: {        ;phantoon save
    jsl $8483d7
    db $22, $07
    dw $b76f
    
    rts
}

;ff09
savespawn2: {       ;croc save (unused routine, ended up repointing plms instead)
    jsl $8483d7
    db $37, $0c
    dw $b76f
    
    
    
    rts
}