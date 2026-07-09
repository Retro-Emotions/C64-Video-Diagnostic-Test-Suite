; ==============================================================================
; REGISTRI VIDEO VIC-II
; ACME 0.97
; ==============================================================================

!cpu 6510

; --- Coordinate dei 56 Registri del VIC-II ---
VIC_SPRITE0_X   = vicregsbase + $00     ; Coordinata X dello Sprite 0
VIC_SPRITE0_Y   = vicregsbase + $01     ; Coordinata Y dello Sprite 0
VIC_SPRITE1_X   = vicregsbase + $02     ; Coordinata X dello Sprite 1
VIC_SPRITE1_Y   = vicregsbase + $03     ; Coordinata Y dello Sprite 1
VIC_SPRITE2_X   = vicregsbase + $04     ; Coordinata X dello Sprite 2
VIC_SPRITE2_Y   = vicregsbase + $05     ; Coordinata Y dello Sprite 2
VIC_SPRITE3_X   = vicregsbase + $06     ; Coordinata X dello Sprite 3 (Secondo Nemico)
VIC_SPRITE3_Y   = vicregsbase + $07     ; Coordinata Y dello Sprite 3 (Secondo Nemico)
VIC_SPRITE4_X   = vicregsbase + $08     ; Coordinata X dello Sprite 4
VIC_SPRITE4_Y   = vicregsbase + $09     ; Coordinata Y dello Sprite 4
VIC_SPRITE5_X   = vicregsbase + $0A     ; Coordinata X dello Sprite 5
VIC_SPRITE5_Y   = vicregsbase + $0B     ; Coordinata Y dello Sprite 5
VIC_SPRITE6_X   = vicregsbase + $0C     ; Coordinata X dello Sprite 6
VIC_SPRITE6_Y   = vicregsbase + $0D     ; Coordinata Y dello Sprite 6
VIC_SPRITE7_X   = vicregsbase + $0E     ; Coordinata X dello Sprite 7
VIC_SPRITE7_Y   = vicregsbase + $0F     ; Coordinata Y dello Sprite 7
VIC_MSB_X       = vicregsbase + $10     ; Bit più significativi (9° bit) per le X degli Sprite 0-7

; --- Controllo Video e Interruzioni ---
VIC_CTRLREG1    = vicregsbase + $11     ; Control register 1 Y scroll e controllo verticale
VIC_SCROLL_Y    = vicregsbase + $11     ; Alias per registro di controllo verticale e scorrimento fine
VIC_RASTCNT     = vicregsbase + $12     ; Raster counter
VIC_LPEN_X      = vicregsbase + $13     ; Coordinata X Penna Ottica (Lightpen)
VIC_LPEN_Y      = vicregsbase + $14     ; Coordinata Y Penna Ottica (Lightpen)

; --- Configurazione degli Sprite ---
VIC_SPRITE_EN   = vicregsbase + $15     ; Registro per attivare/disattivare gli sprite
VIC_CTRLREG2    = vicregsbase + $16     ; Control register 2 X scroll e modalità schermo
VIC_SPR_EXP_Y   = vicregsbase + $17     ; Espansione verticale degli Sprite 0-7
VIC_MEMPTRS     = vicregsbase + $18     ; Memory pointers per Schermo e Set di Caratteri
VIC_INTSTATREG  = vicregsbase + $19     ; Interrupt status register (Flag di interruzione)
VIC_INTCTRLREG  = vicregsbase + $1A     ; Interrupt control register (Abilitazione interruzioni)
VIC_SPR_PRIO    = vicregsbase + $1B     ; Priorità degli Sprite rispetto al background
VIC_SPR_MCM     = vicregsbase + $1C     ; Abilitazione modalità multicolore degli Sprite 0-7
VIC_SPR_EXP_X   = vicregsbase + $1D     ; Espansione orizzontale degli Sprite 0-7

; --- Collisioni ---
VIC_SP_COLL     = vicregsbase + $1E     ; Registro collisioni Sprite-to-Sprite
VIC_BG_COLL     = vicregsbase + $1F     ; Registro collisioni Sprite-to-Background

; --- Registri dei Colori del VIC-II ---
VIC_BORDERCOLOR = vicregsbase + $20     ; Border color
VIC_GBKGCOLOR0  = vicregsbase + $21     ; Background color 0
VIC_GBKGCOLOR1  = vicregsbase + $22     ; Background color 1
VIC_GBKGCOLOR2  = vicregsbase + $23     ; Background color 2
VIC_GBKGCOLOR3  = vicregsbase + $24     ; Background color 3
VIC_SPRITEMC0   = vicregsbase + $25     ; Sprite multicolor 0
VIC_SPRITEMC1   = vicregsbase + $26     ; Sprite multicolor 1

; --- Colori Individuali degli Sprite ---
VIC_SPRITEC0    = vicregsbase + $27     ; Sprite color 0
VIC_SPRITEC1    = vicregsbase + $28     ; Sprite color 1
VIC_SPRITEC2    = vicregsbase + $29     ; Sprite color 2
VIC_SPRITEC3    = vicregsbase + $2A     ; Sprite color 3
VIC_SPRITEC4    = vicregsbase + $2B     ; Sprite color 4
VIC_SPRITEC5    = vicregsbase + $2C     ; Sprite color 5
VIC_SPRITEC6    = vicregsbase + $2D     ; Sprite color 6
VIC_SPRITEC7    = vicregsbase + $2E     ; Sprite color 7
