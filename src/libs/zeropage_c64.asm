; ==============================================================================
; Zero Page Registers and Pointers
; ACME 0.97
; ==============================================================================

!cpu 6510

; --- Controllo CPU 6510 ---
ZP_CPU_DIR      = $00       ; Registro di direzione dati del processore 6510
ZP_CPU_PORT     = $01       ; Registro di controllo della configurazione di memoria (Bank Switching)

; --- Registri di Sistema e BASIC ---
ZP_ADRAY1       = $03       ; Puntatore per routine di conversione Floating Point (Low/High)
ZP_ADRAY2       = $05       ; Secondo puntatore per routine Floating Point (Low/High)
ZP_CHAR_COLOR   = $28       ; Colore corrente del testo (usato da CHROUT)

; --- Gestione Cursore e Schermo ---
ZP_CURSOR_ROW   = $D6       ; Riga corrente del cursore (0-24)
ZP_CURSOR_COL   = $CA       ; Colonna corrente del cursore (0-39)
ZP_SCREEN_LINE  = $D1       ; Indirizzo base della riga corrente dello schermo (Puntatore a 16-bit, Low/High)
ZP_COLOR_LINE   = $F3       ; Indirizzo base della riga corrente della memoria colore (Puntatore a 16-bit, Low/High)

; --- Buffer Tastiera ---
ZP_KEY_COUNT    = $C6       ; Numero di caratteri attualmente presenti nel buffer della tastiera
ZP_KEY_SHIFT    = $2B1      ; Stato dei tasti Shift / Commodore / Ctrl (Nota: Fuori da ZP, ma critico)

; --- Parametri I/O e Canali KERNAL ---
ZP_STATUS_BYTE  = $90       ; byte di stato I/O del Kernal (ST, riempito da READST)
ZP_DEVICE_NUM   = $BA       ; Numero dell'ultimo dispositivo di I/O utilizzato (Default: 8 per il Drive)
ZP_FN_LEN       = $B7       ; Lunghezza del nome del file corrente
ZP_FN_PTR       = $BB       ; Puntatore all'indirizzo del nome del file corrente (Low/High)

; --- Puntatori Utente (Liberi se non si usa il BASIC) ---
; Questi puntatori sono ideali per cicli di copia memoria, scorrimento o manipolazione sprite.
ZP_PTR_1        = $FB       ; Puntatore generico 1 utilizzabile dall'utente (Low Byte)
ZP_PTR_1_HI     = $FC       ; Puntatore generico 1 utilizzabile dall'utente (High Byte)
ZP_PTR_2        = $FD       ; Puntatore generico 2 utilizzabile dall'utente (Low Byte)
ZP_PTR_2_HI     = $FE       ; Puntatore generico 2 utilizzabile dall'utente (High Byte)
