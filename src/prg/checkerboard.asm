; ==============================================================================
; TEST 3: CHECKERBOARD 1X1 (SHARPNESS TESTPATTERN)
; Percorso: src/prg/checkerboard.asm
; ==============================================================================
CHCK_SCREEN_RAM = $0C00       ; Ripristinata alla locazione standard
CHCK_BITMAP_RAM = $2000

go_test_3
    sei                     ; Disattiva gli interrupt

; 1. Configura lo Schermo Grafico ($0C00) -> Bianco su Nero ($10)
    lda #$10
    ldx #0
.color_setup_3
    sta CHCK_SCREEN_RAM, x
    sta CHCK_SCREEN_RAM + $0100, x
    sta CHCK_SCREEN_RAM + $0200, x
    sta CHCK_SCREEN_RAM + $0300, x
    inx
    bne .color_setup_3

; 2. INIZIALIZZAZIONE PUNTATORE BITMAP (ZERO PAGE)
    lda #<CHCK_BITMAP_RAM
    sta $fb
    lda #>CHCK_BITMAP_RAM
    sta $fc

; 3. DISEGNO DELLA SCACCHIERA
    ldx #0
.page_loop_3
    ldy #0
.byte_loop_3
    tya
    and #%00000001          ; Controllo riga pari/dispari del blocco
    bne .odd_row_3
; Riga Pari: Pattern %10101010
    lda #%10101010
    jmp .store_3
.odd_row_3
; Riga Dispari: Pattern %01010101
    lda #%01010101
.store_3
    sta ($fb),y
    iny
    bne .byte_loop_3
; Avanzamento di pagina
    inc $fc
    inx
    cpx #BITMAP_PAGES
    bne .page_loop_3

; 4. ATTIVAZIONE HARDWARE
    lda #%00111000          ; Schermo a $0C00, Bitmap a $2000
    sta VIC_MEMPTRS
    lda VIC_CTRLREG1
    ora #%00100000
    sta VIC_CTRLREG1

.wait_space_check_3
    lda #%01111111
    sta cia1regsbase + $00
    lda cia1regsbase + $01
    and #%00010000
    bne .wait_space_check_3

    lda VIC_CTRLREG1
    and #%11011111
    sta VIC_CTRLREG1
    lda #%00010100
    sta VIC_MEMPTRS
    lda #COLOR_BLACK
    sta VIC_BORDERCOLOR
    sta VIC_GBKGCOLOR0
.wait_release_check_3
    lda cia1regsbase + $01
    and #%00010000
    beq .wait_release_check_3
    lda #$00
    sta $C6
    lda #KEY_NONE
    sta $C5
    cli
    jmp menu