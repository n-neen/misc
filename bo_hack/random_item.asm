;bo hack idea

lorom


;defines-----------------------------------------------------------------------
;probabilities

!prob_Missile           =   38
!prob_SuperMissile      =   10
!prob_Bomb              =   10
!prob_SpeedBooster      =   10
!prob_ChargeBeam        =   8
!prob_Spazer            =   8
!prob_HiJumpBoots       =   8
!prob_PowerBomb         =   6
!prob_EnergyTank        =   5
!prob_ReserveTank       =   4
!prob_SpaceJump         =   4
!prob_WaveBeam          =   4
!prob_VariaSuit         =   2
!prob_GrappleBeam       =   2
!prob_XRayScope         =   2
!prob_IceBeam           =   2
!prob_SpringBall        =   2
!prob_PlasmaBeam        =   1
!prob_GravitySuit       =   1
!prob_ScrewAttack       =   1



;rolling an item

org $84efd3                             ;first available freespace in $84
    roll:
        phx
        phy
        
        %loadby_y($0002, $0014)         ;load music track (fanfare)
        jsr $8bdd
        jsl $808111
        and #$007f                      ;random number 0-$80
        inc
        asl                             ;x2
        tax
        jsr (probtable,x)               ;index into jump table
        
        ;ldx $1c27
        ;lda #$dfa9                      ;instruction list pointer=
        ;sta $1d27,x                                 ;dfa9 (deletion)
        
        ply
        plx
        rts
        
org $84f000             ;item plm
    plm:
        dw $ee4d, .list

        .list:
            dw $887c, .end          ;goto end if item collected
            dw $8a24, .link         ;set link instruction
            dw $86c1, $df89         ;set pre-instruction: go to link when triggered
            .drawloop:
                dw $0004, draw_one  ;draw instructions
                dw $0004, draw_two
                dw $8724, .drawloop ;goto drawloop
            .link:
                dw $8899            ;set item collected
            .end:
                dw roll             ;roll item
                dw $8724, $dfa9
    draw:
        .one:
            dw $0001, $b001, $0000
            
        .two:
            dw $0001, $b002, $0000

;probability table----------------------------------------------------------------------------

org $84f200
    probtable:
    print "probability table start - ", pc
    %table_entry(Missile)
    %table_entry(SuperMissile)
    %table_entry(Bomb)
    %table_entry(SpeedBooster)
    %table_entry(ChargeBeam)
    %table_entry(Spazer)
    %table_entry(HiJumpBoots)
    %table_entry(PowerBomb)
    %table_entry(EnergyTank)
    %table_entry(ReserveTank)
    %table_entry(SpaceJump)
    %table_entry(WaveBeam)
    %table_entry(VariaSuit)
    %table_entry(GrappleBeam)
    %table_entry(XRayScope)
    %table_entry(IceBeam)
    %table_entry(SpringBall)
    %table_entry(PlasmaBeam)
    %table_entry(GravitySuit)
    %table_entry(ScrewAttack)
    
    print "end - ",pc
    
    Missile:
        %loadby_y($0002, $0014)         ;missile amount
        jsr $89a9
        jmp common
        
    EnergyTank:
        %loadby_y($0064, $0014)         ;tank amount
        jsr $8968
        jmp common
        
    PowerBomb:
        %loadby_y($0005, $0014)         ;pb amount
        jsr $89fb
        jmp common
        
    SuperMissile:
        %loadby_y($0001, $0014)         ;super amount
        jsr $89d2
        jmp common
        
    ReserveTank:
        %loadby_y($0064, $0014)         ;reserve amount
        jsr $8986
        jmp common
        
    Bomb:
        %loadby_y($0013, $0016)         ;message box index
        %loadby_y($1000, $0014)         ;major item type
        jmp major
        
    SpeedBooster:
        %loadby_y($000d, $0016)         ;message box index
        %loadby_y($2000, $0014)         ;major item type
        jmp major
        
    HiJumpBoots:
        %loadby_y($000b, $0016)         ;message box index
        %loadby_y($0100, $0014)         ;major item type
        jmp major
        
    SpaceJump:
        %loadby_y($000c, $0016)         ;message box index
        %loadby_y($0200, $0014)         ;major item type
        jmp major
        
    VariaSuit:
        %loadby_y($0007, $0016)         ;message box index
        %loadby_y($0001, $0014)         ;major item type
        jmp major
        
    GravitySuit:
        %loadby_y($001a, $0016)         ;message box index
        %loadby_y($0020, $0014)         ;major item type
        jmp major
        
    ScrewAttack:
        %loadby_y($000a, $0016)         ;message box index
        %loadby_y($0008, $0014)         ;major item type
        jmp major
        
    XRayScope:
        %loadby_y($8000, $0014)         ;major item type
        jsr $8941
        jmp common
        
    SpringBall:
        %loadby_y($0008, $0016)         ;message box index
        %loadby_y($0002, $0014)         ;major item type
        jmp major
        
    GrappleBeam:
        %loadby_y($4000, $0014)         ;major item type
        jsr $891a
        bra common
        
    major:
        jsr $88f3
        bra common
        
    ChargeBeam:
        %loadby_y($000e, $0016)         ;message box index
        %loadby_y($1000, $0014)         ;beam type
        bra beam
    
    Spazer:
        %loadby_y($0011, $0016)         ;message box index
        %loadby_y($0004, $0014)         ;beam type
        bra beam
    
    WaveBeam:
        %loadby_y($0010, $0016)         ;message box index
        %loadby_y($0001, $0014)         ;beam type
        bra beam
    
    PlasmaBeam:
        %loadby_y($0012, $0016)         ;message box index
        %loadby_y($0008, $0014)         ;beam type
        bra beam
    
    IceBeam:
        %loadby_y($000f, $0016)         ;message box index
        %loadby_y($0002, $0014)         ;beam type
    
    beam:
        jsr $88b0
        
    common:
        rts
    