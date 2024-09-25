lorom

;for spawning area-dependent glows wherever you want

;defines

!84free         = $84fa20

;palette fx objects reference

!ship           = $e1c0
!zebes          = $e1d4     ;cutscene afterglow
!hyper          = $e1f0
!unused         = $e1ec     ;want to see what this does
!dlightning     = $f769
!bt             = $f759
!gt             = $f75d

!crateria1      = $f765
!crateria2      = $ffe5
!crateria4      = $ffe9
!crateria8      = $ffd9
!crateria10     = $ffdd
!crateria20     = $ffe1
!crateria40     = $ffed

!brinstar1      = $f775
!brinstar2      = $f77d
!brinstar4      = $f781      ;same as crateria 80
!brinstar8      = $f779

!norfair1       = $f761      ;same as tourian 1 (heat)
!norfair2       = $f785
!norfair4       = $f789
!norfair8       = $f78d
!norfair10      = $f791

!wreckedship1   = $f76d      ;or f771?

!maridia1       = $f795      ;sand. palette 2
!maridia2       = $f799      
!maridia4       = $f79d      ;waterfall. palette 3

!tourian1       = $f761      ;same as norf 1
!tourian8       = $ffc9
!tourian10      = $ffcd
!tourian20      = $ffd1
!tourian40      = $ffd5



org !84free
    plm:
        dw #.init, #.inst
        
    .init:                  
        phy
        tyx
        ldy $1dc7,x         ;create palette fx object
        jsl $8dc4e9         ;of type = to plm argument
        ply
        rts
        
    .inst:
        dw $86bc            ;delete
        
        ;warn pc
        