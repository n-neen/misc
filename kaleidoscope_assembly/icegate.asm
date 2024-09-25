lorom

org $84c5dc     ;shot block bts 4c shot reaction plm setup (yellow gate trigger, left)
    bit #$0002
    beq $03

org $84c5fa     ;shot block bts 4d shot reaction plm setup (yellow gate trigger, right)
    bit #$0002
    beq $03
    