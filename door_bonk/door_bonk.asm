lorom ;ipsum dolor sit amet


;shot block shot reaction plm list
;doors are all on the last row, $40-$44
;B62F = nothing

org $949EA6
    dw $D064, $D068, $D06C, $D070, $D074, $D078, $D07C, $D080, $D084, $D088, $D08C, $D090, $B62F, $B62F, $B62F, $B62F,
       $B974, $B62F, $B62F, $B62F, $B62F, $B62F, $B62F, $B62F, $B62F, $B62F, $B62F, $B62F, $B62F, $B62F, $B62F, $B62F,
       $B62F, $B62F, $B62F, $B62F, $B62F, $B62F, $B62F, $B62F, $B62F, $B62F, $B62F, $B62F, $B62F, $B62F, $B62F, $B62F,
       $B62F, $B62F, $B62F, $B62F, $B62F, $B62F, $B62F, $B62F, $B62F, $B62F, $B62F, $B62F, $B62F, $B62F, $B62F, $B62F,
       $B62F, $B62F, $B62F, $B62F, $C83E, $EED3, $C816, $C81A, $C80E, $C812, $C806, $C80A, $C81E, $C822, $B62F, $B9C1
       ;these four are modified: $40, 41, 42, 43

;;; $94D5: Samus block collision reaction pointers - horizontal ;;;
org $9494D5
    dw $8F47,        ; *0: Air
       $8FBB,        ;  1: Slope
       $9018,        ; *2: Spike air
       $906F,        ;  3: Special air
       $8F47,        ; *4: Shootable air
       $9411,        ;  5: Horizontal extension
       $8F47,        ; *6: Unused air
       $92F9,        ;  7: Bombable air
       $8F49,        ;  8: Solid block
       $938B,        ;  9: Door block
       $904B,        ;  Ah: Spike block
       $90CB,        ;  Bh: Special block
       shot_h,       ;  Ch: Shootable block
       $9447,        ;  Dh: Vertical extension
       $8F49,        ;  Eh: Grapple block
       $932D         ;  Fh: Bombable block


;;; $94F5: Samus block collision reaction pointers - vertical ;;;
org $9494F5
    dw $8F47,       ; 0: Air
       $8FDA,       ; 1: Slope
       $901A,       ; 2: Spike air
       $909D,       ; 3: Special air
       $8F47,       ; 4: Shootable air
       $9411,       ; 5: Horizontal extension
       $8F47,       ; 6: Unused air
       $9313,       ; 7: Bombable air
       $8F82,       ; 8: Solid block
       $93CE,       ; 9: Door block
       $905D,       ; Ah: Spike block
       $9102,       ; Bh: Special block
       shot_v,      ; Ch: Shootable block
       $9447,       ; Dh: Vertical extension
       $8F82,       ; Eh: Grapple block
       $934C        ; Fh: Bombable block

org $94b19f

shot: {
    .h: {
        ;horizontal
        
        ;vanilla = 8F49
        phx
        
        jsr $8f49
        bcc +
        
        jmp shot_v_hentry
        
        +
        plx
        rts
    }
    
    .v: {
        ;vertical
        
        ;vanilla = 8F82
        phx
        
        jsr $8f82
        bcc +
        
        ..hentry
        
        lda $0dc4
        ;lsr
        tax
        lda $7f6402,x
        and #$00ff
        bit #$0040
        beq +
        and #$0003
        asl
        tax
        lda.l shot_doorlist,x
        jsl $8484e7
        
        +
        plx
        rts
    }
    
    .doorlist:
        dw $C8A2, $C8A8, $C8AE, $C8B4
        ;shot block bts $40, 41, 42, 43
}