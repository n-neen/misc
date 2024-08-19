lorom

;the basic jist is that this removes or obscures (moves offscreen, etc) a lot of the ending sprites
;and keeps the backdrop white the whole time (except right after the clear time screen; this is
;about a second of tile decompressing and transfers that i do not want to rewrite
;this is a huge mess and i even forgot to comment a lot of it. booooo

org $8bdbac
lda #$0000		; prevent changing to ship escaping/ending credits music

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
nop : nop : nop     ;this bugger was the one causing the screen brightness badness

org $98bcd6         ;im sure this does something but i forget
padbyte $00
pad $98ed4e

;color math skips (does nothing?)
org $8284e6
jmp $84f8

org $8bd679
jmp $d689

org $8bde86         ;skip clearing palette objects
nop #4

;palette skips
org $8bda55
nop #8
org $8bdbfa         ;this specifically stops the backdrop being set
nop #12

org $8bde8d         ;load credits palette
lda $8ce9e9,x       ;this skips the backdrop
sta $7ec002,x
org $8bde97
cpx #$0100


;pretty sure changing these palettes is useless
org $8CE7E9     ;post credits palettes
;dw $7fff, $7fff, $7fff, $7fff, $7fff, $7fff, $7fff, $7fff, $7fff, $7fff, $7fff, $7fff, $7fff, $7fff, $7fff, $7fff
;dw $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969
;dw $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969
;dw $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969
;dw $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969
;dw $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969
;dw $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969
;dw $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969

;dw $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969
;dw $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969
;dw $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969
;dw $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969
;dw $7fe0, $77a0, $6f60, $6720, $5ee0, $56a0, $4e60, $4620, $39c0, $3180, $2940, $2100, $18c0, $1080, $0840, $0000
;dw $7fe0, $77a0, $6f60, $6720, $5ee0, $56a0, $4e60, $4620, $39c0, $3180, $2940, $2100, $18c0, $1080, $0840, $0000
;dw $7fe0, $77a0, $6f60, $6720, $5ee0, $56a0, $4e60, $4620, $39c0, $3180, $2940, $2100, $18c0, $1080, $0840, $0000
;dw $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969

org $8CE9E9     ;credits palettes
;dw $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969
;dw $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969
;dw $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969
;dw $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969
;dw $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969
;dw $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969
;dw $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969
;dw $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969

;dw $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969
;dw $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969
;dw $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969
;dw $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969
;dw $7fe0, $77a0, $6f60, $6720, $5ee0, $56a0, $4e60, $4620, $39c0, $3180, $2940, $2100, $18c0, $1080, $0840, $0000
;dw $7fe0, $77a0, $6f60, $6720, $5ee0, $56a0, $4e60, $4620, $39c0, $3180, $2940, $2100, $18c0, $1080, $0840, $0000
;dw $7fe0, $77a0, $6f60, $6720, $5ee0, $56a0, $4e60, $4620, $39c0, $3180, $2940, $2100, $18c0, $1080, $0840, $0000
;dw $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969, $6969

;ending shot
;space is from $97:f987 to $98:8303
;pc address range $0BF987 to $0C0303

;org $ff8000          ;ending shot graphics
;incbin "./newinterleavedcompressed.bin"         ;size 2605 bytes, $a2d
                                                ;vanilla size $97b

;org $8bdef1            ;decompression source for the above
;lda #$ff00             ;bank
;skip 2
;lda #$8000             ;address


org $8bd4a9         ;cinematic palette loading: planet zoom
nop #4

org $8bd982
nop #4

org $8bda59
nop #4

org $8be4c7
nop #4

org $8bf710         ;post credits palette
nop #4

org $8bf71d
nop #6

;exploding zebes inst list stuff, mostly just skipping to the end of the lists

org $8beb0f
dw $f295, $9438

org $8bde64
jmp $DE6F

org $ebeb3d
dw $94bc,$eb3d

org $8beb59
dw $94BC,$EB5D

org $8beb51
dw $94BC,$EB51

org $8beffd             ;move sprite offscreen
lda #$0fff

org $8beb29
dw $0010, $a3ee
dw $0010, $a404
dw $0010, $a41a
dw $0010, $a430

org $8be09e             ;write to force blank register at end of credits setup (decomp)
sta $51

org $8b841c
jmp $8440


;keep this here to remember not to change this==========================================
org $8b8296             ;skip writing to forced blank register                              ;keep vanilla
lda #$80                ;do not change this
sta $2100
sta $51

org $8b83d6             ;same as above
lda #$80                ;changing this breaks tile loading somehow                          ;keep vanilla
sta $2100               ;smiley sez: "Can't load graphics outside of a blanking period"
sta $51
;vanilla bytes==========================================================================

org $8beb69
dw $0002,$A57C          ;vanilla silhoutte
dw $F2B7

org $8beb71             ;change timers for active explosion sprite
dw $0060, $A28B
dw $F2FA
dw $0110,$A28B

org $8beb89             ;afterglow
dw $0010, $A5E2, $94BC, $EB89

org $8bf018
lda #$0fff
skip 3
lda #$0fff

org $8bf32e
nop #4

org $8bf32c
bra skip
org $8bf334 : skip:

org $8befea             ;stars move offscreen
lda #$0fff

org $8beff0             ;stars move offscreen
lda #$0fff

org $8bf057
lda #$0900              ;"CLEAR TIME" palette index

org $8BF04A             ;time digits palette index
lda #$0900

org $8BF037             ;THE OPERATION WAS palette index
lda #$0c00

org $8BF14F             ;ending samus (without suit) palette index
lda #$0000

