lorom ;ipsum dolor sit amet

!82free     =       $82f750
!demomode   =       $42

;controller bit constants
!kb                         =       #$8000
!ky                         =       #$4000
!ksl                        =       #$2000
!kst                        =       #$1000
!kup                        =       #$0800
!kdn                        =       #$0400
!klf                        =       #$0200
!krt                        =       #$0100
!ka                         =       #$0080
!kx                         =       #$0040
!kl                         =       #$0020
!kr                         =       #$0010

;hijack the entire program why not
;uses game mode 3 (unused in sm normally)

org $828981+($3*2)
    dw #demohandler

org !82free

demohandler: {
    jsl demo
    rts
}

org $b88000

demo: {
    
    .main: {
        php
        
        rep #$30
        lda !demomode
        cmp #$0004
        beq +
        asl
        tax
        jsr (demo_mode_table,x)
        
    -   plp
        rtl
        
    +   lda #$0008          ;return with game mode set for main program
        sta $0998
        bra -
    }
    
    .mode {
        macro changemode(mode)
            lda.w #$<mode>
            sta !demomode
        endmacro
        
        ..table: {
            ;function pointers for demoscene mode routines
            dw #demo_mode_init,         ;0: init
               #demo_mode_load,         ;1: load
               #demo_mode_play,         ;2: play
               #demo_mode_cleanup       ;3: cleanup
                                        ;4: (command to end)
        }
        
        ..init: {
            jsl $808338
            ;do something here
            
            %changemode(1)      ;advance to mode 1 (load)
            rts
        }
        
        ..load: {
            %changemode(2)      ;advance to mode 2 (play)
            rts
        }
        
        ..play: {
            jsr demo_input
            
            ;%changemode(3)      ;advance to mode 3 (cleanup)
            rts
        }
        
        ..cleanup: {
            %changemode(4)      ;advance to mode 4 (signal to handler to exit)
            rts
        }
    }
    
    .input: {
        phx
        ;use x for general stores here to preserve A
        lda $8b
        
        ..st: {
            bit !kst
            beq ...nost
            %changemode(4)
            ...nost:
        }
        
        ..sl: {
            bit !ksl
            beq ...nosl
            ;if select pressed go here
            ...nosl:
        }
        
        ..up: {                                 ;dpad start
            bit !kup
            beq ...noup
            inc $b3
            ...noup:
        }
        
        ..dn: {
            bit !kdn
            beq ...nodn
            dec $b3
            ...nodn:
        }
        
        ..lf: {
            bit !klf
            beq ...nolf
            dec $b1
            ...nolf:
        }
        
        ..rt: {
            bit !krt
            beq ...nort
            inc $b1
            ...nort:
        }                                       ;dpad end
        
        ..a: {
            bit !ka
            beq ...noa
            pha
            sep #$20
            lda $69
            eor #%00000010                      ;toggle layer 2
            sta $69
            rep #$20
            pla
            ...noa:
        }
        
        ..x: {
            bit !kx
            beq ...nox
            pha
            sep #$20
            lda $69
            eor #%00000001                      ;toggle layer 1
            sta $69
            rep #$20
            pla
            ...nox:
        }
        
        ..b: {
            bit !kb
            beq ...nob
            pha
            sep #$20
            lda $69
            eor #%00010000                      ;toggle sprites
            sta $69
            rep #$20
            pla
            ...nob:
        }
        
        ..y: {
            bit !ky
            beq ...noy
            pha
            sep #$20
            lda $69
            eor #%00000100                      ;toggle layer 3
            sta $69
            rep #$20
            pla
            ...noy:
        }
        
        ..l: {
            bit !kl
            beq ...nol
            ;if L pressed go here
            ...nol:
        }
        
        ..r: {
            bit !kr
            beq ...nor
            ;if R pressed go here
            ...nor:
        }
        plx
        rts
    }
    
    .graphics: {
        ..bg1:
            ;incbin "./demo/bg1.gfx"
        ..bg2:
            ;incbin "./demo/bg1.gfx"
    }
}