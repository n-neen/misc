lorom


;defines
!minimap_enable     =       $05f7       ;0 = enabled


;remove vanilla minimap enabling spots
org $80c4af
    nop #3
org $828767
    nop #3
org $82e1c4
    nop #3
org $8882f3
    nop #3
org $90a921     ;main update minimap routine
    nop #2
org $90f233
    nop #3
org $a490c4
    nop #3
    
org $90aa43
    ;rtl

org $809af3
    nop #4
    
org $809aac
    ;cpx #$00c0  ;hud tilemap loop counter. vanilla = $00c0
    
   
    
org $8098cb     ;hud default tilemap lat five columns are edited
    dw $2C0F, $2C0F, $2C0F, $2C0F, $2C0F, $2C0F, $2C0F, $2C0F, $2C0F, $2C0F, $2C0F, $2C0F, $2C0F, $2C0F, $2C0F, $2C0F, $2C0F, $2C0F, $2C0F, $2C0F, $2C0F, $2C0F, $2C0F, $2C0F, $2C0F, $2C0F, $2C0F, $2C0F, $2C0F, $2C0F, $2C0F, $2C0F, 
       $2C0F, $2C0F, $2C0F, $2C0F, $2C0F, $2C0F, $2C0F, $2C0F, $2C0F, $2C0F, $2C0F, $2C0F, $2C0F, $2C0F, $2C0F, $2C0F, $2C0F, $2C0F, $2C0F, $2C0F, $2C0F, $2C0F, $2C0F, $2C0F, $2C0F, $2C0F, $2C0F, $2C0F, $2C0F, $2C0F, $2C0F, $2C0F, 
       $2C0F, $2C0B, $2C0C, $2C0D, $2C32, $2C0F, $2C09, $2C0F, $2C0F, $2C0F, $2C0F, $2C0F, $2C0F, $2C0F, $2C0F, $2C0F, $2C0F, $2C0F, $2C0F, $2C0F, $2C0F, $2C0F, $2C0F, $2C0F, $2C0F, $2C0F, $2C0F, $2C0F, $2C0F, $2C0F, $2C0F, $2C0F 
       
org $80988b+52  ;hud top row tilemap
    dw $2C0F, $2C0F, $2C0F, $2C0F, $2C0F, $2C0F
    