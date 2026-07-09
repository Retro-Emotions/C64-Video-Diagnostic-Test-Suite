; ==============================================================================
; TEST 2: 16 COLOR BARS (LUMINANCE CORRETTA)
; Percorso: src/prg/colorbars.asm
; ==============================================================================
!zone colorbars

TEMP_COLOR_IDX = $0336      ; Variabili runtime in RAM (cassette buffer)
TEMP_ROW       = $0337
COL_OFFSET     = $0338

colorbars
    sei                     ; Disattiva gli interrupt per stabilità video
; Riempie lo schermo con il carattere blocco pieno
+fill_1k screenmembase, CHAR_SOLID
+fill_1k colormembase, COLOR_LT_GREY

; 3. DISEGNO DELLE BARRE VERTICALI TRAMITE TABELLA DI LOOKUP
    ldx #0                  ; X = Contatore delle 25 righe dello schermo (0-24)
.row_loop
    lda color_rows_lo, x
    sta $FB
    lda color_rows_hi, x
    sta $FC
    stx TEMP_ROW            ; Salva l'indice della riga corrente

    ldy #0                  ; Y = Indice del colore corrente da disegnare (0-15)
.bar_loop
    sty TEMP_COLOR_IDX      ; Salva l'indice del colore corrente

; Calcola la colonna di partenza sulla riga: (Indice Colore * 2) + 4 di margine
    tya
    asl                     ; Moltiplica per 2 (larghezza barra = 2 colonne)
    clc
    adc #4                  ; Aggiunge il margine di centratura
    sta COL_OFFSET          ; Memorizza temporaneamente l'offset

; Carica il codice colore effettivo corrispondente dalla tabella di luminanza
    ldy TEMP_COLOR_IDX
    lda luminance_table, y  ; A contiene il colore effettivo da scrivere

; Sposta l'offset della colonna calcolato nel registro Y per l'indicizzazione indiretta
    ldy COL_OFFSET

; Scrive lo stesso colore in due colonne adiacenti nella Color RAM
    sta ($FB), y            ; Prima colonna della barra
    iny
    sta ($FB), y            ; Seconda colonna della barra

; Ripristina l'indice del colore per verificare il ciclo
    ldy TEMP_COLOR_IDX
    iny
    cpy #16                 ; Abbiamo completato i 16 colori su questa riga?
    bne .bar_loop

; --- AVANZAMENTO ALLA RIGA SUCCESSIVA ---
    ldx TEMP_ROW            ; Ripristina l'indice della riga
    inx
    cpx #25                 ; Abbiamo fatto tutte le 25 righe?
    bne .row_loop

    cli
.wait_space
    lda KEY_PRESSED
    cmp #6
    bne .wait_space
    jmp menu

; ==============================================================================
; DATI (tabelle read-only, possono restare in ROM)
; ==============================================================================
luminance_table
!byte COLOR_BLACK, COLOR_BLUE, COLOR_BROWN, COLOR_DK_GREY
!byte COLOR_RED, COLOR_PURPLE, COLOR_ORANGE, COLOR_MD_GREY
!byte COLOR_GREEN, COLOR_LT_RED, COLOR_LT_GREY, COLOR_CYAN
!byte COLOR_YELLOW, COLOR_LT_GREEN, COLOR_LT_BLUE, COLOR_WHITE

color_rows_lo
!byte $00, $28, $50, $78, $a0, $c8, $f0, $18, $40, $68, $90, $b8, $e0, $08, $30, $58, $80, $a8, $d0, $f8, $20, $48, $70, $98, $c0
color_rows_hi
!byte $d8, $d8, $d8, $d8, $d8, $d8, $d8, $d9, $d9, $d9, $d9, $d9, $d9, $da, $da, $da, $da, $da, $da, $da, $db, $db, $db, $db, $db