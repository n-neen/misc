;Skipping Ceres, version 2.2 (MODIFIED) by Black Falcon
;What this does: Skips white 'Last Metroid...' quirks + Ceres sequence + Fly-To-Zebes Cutscene
;Intro text can be edited as usual, Samus will begin immediately at the landing site after the text is gone.

;version 2.1: Fixed a reset game bug that made the game unplayable because it restarted everytime you selected a slot. (found by JAM)

;version 2.2: Small code optimization by JAM.

lorom

org $8BA592									;this part skips the white text at the very beginning

	LDA #$B72F : STA $1F51					;(set the LDA to #$A5A7 to enable the intro sequence)
											;starts loading green text and intro music
	
org $8BA613									;at this location there would normally be code that displays the white text
											;since it's useless now, I can use it to prevent using free space		
STUFF:
	;LDA #$0001 : LDX #$000C : JSL $8081A6	;Sets Boss bit in Ceres (Ridley escaped)
	LDA #$0000 : STA $7ED914				;set game state mirror to #$0000 (Prevents ship from initialising landing sequence)
	LDA #$0006 : STA $0998					;start new game
	STZ $0723 : STZ $0725
	JSL $A2A9A0 : RTS						;The save routine taken from when Samus arrived on the planet for the first time.

org $8BBDCC									;this runs after the green text is gone (this is where the 'fly to Ceres' cutscene would start)
	;JAM: Optimizing the code a bit.
	LDA #$A395 : STA $1F51 : JSR STUFF		;hijacked routine
	RTS										;We're done already
