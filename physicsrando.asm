;physics rando

lorom

!pointer       = $0594
!ramtableshort = $f4a0       ;in 7e, but we set db when accessing
!ramtablelong  = $7ef4a0

org $909bfe                  ;water
    lda !pointer

org $909c06                  ;lava/acid
    lda !pointer
    
org $9497d0                  ;block inside reaction - airs
    lda !pointer
    
org $9498a5                  ;air spike
    lda !pointer
    
org $9498dc                  ;solid, door, spike, shot, bomb, etc
    lda !pointer
    
org $9498e3                  ;special air
    lda !pointer
    
org $949909                  ;ws treadmill right
    lda !pointer
    
org $94992f                  ;ws treadmill left
    lda !pointer
    
org $94993f                  ;more treadmill i guess
    lda !pointer
    
org $94994f                  ;more treadmill whatevs
    lda !pointer
    
org $909c1b
    jsr rando
    
org $90f63a
    rando:
        
    rts

org $909f55             ;samus x speed table - air
    airtable:

org $90a08d
    watertable:
    
org $90a1dd
    lavatable:
    
    ;1c00/ffff
    ;7168/65535
    ;11520/65535