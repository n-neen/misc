lorom
;broken, unfinished
;========================= DEFINES =========================

;vanilla instruction pointers
!delete      = $86bc
!goto        = $8724
!sleep       = $86b4
!settimer    = $874e
!checktimer  = $873f

;move block instruction pointers
!right       = $abd6
!down        = $8d98
!up          = up
!left        = left

;other defines
!steps       = $c1
!followsteps = $c3
!history     = $7ef4a0                  ;start of the array that stores the snake's path


;===================== MAIN SNAKE PLM =====================

org $84f100
snake:
    dw .setup, .instructionlist
    
    .setup:
        stz !steps
        stz !followsteps
        rts
    
    .instructionlist:
    dw !settimer : db $05              ;timer = 5
        .prefollower:
            dw $0028, .draw            ;initial drawing of platform, three tiles wide
            dw !right, incstep
            dw !checktimer, .prefollower
        .postfollower:
            dw !right, incstep
            dw $0028, .draw2
            dw locate
            dw !goto, .postfollower
        
    .end:
        dw !delete
        
    .draw:
        dw $0001, $805f, $0000
        
    .draw2:
        dw $0001, $805e, $0000
        
;====================== INSTRUCTIONS ======================

up:
    lda $1c87,x
    sec
    sbc $07a5
    sbc $07a5
    sta $1c87,x
    rts
    
left:
    dec $1c87,x
    dec $1c87,x
    rts
    
deleteblock:
    phx
    phy
        lda #blanktile                     ;needs to be the in-bank word pointer to the blank tile plm
        jsl $8484e7                        ;spawn it at current block
    ply
    plx
    rts
    
incstep:
    phx
        inc !steps
        inc !steps
        ldx !steps
        lda $0dc4                      ;current block index
        sta !history,x                 ;store to array, inexed by step number
    plx
    rts
    
    ;warn pc
locate:
    phx
    phy
        lda !followsteps
        inc : inc
        sta !followsteps
        tax
        
        lda $0dc4
        pha                            ;push real block index to stack
            lda !history-4,x
            sta $0dc4                  ;load fake block index
            jsr deleteblock
        pla
        sta $0dc4                      ;then pull back the real block index
    ply
    plx
    rts
    
    
;===================== BLANK TILE PLM =====================

blanktile:
    dw .setup, $dfa9
    
    .setup:
        rts

;====================== FOLLOWER PLM ======================

;follower:
;    dw .setup, .instructionlist
;    
;    .setup:
;        rts
;    
;    .instructionlist:
;        dw locate, !delete
        