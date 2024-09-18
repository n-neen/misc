


;frame delay start:
;    $400
;   
;frame delay end:
;   0
;
;duration of ramp:
;   60 minutes
;   60 table entries
;
;
;
;

;1000/60


;delaytable macro
macro list(startvalue, endvalue, numberofentries)
    !a #= <startvalue>
    !stepwidth #= <endvalue>/<numberofentries>
    
    while !a < <endvalue>+!stepwidth
        dw !a
        !a #= !a+!stepwidth
    endwhile
    
endmacro