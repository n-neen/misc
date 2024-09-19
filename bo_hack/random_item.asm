;bo hack idea

lorom

incsrc ./macros.asm

;defines-----------------------------------------------------------------------
;pointers

!EnergyTank             =   $E0B6
!Missile                =   $E0D6
!SuperMissile           =   $E100
!PowerBomb              =   $E120
!Bomb                   =   $E152
!ChargeBeam             =   $E180
!IceBeam                =   $E1AE
!HiJumpBoots            =   $E1DC
!SpeedBooster           =   $E20A
!WaveBeam               =   $E238
!Spazer                 =   $E266
!SpringBall             =   $E294
!VariaSuit              =   $E2C8
!GravitySuit            =   $E2F6
!PlasmaBeam             =   $E358
!GrappleBeam            =   $E386
!SpaceJump              =   $E3B8
!ScrewAttack            =   $E3E6
!ReserveTank            =   $E442
!XRayScope              =   $ECBD

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

org $84efd3             ;first available freespace in $84
    roll:
        jsl $808111
        and #$007f
        inc
        asl
        tax
        phy
        phx
        jsr (probtable,x)
        plx
        ply
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
                dw roll
                dw $8724, $dfa9     ;goto delete item list
                
    draw:
        .one:
            dw $0001, $b001, $0000
            
        .two:
            dw $0001, $b002, $0000

;probability table----------------------------------------------------------------------------

macro table_entry(item)
    %table_write(<item>, !prob_<item>)
endmacro

macro table_write(word, repeats)
    !a #= <repeats>
    while !a > 0
        dw <word>
        !a #= !a-1
    endwhile
endmacro

org $84f200
    probtable:
    print "probability table start - ", pc
    %table_entry(Missile);;;
    %table_entry(SuperMissile);;;
    %table_entry(Bomb);;;
    %table_entry(SpeedBooster);;;
    %table_entry(ChargeBeam)
    %table_entry(Spazer)
    %table_entry(HiJumpBoots);;;
    %table_entry(PowerBomb);;;
    %table_entry(EnergyTank);;;
    %table_entry(ReserveTank);;;
    %table_entry(SpaceJump);;;
    %table_entry(WaveBeam)
    %table_entry(VariaSuit);;;
    %table_entry(GrappleBeam)
    %table_entry(XRayScope);;;
    %table_entry(IceBeam)
    %table_entry(SpringBall);;;
    %table_entry(PlasmaBeam)
    %table_entry(GravitySuit);;;
    %table_entry(ScrewAttack);;;
    
    Missile:
        ldy #$0002
        jsr $89a9
        bra common
        
    EnergyTank:
        ldy #$0064
        jsr $8968
        bra common
        
    PowerBomb:
        ldy #$0005
        jsr $89fb
        bra common
        
    SuperMissile:
        ldy #$0001
        jsr $89d2
        bra common
        
    ReserveTank:
        ldy #$0064
        jsr $8986
        bra common
        
    Bomb:
        ldy #$1000
        bra major
        
    SpeedBooster:
        ldy #$2000
        bra major
        
    HiJumpBoots:
        ldy #$0100
        bra major
        
    SpaceJump:
        ldy #$0200
        bra major
        
    VariaSuit:
        ldy #$0001
        bra major
        
    GravitySuit:
        ldy #$0020
        bra major
        
    ScrewAttack:
        ldy #$0008
        bra major
        
    XRayScope:
        ldy #$8000
        bra major
        
    SpringBall:
        ldy #$0002
        bra major
        
    GrappleBeam:
        ldy #$4000
        
    major:
        jsr $88f3
        bra common
        
    ChargeBeam:
        ldy #$1000
        bra beam
    
    Spazer:
        ldy #$0004
        bra beam
    
    WaveBeam:
        ldy #$0001
        bra beam
    
    PlasmaBeam:
        ldy #$0008
        bra beam
    
    IceBeam:
        ldy #$0002
    
    beam:
        jsr $88b0
        
    common:
        ldy #$0002
        jsr $8bdd
        rts
    
    print "end - ",pc