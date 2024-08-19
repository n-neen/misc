lorom

org $8190cd             ;skip handling baby metroid
    nop #4

org $8191a6
    lda #$11
    sta $69
    lda #$2f            ;red component             ;backdrop color
    sta $74
    lda #$4f            ;green compnent
    sta $75
    lda #$8f            ;blue component
    sta $76

org $81929d             ;game over gradient HMDMA table
    db $81, $a1
    db $81, $a1
    db $81, $21
    db $81, $21
    db $00, $00

org $819239             ;overwrite baby metroid call with color math stuff
    nop #4              ;this whole thing may not do anything
    lda #$ff
    sta $6f
    nop #3

org $82bb9e             ;sip drawing baby metroid
    plb
    rtl

org $82bc0c             ;nop out sound calls
    nop #7
    skip 2
    nop #7
    skip 2
    nop #7