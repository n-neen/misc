lorom

org $94a175     ;horizontal shot reaction functions
shot: {
    .hotizontal: {
        dw #bumbler_spawn+8,  ;0    ;point at the "sec : rts"
           #bumbler_spawn,    ;1
           #bumbler_spawn,    ;2
           #bumbler_spawn,    ;3
           #bumbler_spawn,    ;4
           #bumbler_spawn,    ;5
           #bumbler_spawn,    ;6
           #bumbler_spawn,    ;7
           #bumbler_spawn,    ;8
           #bumbler_spawn,    ;9
           #bumbler_spawn,    ;a
           #bumbler_spawn,    ;b
           #bumbler_spawn,    ;c
           #bumbler_spawn,    ;d
           #bumbler_spawn,    ;e
           #bumbler_spawn     ;f
    }
   
    .vertical: {
        dw #bumbler_spawn+8,  ;0
           #bumbler_spawn,    ;1
           #bumbler_spawn,    ;2
           #bumbler_spawn,    ;3
           #bumbler_spawn,    ;4
           #bumbler_spawn,    ;5
           #bumbler_spawn,    ;6
           #bumbler_spawn,    ;7
           #bumbler_spawn,    ;8
           #bumbler_spawn,    ;9
           #bumbler_spawn,    ;a
           #bumbler_spawn,    ;b
           #bumbler_spawn,    ;c
           #bumbler_spawn,    ;d
           #bumbler_spawn,    ;e
           #bumbler_spawn     ;f
    }
}

org $94b19f
bumbler: {
    .spawn: {
        lda.w #bumbler_plm
        jsl $8484e7
        sec
        rts
    }


org $84efd3
    .plm: {
        dw #..init, #..list
        
        ..init: {
            rts
        }
        
        ..list: {
            dw $0004, #..draw_one
            dw $0004, #..draw_two
            dw $0004, #..draw_three
            dw #bumbler_plm_crabulator
            dw $86bc    ;delete
        }
        
        ..crabulator: {
            phx
            phy
            phb
            
            phk
            plb
            
            ldx.w #enemypop
            jsl $a09275         ;spawn enemy from population entry below
            cpx #$ffff
            beq +               ;if not spawned, exit
            
            phx
            
            ldx $1c27
            jsl $848290         ;calculate plm coords
            
            plx
            
            lda $1c29
            asl #4
            sta $0f7a,x         ;x
            
            lda $1c2b
            asl #4
            sta $0f7e,x         ;y
            
        +   plb
            ply
            plx
            rts

        }
        
        
        ..draw: {
            ...one: {
                dw $0001, $0053, $0000
            }
            
            ...two: {
                dw $0001, $0054, $0000
            }
            
            ...three: {
                dw $0001, $00ff, $0000
            }
        }
    }
}

enemypop: {
       ;type,  x      y     orntn  prop   exprp  spd1   spd2
    dw $d77f, $0000, $0000, $0000, $2000, $0000, $0002, $0000
}


org $828b4b
hijack: {
    lda $09e2       ;if japanese text = on, 
    beq +
    jsr beamler     ;force wave beam
    nop 
    +
}
    
org $82f70f
beamler: {
    ;forced wavinization
    lda $09a6
    ora #$0001
    sta $09a6
    
    lda $09a8
    ora #$0001
    sta $09a8
    rts
}


org $a3967b
;crab instruction lists: enemy d77f

;right ;;;
dw  $e660, $e6c8,
    $0008, #smap_right1,
    $0008, #smap_right2,
    $0008, #smap_right3,
    $0008, #smap_right2,
    $80ed, $967f

;left
dw  $e660, $e6c8,
    $0008, #smap_left1,
    $0008, #smap_left2,
    $0008, #smap_left3,
    $0008, #smap_left2,
    $80ed, $9697

;down
dw  $e660, $e7f2,
    $0008, #smap_down1,
    $0008, #smap_down2,
    $0008, #smap_down3,
    $0008, #smap_down2,
    $80ed, $96af

;up
dw  $e660, $e7f2,
    $0008, #smap_up1,
    $0008, #smap_up2,
    $0008, #smap_up3,
    $0008, #smap_up2,
    $80ed, $96c7




org $a3f311

;crab spritemaps
;crab is composed of the common sprite tiles so should work regardless of room
;so we don't have to ever load crab graphics (crabphics)
smap:
.up1
  DW $0009
  DW $0008 : DB $00 : DW $6AC8
  DW $01F0 : DB $00 : DW $2AC8
  DW $01FA : DB $F7 : DW $2AB2
  DW $01F8 : DB $F8 : DW $6A98
  DW $0000 : DB $F8 : DW $2A98
  DW $01F8 : DB $FF : DW $2A88
  DW $0000 : DB $FF : DW $6A88
  DW $01F3 : DB $FB : DW $2ACD
  DW $0005 : DB $FB : DW $6ACD

.up2
  DW $0009
  DW $0008 : DB $01 : DW $6AC8
  DW $01F0 : DB $00 : DW $2AC8
  DW $01FA : DB $F7 : DW $2AB2
  DW $01F8 : DB $F8 : DW $6A98
  DW $0000 : DB $F8 : DW $2A98
  DW $01F8 : DB $FF : DW $2A88
  DW $0000 : DB $FF : DW $6A88
  DW $01F3 : DB $FB : DW $2ACD
  DW $0005 : DB $FB : DW $6ACD

.up3
  DW $0009
  DW $0008 : DB $00 : DW $6AC8
  DW $01F2 : DB $01 : DW $2AC8
  DW $01FA : DB $F7 : DW $2AB2
  DW $01F8 : DB $F8 : DW $6A98
  DW $0000 : DB $F8 : DW $2A98
  DW $01F8 : DB $FF : DW $2A88
  DW $0000 : DB $FF : DW $6A88
  DW $01F3 : DB $FB : DW $2ACD
  DW $0005 : DB $FB : DW $6ACD

.right1
  DW $0009
  DW $01F2 : DB $02 : DW $2ABB
  DW $0008 : DB $00 : DW $6AC8
  DW $01FA : DB $F7 : DW $2AB2
  DW $01F8 : DB $F8 : DW $6A98
  DW $0000 : DB $F8 : DW $2A98
  DW $01F8 : DB $FF : DW $2A88
  DW $0000 : DB $FF : DW $6A88
  DW $01F3 : DB $FB : DW $2ACD
  DW $0005 : DB $FB : DW $6ACD

.right2
  DW $0009
  DW $0008 : DB $00 : DW $6AC8
  DW $01F4 : DB $03 : DW $2ABB
  DW $01FA : DB $F7 : DW $2AB2
  DW $01F8 : DB $F8 : DW $6A98
  DW $0000 : DB $F8 : DW $2A98
  DW $01F8 : DB $FF : DW $2A88
  DW $0000 : DB $FF : DW $6A88
  DW $01F3 : DB $FB : DW $2ACD
  DW $0005 : DB $FB : DW $6ACD

.right3
  DW $0009
  DW $0007 : DB $00 : DW $6AC8
  DW $01F2 : DB $FF : DW $2AB9
  DW $01FA : DB $F7 : DW $2AB2
  DW $01F8 : DB $F8 : DW $6A98
  DW $0000 : DB $F8 : DW $2A98
  DW $01F8 : DB $FF : DW $2A88
  DW $0000 : DB $FF : DW $6A88
  DW $01F3 : DB $FB : DW $2ACD
  DW $0005 : DB $FB : DW $6ACD

.down1
  DW $0009
  DW $0008 : DB $F8 : DW $EAC8
  DW $01F0 : DB $F8 : DW $AAC8
  DW $01FA : DB $F7 : DW $2AB2
  DW $01F8 : DB $F8 : DW $6A98
  DW $0000 : DB $F8 : DW $2A98
  DW $01F8 : DB $FF : DW $2A88
  DW $0000 : DB $FF : DW $6A88
  DW $01F3 : DB $FB : DW $2ACD
  DW $0005 : DB $FB : DW $6ACD

.down2
  DW $0009
  DW $000C : DB $F8 : DW $EAC8
  DW $01F0 : DB $F8 : DW $AAC8
  DW $01FA : DB $F7 : DW $2AB2
  DW $01F8 : DB $F8 : DW $6A98
  DW $0000 : DB $F8 : DW $2A98
  DW $01F8 : DB $FF : DW $2A88
  DW $0000 : DB $FF : DW $6A88
  DW $01F3 : DB $FB : DW $2ACD
  DW $0005 : DB $FB : DW $6ACD

.down3
  DW $0009
  DW $0008 : DB $F7 : DW $EAC8
  DW $01F1 : DB $F7 : DW $AAC8
  DW $01FA : DB $F7 : DW $2AB2
  DW $01F8 : DB $F8 : DW $6A98
  DW $0000 : DB $F8 : DW $2A98
  DW $01F8 : DB $FF : DW $2A88
  DW $0000 : DB $FF : DW $6A88
  DW $01F3 : DB $FB : DW $2ACD
  DW $0005 : DB $FB : DW $6ACD

.left1
  DW $0009
  DW $0008 : DB $00 : DW $6ABB
  DW $01F0 : DB $00 : DW $2AC8
  DW $01FA : DB $F7 : DW $2AB2
  DW $01F8 : DB $F8 : DW $6A98
  DW $0000 : DB $F8 : DW $2A98
  DW $01F8 : DB $FF : DW $2A88
  DW $0000 : DB $FF : DW $6A88
  DW $01F3 : DB $FB : DW $2ACD
  DW $0005 : DB $FB : DW $6ACD

.left2
  DW $0009
  DW $0008 : DB $01 : DW $6ABB
  DW $01F0 : DB $00 : DW $2AC8
  DW $01FA : DB $F7 : DW $2AB2
  DW $01F8 : DB $F8 : DW $6A98
  DW $0000 : DB $F8 : DW $2A98
  DW $01F8 : DB $FF : DW $2A88
  DW $0000 : DB $FF : DW $6A88
  DW $01F3 : DB $FB : DW $2ACD
  DW $0005 : DB $FB : DW $6ACD

.left3
  DW $0009
  DW $0008 : DB $00 : DW $6ABB
  DW $01F2 : DB $01 : DW $2AC8
  DW $01FA : DB $F7 : DW $2AB2
  DW $01F8 : DB $F8 : DW $6A98
  DW $0000 : DB $F8 : DW $2A98
  DW $01F8 : DB $FF : DW $2A88
  DW $0000 : DB $FF : DW $6A88
  DW $01F3 : DB $FB : DW $2ACD
  DW $0005 : DB $FB : DW $6ACD