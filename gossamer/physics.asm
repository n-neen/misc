lorom

org $909EA1
dw $2480    ;gravity in air. vanilla is 1c00. 2d00 is what we want
dw $0600    ; water
dw $0700    ; acid/lava

;pixels?
dw $0000    ; Samus Y acceleration in air
dw $0000    ; Samus Y acceleration in water
dw $0000    ; Samus Y acceleration in acid/lava


org $909E97
    dw $0280            ;space jump constant. minimum fall speed to use space jump in air. vanilla is 0280

org $909E99
    dw $0600            ;space jump constant. maximum fall speed to use space jump in air. vanilla is 0500

org $909e9b
    dw $0280, $0700     ;space jump minimum and maximum fall speed for water (respectively)

org $91ed60
    bra $00 : nop       ;skip zeroing samus contact damage index (screw, speed, pseudo)
                        ;makes pseudoscrew space jump immune to air spikes indefinitely (voiddragon entry)
                        ;more testing required DO NOT FORGET TO DO THIS ;=========================================================================================================================

org $82e74b             ;shoutout to benox50 for this idea
    stz $0a9c           ;fix slowed animations from water -> spore, rain, etc., effects during door transition
                        ;this replaces a jsr $dfc7 which seems to have no effect at all, very lucky
                        ;um actually if you have i-frames during a door this results in a small amount of flickering on the other side. probably fine

;===================================================================================health spark values
org $90d0c9
    cmp #$001e         ;vertical spark health stop = 16

org $90d0f8             ;diagonal
    cmp #$001e

org $90d124             ;horizontal
    cmp #$001e

;speedboost plm doesn't belong here but fuck it
org $84e63b
    lda #$0040
    