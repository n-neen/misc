


macro loadby_y(value, templocation)
    ldy #<templocation>
    lda #<value>
    sta <templocation>
endmacro


;delay table------------------------------------------------------------------------
macro list(startvalue, endvalue, numberofentries)
    !a #= <startvalue>
    !stepwidth #= <endvalue>/<numberofentries>
    
    while !a < <endvalue>+!stepwidth
        dw !a
        !a #= !a+!stepwidth
    endwhile
    
endmacro

;probability table--------------------------------------------------------------------
macro table_entry(item)
    %table_write(<item>, !prob_<item>)
endmacro

macro table_write(item, repeats)
    !a #= <repeats>
    while !a > 0
        dw <item>
        !a #= !a-1
    endwhile
endmacro