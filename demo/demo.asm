lorom

;===========================================================================================
;===================================               =========================================
;===================================    D E M O    =========================================
;===================================               =========================================
;===========================================================================================


incsrc "./defines.asm"

;===========================================================================================
;===================================               =========================================
;===================================   B A N K S   =========================================
;===================================               =========================================
;===========================================================================================

;code
incsrc "./bank80.asm"           ;boot, main, interrupts
;incsrc "./bank81.asm"           ;dma, graphics and palette loading
;incsrc "./bank82.asm"           ;gameplay
;incsrc "./bank83.asm"           ;house, rooms definitions
;incsrc "./bank84.asm"           ;tile objects
;incsrc "./bank85.asm"           ;reserved for glider
;incsrc "./bank86.asm"           ;reserved for code

;data
;incsrc "./bank90.asm"           ;splash screen graphics
;incsrc "./bank91.asm"           ;reserved for data
;incsrc "./bank92.asm"           ;palettes, sprite data, background tilemaps
;incsrc "./bank93.asm"           ;bg01 graphics
;incsrc "./bank94.asm"           ;bg02 graphics



;===========================================================================================
;==================================               ==========================================
;==================================  H E A D E R  ==========================================
;==================================               ==========================================
;===========================================================================================


org $80ffc0                             ;game header
    db "demo                 "          ;cartridge name
    db $30                              ;fastrom, lorom
    db $02                              ;rom + ram + sram
    db $12                              ;rom size = 4mb
    db $03                              ;sram size 4kb
    db $00                              ;country code
    db $69                              ;developer code
    db $00                              ;rom version
    dw $FFFF                            ;checksum complement
    dw $FFFF                            ;checksum
    
    ;interrupt vectors
    
    ;native mode
    dw #errhandle, #errhandle, #errhandle, #errhandle, #errhandle, #nmi, #errhandle, #irq
    
    ;emulation mode
    dw #errhandle, #errhandle, #errhandle, #errhandle, #errhandle, #errhandle, #boot, #errhandle