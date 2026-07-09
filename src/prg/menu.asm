; ==============================================================================
; GESTIONE MENU PRINCIPALE DIAGNOSTICO
; Percorso: src/prg/menu.asm
; LETTURA TASTI VIA IRQ CUSTOM (KEY_PRESSED, scansione CIA1)
; ==============================================================================
!zone crosshatch

menu
    sei

    ; Inizializza schermo
    lda #COLOR_BLACK
    sta VIC_BORDERCOLOR
    sta VIC_GBKGCOLOR0

    lda #%00011011          ; DEN=1, modalità testo 25 righe, RSEL=1
    sta VIC_CTRLREG1
    lda #%00010101          ; Screen RAM $0400, Char ROM $1000
    sta VIC_MEMPTRS

    ; Pulisce lo schermo (riempie con spazi)
    +fill_1k screenmembase, CHAR_SPACE
    +fill_1k colormembase, COLOR_LT_GREY

    lda #$00
    sta KEY_PRESSED         ; Resetta lo stato tasti ad ogni ridisegno menu

    ; Stampa del titolo centrato in alto (Riga 1, colonna 7)
    +print_msg title_string, 7, COLOR_GREEN

    ; Stampa del versione (Riga 3, colonna 16)
    +print_msg version_string, 96, COLOR_YELLOW

    ; Stampa delle singole voci del menù distanziate verticalmente
    +print_msg menu_1, 240, COLOR_WHITE     ; Riga 6
    +print_msg menu_2, 320, COLOR_WHITE     ; Riga 8
    +print_msg menu_3, 400, COLOR_WHITE     ; Riga 10
    +print_msg menu_4, 480, COLOR_WHITE     ; Riga 12
    +print_msg menu_5, 560, COLOR_WHITE     ; Riga 14

    cli

menu_input_loop
    lda KEY_PRESSED
    beq menu_input_loop
    cmp #1
    beq .t1
    cmp #2
    beq .t2
    cmp #3
    beq .t3
    cmp #4
    beq .t4
    cmp #5
    beq .t5
    jmp menu_input_loop

.t1
    jmp crosshatch
.t2
    jmp colorbars
.t3 jmp go_test_3
.t4 jmp go_test_4
.t5 jmp go_test_5

; ==============================================================================
; DATI E STRINGHE DEL MENU
; ==============================================================================
title_string
    !scr "c64 video diagnostic test"
    !byte 0
version_string
    !scr "v. 1.01"
    !byte 0
menu_1
    !scr " 1 - crosshatch geometry (hi-res)"
    !byte 0
menu_2
    !scr " 2 - 16 color bars (luminance)"
    !byte 0
menu_3
    !scr " 3 - checkerboard 1x1 (sharpness)"
    !byte 0
menu_4
    !scr " 4 - smpte color pattern"
    !byte 0
menu_5
    !scr " 5 - raster timing stability"
    !byte 0