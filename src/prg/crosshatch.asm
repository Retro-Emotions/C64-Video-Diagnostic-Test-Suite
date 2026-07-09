; ==============================================================================
; TEST 1: GRIGLIA GEOMETRICA (CROSSHATCH HI-RES BITMAP)
; Percorso: src/prg/crosshatch.asm
; ==============================================================================
!zone crosshatch

GFX_SCREEN_RAM = $0C00       ; Ripristinata alla locazione standard
GFX_BITMAP_RAM = $2000

crosshatch
    sei                     ; Disattiva gli interrupt per stabilità totale

    // Inizializza colori schermo
    ;lda #COLOR_BLACK
    ;sta VIC_BORDERCOLOR
    ;sta VIC_GBKGCOLOR0

; 1. Imposta i colori della RAM Schermo Grafica ($0C00)
    lda #$10
    ldx #0
.color_setup_cross
    sta GFX_SCREEN_RAM, x
    sta GFX_SCREEN_RAM + $0100, x
    sta GFX_SCREEN_RAM + $0200, x
    sta GFX_SCREEN_RAM + $0300, x
    inx
    bne .color_setup_cross

; 2. INIZIALIZZAZIONE PUNTATORE BITMAP (ZERO PAGE)
    lda #<GFX_BITMAP_RAM
    sta $fb
    lda #>GFX_BITMAP_RAM
    sta $fc

; 3. PULIZIA BITMAP E DISEGNO RETICOLO
    ldx #0
.page_loop_cross
    ldy #0
.byte_loop_cross
    tya
    and #%00000111
    bne .draw_vertical
; Linea Orizzontale
    lda #%11111111
    jmp .store_cross
.draw_vertical
; Linea Verticale
    lda #%10000000
.store_cross
    sta ($fb),y
    iny
    bne .byte_loop_cross
; Avanzamento Pagina
    inc $fc
    inx
    cpx #BITMAP_PAGES
    bne .page_loop_cross

; 4. ATTIVAZIONE HARDWARE MODALITÀ GRAFICA BITMAP STANDARD
; %00111000 -> Schermo a $0C00, Bitmap a $2000
    lda #%00111000
    sta VIC_MEMPTRS
    lda VIC_CTRLREG1
    ora #%00100000
    sta VIC_CTRLREG1

    cli

.wait_space
    lda KEY_PRESSED
    cmp #6
    bne .wait_space

    jmp menu
