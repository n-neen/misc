lorom

; door scroll fix by Black_Falcon v1.2

; v1.1 fixes several issues related to me being bad at coding half a century ago.
; v1.2 implements a much better way of modifying an existing routine, which smoothly scrolls the screen into position until the transition is performed
;      this version can be safely applied over the old one.
;
; if there are any other issues, feel free contact me on the metconst discord

!posScreenSubx	= $0910
!posScreenSuby = $0914
!posScreenx = $0911
!posScreeny = $0915

!transitionType = $0791                                     ; Current room transition direction. 0 = right, 1 = left, 2 = down, 3 = up. +4 = Close a door on next screen

org $82DE32 : STA !transitionType                           ; override previous hijack, can be deleted after applying once

org $82E310

    PEA $8F00 : PLB : PLB
    PHY : LDY #$0002                                        ; Y will be decremented if done scrolling
    LDA #$00FF : TRB !posScreenSubx : TRB !posScreenSuby    ; get rid of subscreen positions
    JSR FIXHORSCROLL : JSR FIXVERSCROLL                     
    CPY #$0000 : BNE BRANCH_RETURN                          ; Y will be 0 if the screen is in position
BRANCH_NEXT:
    LDA #$E353 : STA $099C                                  ; screen is in position, ready to perform transition
BRANCH_RETURN:
    JSL $80A3AB                                             ; Calculate layer 2 and BG scrolls and update BG graphics when scrolling
    PLY : RTS

padbyte $FF : pad $82E352                                   ; free up some space

org $82F710
 { ; free space

FIXHORSCROLL:
        LDA !posScreenSubx : BIT #$FF00 : BEQ HORFIX
        BMI HORINC
HORDEC: DEC !posScreenx : RTS
HORINC: INC !posScreenx : RTS
HORFIX: DEY : RTS

FIXVERSCROLL:
        LDA !transitionType : AND #$0003 : CMP #$0002 : BNE NOTDOWN
        LDA !posScreenSuby : CMP #$1F00 : BEQ VERFIX        ; special treatment for downwards transitions
        BMI VERINC : BRA VERDEC
        
NOTDOWN:                                                    
        LDA !posScreenSuby : BIT #$FF00 : BEQ VERFIX
        BMI VERINC
VERDEC: DEC !posScreeny : RTS
VERINC: INC !posScreeny : RTS
VERFIX: DEY : RTS
	
}
;padbyte $FF : pad $82F800                                   ; free up some space used by the previous version
;org $8FEA00 : padbyte $FF : pad $8FEA3F
	
	
	
	
	
	
	