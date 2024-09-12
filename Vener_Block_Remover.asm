lorom


;for Xray working well , the header of the PLM must be placed before $84:DF89 

;PLM room argument format :

;x--- : number of blocks to destroy horizontally
;-x-- : number of blocks to destroy vertically
;--xx : event bit




org $84xxxx  ; No returning blocks PLM headers : 

dw INIT,LIST ;(PLM header)

LIST:

dw INST,$86BC ;(PLM instruction list)





org $84xxxx  

INIT:

    LDA $1DC7,y      ;(PLM room argument)
    AND #$00FF       
    JSL $80818E      ;(check event bit)  
    LDA $7ED8C0,x    
    AND $05E7        
    BNE +            ;(jump because event bit is set)  

    RTS              


;Destroy block(s) :

  + TYX              
    LDA #$9497       ;(unused draw instruction pointer to write 1 air block)
    STA $7EDE6C,x    ;(current animation to write)

    LDA $1DC7,x      ;(PLM room argument)
    AND #$0F00       
    XBA              
    STA $7A          ;(number of blocks to write per columns)

    LDA $1DC7,x      ;(PLM room argument)
    AND #$F000       
    LSR              
    LSR              
    LSR                  
    LSR              
    XBA              
    STA $78          ;(number of blocks to write per rows)
    STA $7C          
    BRA ++           


;Writing blocks loop :

  - TYX              
    INC $1C87,x      ;(PLM's location in the room) 
    INC $1C87,x      ;(PLM's location in the room) 

 ++ JSR $861E        ;(process PLM draw instruction)

    LDX $1C27        ;(current PLM index)
    JSL $848290      ;(get PLM coordinates)
    JSR $8DAA        ;(draw PLM routine)

    LDY $1C27        ;(current PLM index)
    LDX $1C87,y      ;(PLM's location in the room) 
    LDA #$00FF       ;(air block)
    JSR $82B4        ;(Write block type and BTS)

    DEC $78          ;(number of blocks per row)
    BNE -            

    DEC $7A          ;(number of blocks per columns)
    BEQ +            

    TYX              
    LDA $7C          
    STA $78          ;(restore number of blocks to write per rows)

    LDA $1C87,x      ;(PLM's location in the room)
    SEC              
    SBC $78          ;(restore initial X PLM pos.)
    SBC $78          
    CLC                     
    ADC $07A5        ;(room width in blocks)
    ADC $07A5         
    STA $1C87,x      ;(and add +1 to PLM y pos.)  
    BRA -            

  + LDA #$0001       ;(delete)
    STA $1C37,x      ;(current PLM ID) 
    RTS              




org $84xxxx ; doesn't mark the event bit if the block is revealed & reconcealed , only when breaked :

INST:

    LDA $1C87,x      ;(PLM's location in the room) 
    TAX              
    LDA $7F0002,x    ;(Room Tilemap)
    CMP #$00FF       ;(the block has been turned to air ?) 
    BEQ +            ;(jump if yes)
 
    LDX $1C27        ;(current PLM index)
    LDA #$0001       
    STA $7EDE1C,x     
    JMP $86B4        ;(jump to sleep instruction)

  + LDX $1C27        ;(current PLM index)
      
    LDA $1DC7,x      ;(PLM room argument)
    AND #$00FF       
    JSL $80818E      
    LDA $7ED8C0,x    
    ORA $05E7        
    STA $7ED8C0,x    ;(set event bit)
    LDX $1C27        ;(current PLM index)
    RTS              




