lorom

;todo:
;incsrc "./orbs/orbs.asm"
incsrc "./hud/mode0.asm"
incsrc "./hud/minimapremoval.asm"

;default bg3 hud tilemap
org $80988b
    incbin "./hud/bg3tilemap.map"

;hud digits tilemaps
; Health
org $809DBF
    dw $0445, $043c, $043d, $043e, $043f, $0440, $0441, $0442, $0443, $0444

; Ammo
    dw $1045, $103c, $103d, $103e, $103f, $1040, $1041, $1042, $1043, $1044
    
;etank draw removal
org $809bcf
    jmp $9c16
