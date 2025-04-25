lorom

!82free     =       $82fde1
    
org $82ed53
    jsr decjack
    
org $82ed72
    jsr incjack
    
org !82free
    decjack:    ;missile is going up
    dec $099e
    lda $099e
    cmp #$0002
    bne +
    stz $099e
+   rts
    
    incjack:    ;missile is going down
    sta $099e
    lda $099e
    cmp #$0001
    bne +
    lda #$0003
    sta $099e
+   rts

org $978df4
    incbin "./compressed_options_menu__nojp_tilemap.bin"
    


;org $82eda7             

;    dw  $edb1, ; start game                 ;0

;        $ee55, ; english text               ;1 do not want this
;        $ee55, ; japanese text              ;2 or this

;        $ee55, ; controller setting mode    ;3
;        $ee55  ; special setting mode       ;4

;org $82f307

;    dw  $0018,$0038, ; 0: Start game
;        $0018,$0090, ; 1: English text
;        $0018,$0090, ; 2: Japanese text
;        $0018,$0090, ; 3: Controller setting mode
;        $0018,$00B0  ; 4: Special setting mode