;for redesign:
;freespace $84f610

!boxdelay = #$0020 ;32

;$848bdd           ; all items have this pointer in inst list

org $848bde        ; skip music restarting
    plx
    bra playsound

org $848bfb
    playsound:
    lda #$0039     ; missile click
    jsl $809021    ; sound library 1
    nop : nop : nop

;overwrite music restarting part
org $8488de        ;beam
    nop #7

org $848905        ;major item, no hud
    nop #7

org $848930        ;grapple
    nop #7

org $848941        ;xray
    nop #7

org $848975        ;etank
    nop #7

org $848998        ;reserve
    nop #7

org $8489c1        ;missile
    nop #7

org $8489ea        ;super
    nop #7

org $848a13        ;pb
    nop #7

org $858490        ;message box routine delay
    ldx !boxdelay