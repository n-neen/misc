lorom

org $8B9F29         ;remove title demos (attract mode)

LDA $1F53

org $8289ea         ;skip hex map
    inc $0998
    rts