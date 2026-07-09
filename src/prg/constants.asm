!cpu 6510

; ==============================================================================
; CODICI COLORE STANDARD COMMODORE 64
; ==============================================================================
COLOR_BLACK     = 0
COLOR_WHITE     = 1
COLOR_RED       = 2
COLOR_CYAN      = 3
COLOR_PURPLE    = 4
COLOR_GREEN     = 5
COLOR_BLUE      = 6
COLOR_YELLOW    = 7
COLOR_ORANGE    = 8
COLOR_BROWN     = 9
COLOR_LT_RED    = 10
COLOR_DK_GREY   = 11
COLOR_MD_GREY   = 12
COLOR_LT_GREEN  = 13
COLOR_LT_BLUE   = 14
COLOR_LT_GREY   = 15

; ==============================================================================
; CODICI TASTIERA SISTEMA OPERATIVO (REGISTRO $C5)
; ==============================================================================
KEY_NONE        = $40       ; Nessun tasto premuto
KEY_1           = $38       ; Tasto 1
KEY_2           = $3B       ; Tasto 2
KEY_3           = $08       ; Tasto 3
KEY_4           = $0B       ; Tasto 4
KEY_5           = $10       ; Tasto 5
KEY_SPACE       = $3C       ; Barra Spaziatrice

; ==============================================================================
; CODICI PETSCII / SCREEN CODES UTILI
; ==============================================================================
CHAR_SPACE      = $20       ; Carattere spazio vuoto
CHAR_SOLID      = $A0       ; Carattere blocco pieno standard

; ==============================================================================
; PARAMETRI GRAFICA BITMAP
; ==============================================================================
BITMAP_PAGES    = 32        ; 32 pagine da 256 byte = 8K bitmap

; ==============================================================================
; PARAMETRI INTERFACCIA MENU
; ==============================================================================
TITLE_LEN       = 25        ; Lunghezza titolo da colorare in bianco