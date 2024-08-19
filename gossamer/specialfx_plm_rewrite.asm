; change between two different transparency types every frame
; just uses the existing types that you would set in the fx1 fields in the editor
; uses the plm argument bytes to define this

; additionally, this can change the backdrop color
; to do this, place the plm in the third column of the room
;(starting from the leftmost edge of the room)
;to define the backdrop, use the first two tiles of the room (top left)
;setting backdrop is useful if you have one tileset for which you want to use
;a different backdrop color in different rooms

lorom

!oscillator         = $09da     ; this is the game time frame counter
!plmentry           = $f000     ; put in available $84 freespace

org $840000+!plmentry
    dw #setup, #instructionlist

setup:
    ;=====================================================UNCOMMENT THIS BEFORE RELEASE. SMART'S QUICKMET MAKES THIS ALWAYS BRANCH
    lda $09ea               ; special fx option (replaced the icon cancel option. saved to sram)
    cmp #$0000
    beq optout              ; if it is 0 then don't do any of this
    ;=====================================================THIS IS THE CHECK FOR MAIN MENU OPTION
rts
	optout:
	jsr setbackdrop
	ldx $1c27
	jsr $86bc               ; delete plm
rts

instructionlist:
    dw $86c1, #main         ; set pre-instruction to main
    dw $86b4                ; sleep

main:
    jsr setbackdrop
	
    lda !oscillator
    bit #$0001              ; test the 1 bit of the frame counter
    bne low                 ; if it is not set, branch
	
    ldy $1c27
    lda $1dc7,y				; plm argument
    and #$ff00				; \take high byte
    xba						; /
    sta $1984				; set transparency b to that value
rts

low:
    ldy $1c27
    lda $1dc7,y				; plm argument
    and #$00ff				; take low byte
    sta $1984				; set transparency b (change this to $1982 if there is no layer 3 effect)
rts

setbackdrop:
    ldx $1c27					;plm id in x
    jsl $848290					;get plm position
	
    lda $1c29					;plm x position
    cmp #$0002
    bne dontsetbackdrop			;exit unless this plm is in the third column from the left of the room
	
    lda $7f6402					;first two tiles in top left of the the room
    sta $7ec000					;use them as the backdrop (useful for layer blending type $16)
	
    dontsetbackdrop:			;otherwise exit
rts
