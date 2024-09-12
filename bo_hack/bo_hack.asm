;bo hack idea

lorom

incsrc ./macros.asm

;    $09DA: Game time, frames
;    $09DC: Game time, seconds
;    $09DE: Game time, minutes
;    $09E0: Game time, hours


; frame delay is from $400 (1000) to 0 frames
;between damages
;scales up over the course of one hour?

!enviro_subdmg      =       $0a4e

!igt_minutes        =       $09de
!igt_seconds        =       $09dc
!igt_frames         =       $09da


org $828b4b
    jsr thing
    nop #6
    
org $82f70f
    thing:
    lda !igt_minutes
    asl
    tax
    lda.l delaytable,x
    sta !enviro_subdmg
    rts


org $82fe00
    delaytable:
    %list($0080, $8000, 80)
    ;list(startvalue, endvalue, numberofentries)