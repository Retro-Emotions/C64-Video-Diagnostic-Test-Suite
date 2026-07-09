; ==============================================================================
; LIBRERIA DELLE MACRO
; ACME Assembler 0.97+
; ==============================================================================

; --- Macro per la stampa dei messaggi a video ---
; Parametri:
; .addr:          Indirizzo di partenza della stringa (!scr terminata da zero)
; .screen_offset: Spostamento rispetto alla base della memoria schermo testo
!macro print_msg .addr, .screen_offset, .color {
    ldx #0
.loop
    lda .addr, x
    beq .end
    sta screenmembase + .screen_offset, x

    lda #.color
    sta colormembase + .screen_offset, x

    inx
    jmp .loop
.end
}

!macro fill_1k .base, .value {
    lda #.value
    ldx #0
.loop
    sta .base, x
    sta .base + $0100, x
    sta .base + $0200, x
    sta .base + $0300, x
    inx
    bne .loop
}