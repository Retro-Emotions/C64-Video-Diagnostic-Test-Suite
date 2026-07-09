; ==============================================================================
; TEST 5: RASTER TIMING STABILITY (DYNAMIC BARS)
; Percorso: src/prg/raster_stability.asm
; ==============================================================================
go_test_5
    sei                     ; Disattiva gli interrupt per avere il controllo totale del timing

; 1. Pulisce lo schermo (nasconde i testi del menù durante il test)
    +fill_1k screenmembase, CHAR_SPACE

; 2. Forza bordo e sfondo iniziali a NERO
    lda #COLOR_BLACK
    sta VIC_BORDERCOLOR
    sta VIC_GBKGCOLOR0

; ==============================================================================
; LOOP PRINCIPALE DEL RASTER CON ATTESA DOPPIA PER LINEA DRITTA
; ==============================================================================
.raster_loop_5
; --- PASSO 1: Aspetta la riga precedente (129) ---
.wait_line_129
    lda VIC_RASTCNT
    cmp #129
    bne .wait_line_129

; --- PASSO 2: Aspetta l'istante esatto del passaggio alla riga 130 ---
.wait_line_130
    lda VIC_RASTCNT
    cmp #130
    bne .wait_line_130

; --- DISEGNO LINEARE SENZA LOOP INTERNI ---
    lda #COLOR_BLUE
    sta VIC_GBKGCOLOR0          ; Riga 130: Accende il Blu
    nop
    lda #COLOR_CYAN
    sta VIC_GBKGCOLOR0          ; Riga 131: Accende l'Azzurro
    nop
    lda #COLOR_WHITE
    sta VIC_GBKGCOLOR0          ; Riga 132: Accende il Bianco (Centro)
    nop
    nop
    nop
    nop
    lda #COLOR_CYAN
    sta VIC_GBKGCOLOR0          ; Riga 133: Torna ad Azzurro
    nop
    lda #COLOR_BLUE
    sta VIC_GBKGCOLOR0          ; Riga 134: Torna a Blu
    nop
    lda #COLOR_BLACK
    sta VIC_GBKGCOLOR0          ; Riga 135: Spegne e riporta tutto a Nero

; --- CONTROLLO HARDWARE TASTIERA (BARRA SPAZIATRICE) ---
    lda #%01111111
    sta cia1regsbase + $00
    lda cia1regsbase + $01
    and #%00010000
    beq .exit_test_5
    jmp .raster_loop_5

; ==============================================================================
; RIPRISTINO E RITORNO AL MENU PRINCIPALE
; ==============================================================================
.exit_test_5
    +fill_1k colormembase, COLOR_LT_GREY

    lda #COLOR_BLACK
    sta VIC_BORDERCOLOR
    sta VIC_GBKGCOLOR0

.wait_release_5
    lda cia1regsbase + $01
    and #%00010000
    beq .wait_release_5

    lda #$00
    sta $C6
    lda #KEY_NONE
    sta $C5

    cli
    jmp menu