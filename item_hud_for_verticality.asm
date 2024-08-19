lorom

;item ID hud for v e r t i c a l i t y

org $85c162
    jsl itemhud

org $80cc27
    itemhud:
    STA $7ED870,x       ;vanilla line we overwrote
    

    phx
    phy
    
    lda #$9dd3          ;\
    sta $00             ;| --- set tilemap pointer for hud routine
    lda #$0080          ;|
    sta $02             ;/
    
    ldx $1c27           ; x = plm id
    lda $1dc7,x         ; a = plm argument
    
    and #$01ff          ;value to draw = plm argument low byte plus $100 bit of whole word
    ldx #$00ac          ;location to draw at
    jsr $9d78           ;draw three hud digits
    
    ply
    plx
    
    rtl