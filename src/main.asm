; ==============================================================================
; C64 VIDEO TEST V.1.1 - Tool per il test del monitor
; Compilatore: ACME Assembler 0.97
; ==============================================================================
!cpu 6510

; --- FLAG DI COMPILAZIONE ---
COMPILE_AS_ROM = 1

!if COMPILE_AS_ROM = 0 {
    !src "src/libs/basicstub.asm"
} else {
    * = $8000
    !word start
    !word start
    !byte $c3, $c2, $cd, $38, $30
}

; --- INCLUDE ---
!src "src/libs/zeropage_c64.asm"
!src "src/libs/memory_c64.asm"
!src "src/libs/kernal_c64.asm"
!src "src/libs/vic_c64.asm"
!src "src/libs/cia_c64.asm"
!src "src/libs/macro.asm"
!src "src/prg/constants.asm"
!src "src/prg/vars.asm"

; ==============================================================================
; INIZIO PROGRAMMA
; ==============================================================================
!if COMPILE_AS_ROM = 0 {
    * = $4000
}
start
    sei
    
    ; Reset stack register
    ldx #$ff
    txs
    
    ; Memory mapping
    lda #$37                    ; %00110111
    sta ZP_CPU_PORT

; --- Installa la nostra routine IRQ per la scansione tastiera ---
    lda #<keyb_irq
    sta $0314
    lda #>keyb_irq
    sta $0315

; --- CIA1 Timer A a ~60Hz ---
    lda #$25
    sta CIA1_TIMER_A_LO
    lda #$40
    sta CIA1_TIMER_A_HI
    lda #$81
    sta CIA1_INT_CTRL
    lda #$11
    sta CIA1_CTRL_TIMA

; --- CIA1 Data Direction Registers (necessario per scansione tastiera) ---
    lda #$ff
    sta CIA1_DIR_PORTA        ; DDRA = output (selezione righe)
    lda #$00
    sta CIA1_DIR_PORTB        ; DDRB = input (lettura colonne)

    lda #$00
    sta KEY_PRESSED

    cli

    jmp menu

; ==============================================================================
; ROUTINE IRQ - SCANSIONE TASTIERA (CIA1)
; ==============================================================================
keyb_irq
    lda #$00
    sta KEY_PRESSED

; --- Riga 7 (tasti 1, 2) ---
    lda #$7F
    sta CIA1_DATA_PORTA
    lda CIA1_DATA_PORTB
    and #%00000001
    bne .check_t2
    lda #1
    sta KEY_PRESSED
    jmp .scan_done
.check_t2
    lda CIA1_DATA_PORTB
    and #%00001000
    bne .check_space
    lda #2
    sta KEY_PRESSED
    jmp .scan_done
.check_space
    lda CIA1_DATA_PORTB
    and #%00010000
    bne .check_row1
    lda #6
    sta KEY_PRESSED
    jmp .scan_done

; --- Riga 1 (tasti 3, 4) ---
.check_row1
    lda #$FD
    sta CIA1_DATA_PORTA
    lda CIA1_DATA_PORTB
    and #%00000001
    bne .check_t4
    lda #3
    sta KEY_PRESSED
    jmp .scan_done
.check_t4
    lda CIA1_DATA_PORTB
    and #%00001000
    bne .check_row2
    lda #4
    sta KEY_PRESSED
    jmp .scan_done

; --- Riga 2 (tasto 5) ---
.check_row2
    lda #$FB
    sta CIA1_DATA_PORTA
    lda CIA1_DATA_PORTB
    and #%00000001
    bne .scan_done
    lda #5
    sta KEY_PRESSED

.scan_done
    lda #$7F
    sta CIA1_DATA_PORTA        ; ripristina riga di default

    lda CIA1_INT_CTRL          ; ack interrupt CIA1

    ; --- RIPRISTINO REGISTRI ---
    pla
    tay                        ; Ripristina Y
    pla
    tax                        ; Ripristina X
    pla                        ; Ripristina Accumulatore
    rti

; ==============================================================================
; INCLUSIONE CODICE APPLICATIVO E MODULI
; ==============================================================================
!src "src/prg/menu.asm"
!src "src/prg/crosshatch.asm"
!src "src/prg/colorbars.asm"
!src "src/prg/checkerboard.asm"
!src "src/prg/smpte.asm"
!src "src/prg/raster_stability.asm"

!if COMPILE_AS_ROM = 1 {
    !fill $9FFF - * + 1, $FF
}

!sl "build/labels.txt"