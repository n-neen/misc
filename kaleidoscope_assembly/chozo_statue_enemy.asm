lorom

;enemy power bomb reaction (with explosion type 3)
org $a0f7d3             ;copied from vanilla (via bank logs)
    splode:
    LDX $0E54
    JSR $A5C1           ; Normal enemy power bomb AI - no death check
    LDX $0E54
    LDA $0F8C,x         ;\
    BNE $0E             ;} If [enemy health] = 0:
    LDA #$0003          ;\
    STA $7E7002,x       ;} Enemy cause of death = 3 (power bomb killed)
    LDA #$0003          ;=========================================> explosion type index! the whole point of this thing!
    JSL $A0A3AF         ; Enemy death
    LDX $0E54
    RTL
    
org $aaf7d3
    jsl splode
    rtl
    
org $aae74c
    nop #3
    