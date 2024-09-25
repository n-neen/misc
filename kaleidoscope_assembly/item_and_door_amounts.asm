lorom

;item pickup amounts

org $84e0b8
    dw $0064            ;etank    100
org $84e0dd
    dw $0003            ;missile  003
org $84e102
    dw $0001            ;super    001
org $84e127
    dw $0019            ;pb       025

org $84e474
    dw $0064            ;etank      (orb)
org $84e4a6
    dw $0003            ;missile    (orb)
org $84e4d8
    dw $0001            ;super      (orb)
org $84e50a
    dw $0019            ;pb         (orb)

org $84e93f
    dw $0064            ;etank      (hidden)
org $84e977
    dw $0003            ;missile    (hidden)
org $84e9af
    dw $0001            ;super      (hidden)
org $84e9e7
    dw $0019            ;pb         (hidden)
    
    
;door ammo amounts
                        ;missile door facing:
org $84c32c
    db $02                                  ;left
org $84c38e
    db $02                                  ;right
org $84c3f0
    db $02                                  ;up
org $84c452
    db $02                                  ;down