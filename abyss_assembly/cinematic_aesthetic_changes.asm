lorom

org $8bdbac
lda #$0000		; prevent changing to ship escaping/ending credits music

org $82B677		; skip the map sprite drawing
jmp $B6DB

;don't play baby metroid sounds
org $8BA25B
rts
org $8BA263
rts
org $8BA26B
rts

;don't spawn baby metroid
org $8B9A31
nop
nop
nop

;don't spawn title screen gradient
org $8B9B15
nop : nop : nop : nop

org $8B9E85
nop : nop : nop : nop

;cinematic sprite object edits for ending explosion:

;turn all instructions into delete
org $8BECED
dw $0001,$9438,$9438,$9438		;(yellow clouds - top - top half)
org $8BECF5
dw $0001,$9438,$9438,$9438		;(yellow clouds - top - bottom half)
org $8BECFD
dw $0001,$9438,$9438,$9438		;(yellow clouds - bottom - top half)
org $8BED05
dw $0001,$9438,$9438,$9438		;(yellow clouds - bottom - bottom half)
org $8BED0D
dw $0001,$9438,$9438,$9438		;(yellow clouds - right)
org $8BED15
dw $0001,$9438,$9438,$9438		;(yellow clouds - left)

;modify the explosion by skipping some stuff
org $8BF2E6
nop : nop : nop : nop
org $8BF2ED
nop : nop : nop : nop
org $8BF2F4
nop : nop : nop : nop

org $8BD6F5
nop : nop : nop : nop : nop

org $8BD725
nop : nop : nop

org $8BD7FB
nop : nop : nop		;this bugger was the one causing the screen brightness badness


org $98bcd6		;im sure this does something but i forget
padbyte $00
pad $98ed4e