lorom

!return         =       $c654
!setcolorindex  =       $c655
!done           =       $c595
!goto           =       $c61e
!delete         =       $c5cf

macro colorentry(color, diff, times, frames)
    dw <frames>
    dw <color>+(<diff>*<times>)
    dw !done
endmacro

org $8dc5c6
    pfo:
        dw !return, .list
        
org $8dd9d0
    .list:
        dw !setcolorindex, $0000        ;7ec000, the screen backdrop color
        
        %colorentry($0c01, $1, 0, 15)   ;up
        %colorentry($0c01, $1, 1, 15)
        %colorentry($0c01, $1, 2, 15)
        %colorentry($0c01, $1, 3, 15)
        
        %colorentry($0c01, $1, 4, 30)
            
        %colorentry($0c01, $1, 3, 10)    ;down
        %colorentry($0c01, $1, 2, 10)
        %colorentry($0c01, $1, 1, 10)
        %colorentry($0c01, $1, 0, 30)

        dw !goto, .list
        ;warn pc            ;db62