;rewrite mmr activators

;pc address $027253
org $84f253     ;original end at 84f2bd
                ;original total length 6a bytes
                ;new length 2f bytes

lorom

dw #setup, #instructionlist

instructionlist:
	dw $86c1, #main, $86b4
	
setup:
	rts

main:
    ldx $1c27               ;x=plm id
    lda $1c87,x             ;a=plm block index in room
    lsr
    cmp $0dc4               ;compare to samus block
    bne end
    
    lda $1dc7,x
    and #$00ff              ;grab low byte of plm argument and set that event bit
    jsl $8081fa

    lda #$0019              ;sound $0019, g4 gem breaking, wooshing
    jsl $8090cb             ;play it

    ldx $1c27
    jsr $86bc               ;delete plm
    end:
    rts                     ;end at 84f282

warn pc