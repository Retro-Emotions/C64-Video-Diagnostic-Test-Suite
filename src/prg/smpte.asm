; ==============================================================================
; TEST 4: SMPTE COLOR PATTERN (VERSIONE PUNTATORE ZERO-PAGE)
; Percorso: src/prg/smpte.asm
; ==============================================================================

;SMPTE_TEMP_ROW = $1F        ; Variabile in Zero Page libera
SMPTE_TEMP_ROW = $0334    ; area cassette buffer, sicura se non usi datassette

go_test_4
    sei                     ; Disattiva gli interrupt per stabilità totale

    ; 1. Imposta bordo e sfondo a NERO
    lda #COLOR_BLACK
    sta VIC_BORDERCOLOR
    sta VIC_GBKGCOLOR0

    ; 2. Riempie lo schermo con il carattere blocco pieno
    +fill_1k screenmembase, CHAR_SOLID

    ; 3. INIZIALIZZAZIONE PUNTATORE COLOR RAM ($D800)
    lda #<colormembase
    sta $FB
    lda #>colormembase
    sta $FC

    ; 4. LOOP DI SCRITTURA RIGA PER RIGA
    ldx #0                  ; X = Contatore delle 25 righe (0-24)
.row_loop_4
    stx SMPTE_TEMP_ROW      ; Salva l'indice della riga corrente

    ldy #0                  ; Y = Contatore delle 40 colonne (0-39)
.col_loop_4
    ; --- CONTROLLO DELLE 3 ZONE ORIZZONTALI IN VERTICALE ---
    ldx SMPTE_TEMP_ROW
    cpx #16                 ; Righe 0-15: Sezione Superiore
    bcs .not_top_4
    jmp .top_zone_4
.not_top_4
    cpx #18                 ; Righe 16-17: Sezione Media
    bcs .not_mid_4
    jmp .mid_zone_4
.not_mid_4
    jmp .bot_zone_4         ; Righe 18-24: Sezione Inferiore

; --- COLORI PARTE SUPERIORE (7 BARRE GRANDI) ---
.top_zone_4
    cpy #5
    bcc .set_blk_4
    cpy #10
    bcc .set_lgy_4
    cpy #15
    bcc .set_yel_4
    cpy #20
    bcc .set_cyn_4
    cpy #25
    bcc .set_grn_4
    cpy #30
    bcc .set_pur_4
    cpy #35
    bcc .set_red_4
    cpy #40
    bcc .set_blu_4
    jmp .set_blk_4

.set_blk_4
    lda #COLOR_BLACK
    jmp .store_4
.set_lgy_4
    lda #COLOR_LT_GREY
    jmp .store_4
    
.set_yel_4  lda #COLOR_YELLOW:    jmp .store_4
.set_cyn_4  lda #COLOR_CYAN:      jmp .store_4
.set_grn_4  lda #COLOR_GREEN:     jmp .store_4
.set_pur_4  lda #COLOR_PURPLE:    jmp .store_4
.set_red_4  lda #COLOR_RED:       jmp .store_4
.set_blu_4  lda #COLOR_BLUE:      jmp .store_4

; --- COLORI PARTE MEDIA (BARRE DI CONTROLLO) ---
.mid_zone_4
    cpy #5:   bcc .set_m_blk_4
    cpy #15:  bcc .set_m_blu_4
    cpy #25:  bcc .set_m_wht_4
    cpy #35:  bcc .set_m_dgy_4
    lda #COLOR_BLACK: jmp .store_4

.set_m_blk_4 lda #COLOR_BLACK:  jmp .store_4
.set_m_blu_4 lda #COLOR_BLUE:   jmp .store_4
.set_m_wht_4 lda #COLOR_WHITE:  jmp .store_4
.set_m_dgy_4 lda #COLOR_DK_GREY: jmp .store_4

; --- COLORI PARTE INFERIORE (PLUGE / BLOCCHI) ---
.bot_zone_4
    cpy #15:  bcc .set_b_blk_4
    cpy #20:  bcc .set_b_dgy_4
    cpy #30:  bcc .set_b_wht_4
    cpy #35:  bcc .set_b_mgy_4
    lda #COLOR_BLACK: jmp .store_4

.set_b_blk_4 lda #COLOR_BLACK:  jmp .store_4
.set_b_dgy_4 lda #COLOR_DK_GREY: jmp .store_4
.set_b_wht_4 lda #COLOR_WHITE:  jmp .store_4
.set_b_mgy_4 lda #COLOR_MD_GREY: jmp .store_4

; --- SCRITTURA EFFETTIVA E AVANZAMENTO COLONNA ---
.store_4
    sta ($FB), y

    iny
    cpy #40
    beq .next_row_4
    jmp .col_loop_4

; --- AVANZAMENTO RIGA (PUNTATORE ZERO-PAGE +40) ---
.next_row_4
    lda $FB
    clc
    adc #$28
    sta $FB
    lda $FC
    adc #$00
    sta $FC

    ldx SMPTE_TEMP_ROW
    inx
    cpx #25
    beq .wait_space_smpte_4
    jmp .row_loop_4

; --- ATTESA HARDWARE BARRA SPAZIATRICE ---
.wait_space_smpte_4
    lda #%01111111
    sta cia1regsbase + $00
    lda cia1regsbase + $01
    and #%00010000
    bne .wait_space_smpte_4

    ; --- RIPRISTINO MENU ---
    +fill_1k screenmembase, CHAR_SPACE
    +fill_1k colormembase, COLOR_LT_GREY

    lda #COLOR_BLACK
    sta VIC_BORDERCOLOR
    sta VIC_GBKGCOLOR0

.wait_release_smpte_4
    lda cia1regsbase + $01
    and #%00010000
    beq .wait_release_smpte_4

    lda #$00
    sta $C6
    lda #KEY_NONE
    sta $C5

    cli
    jmp menu