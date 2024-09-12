


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

macro list(startvalue, endvalue, numberofentries)             ;$8000, 60, 4b0 intended usage for now
    !a #= <startvalue>
    !stepwidth #= <endvalue>/<numberofentries>
    
    while !a < <endvalue>
        dw !a
        !a #= !a+!stepwidth
    endwhile
    
    dw $0000
endmacro