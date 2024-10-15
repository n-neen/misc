lorom

org $909ea1         ;samus gravity constant
    dw $1800        ;air
    dw $0580        ;water
    dw $0800        ;lava/acid
    
;remove shinespark health drain:
org $90D0CE         ;vertical
    nop : nop : nop

org $90D0FD         ;diagonal
    nop : nop : nop

org $90D129         ;horizontal
    nop : nop : nop
    
org $90d2ba         ;shinespark health check
    nop #8
    
    
org $82e74b         ;shoutout to benox50 for this idea
stz $0a9c           ;fix slowed animations from water -> spore, rain, etc., effects during door transition
                    ;this replaces a jsr $dfc7 which seems to have no effect at all, very lucky
                    ;um actually if you have i-frames during a door this results in a small amount of flickering on the other side. probably fine


;org $90ab00
;    bra $06

org $908502
    bit #$0020
org $90978c
    bit #$0020      ;item check for fast running (vanilla=#$2000 (speeb))
org $90855b
    bit #$0020
org $90991c
    bit #$0020
org $9099a9
    bit #$0020
    

;scalable pseudoscrew
;org $a0a4d2
;    beq here
;org $a0a4dd
;    here:
;        jmp pseudoscale
;org $a0fa00         ;equipped beams $09a6
;    !pseudo_dmg = $099a
;    pseudoscale:
;        sep #$20
;        lda $09a6               ;a = equipped beams
;        and #$0f                ;bottom nibble only
;        asl #4                  ;shift it to the top
;        ldx #$04                ;init loop counter
;        .loop
;            asl                 ;shift bit into carry if it exists
;            bcc +               ;if it doesn't, loop
;            inc !pseudo_dmg     ;if it does, inc
;+           dex
;            bne .loop           ;next loop if x =/= 0
;        lda !pseudo_dmg         ;min =0, max =4
;        asl #7                  ;if 1, after shift it's 128
;        rep #$20                    ;if 4, after shift it's 512
;        jmp $a4d4