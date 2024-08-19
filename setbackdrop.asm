;================================================================set backdrop
;init pointer gets run too early i guess so do this in main room code? lol ok
;used in: color hall, blue sidehoppers, bluroom
;could be replaced by the plm but whateverrrrr
org $8ff1ad
	lda $7f6402		;grab first two tiles of room, bts value
    xba             ;do xba so we don't have to store the word endianly
	sta $7ec000
rts