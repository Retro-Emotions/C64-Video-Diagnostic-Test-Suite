; ==============================================================================
; REGISTRI CIA
; ACME 0.97
; ==============================================================================

!cpu 6510

; ==============================================================================
; CHIP CIA 1 - Gestione Tastiera, Joystick Porta 2, IRQ di Sistema
; ==============================================================================
CIA1_DATA_PORTA = cia1regsbase + $00     ; Porta A dati (Lettura linee tastiera / Joystick 2)
CIA1_DATA_PORTB = cia1regsbase + $01     ; Porta B dati (Scrittura linee tastiera / Joystick 1 / Fuoco)
CIA1_DIR_PORTA  = cia1regsbase + $02     ; Registro direzione dati Porta A (DDRA)
CIA1_DIR_PORTB  = cia1regsbase + $03     ; Registro direzione dati Porta B (DDRB)
CIA1_TIMER_A_LO = cia1regsbase + $04     ; Timer A (Low Byte)
CIA1_TIMER_A_HI = cia1regsbase + $05     ; Timer A (High Byte)
CIA1_TIMER_B_LO = cia1regsbase + $06     ; Timer B (Low Byte)
CIA1_TIMER_B_HI = cia1regsbase + $07     ; Timer B (High Byte)
CIA1_TOD_10THS  = cia1regsbase + $08     ; Orologio (Time of Day) - Decimi di secondo
CIA1_TOD_SEC    = cia1regsbase + $09     ; Orologio (Time of Day) - Secondi
CIA1_TOD_MIN    = cia1regsbase + $0A     ; Orologio (Time of Day) - Minuti
CIA1_TOD_HOURS  = cia1regsbase + $0B     ; Orologio (Time of Day) - Ore
CIA1_SERIAL_BUF = cia1regsbase + $0C     ; Registro dati seriale a scorrimento (Shift Register)
CIA1_INT_CTRL   = cia1regsbase + $0D     ; Controllo interruzioni (Stato flag / Abilitazione IRQ)
CIA1_CTRL_TIMA  = cia1regsbase + $0E     ; Registro di controllo del Timer A
CIA1_CTRL_TIMB  = cia1regsbase + $0F     ; Registro di controllo del Timer B

; ==============================================================================
; CHIP CIA 2 - Gestione Bus Seriale IEC, Bank-Switching VIC-II, NMI
; ==============================================================================
CIA2_DATA_PORTA = cia2regsbase + $00     ; Porta A dati (Selezione Banco VIC-II / Linee IEC)
CIA2_DATA_PORTB = cia2regsbase + $01     ; Porta B dati (Porta utente parallela User Port)
CIA2_DIR_PORTA  = cia2regsbase + $02     ; Registro direzione dati Porta A (DDRA)
CIA2_DIR_PORTB  = cia2regsbase + $03     ; Registro direzione dati Porta B (DDRB)
CIA2_TIMER_A_LO = cia2regsbase + $04     ; Timer A (Low Byte)
CIA2_TIMER_A_HI = cia2regsbase + $05     ; Timer A (High Byte)
CIA2_TIMER_B_LO = cia2regsbase + $06     ; Timer B (Low Byte)
CIA2_TIMER_B_HI = cia2regsbase + $07     ; Timer B (High Byte)
CIA2_TOD_10THS  = cia2regsbase + $08     ; Orologio (Time of Day) - Decimi di secondo
CIA2_TOD_SEC    = cia2regsbase + $09     ; Orologio (Time of Day) - Secondi
CIA2_TOD_MIN    = cia2regsbase + $0A     ; Orologio (Time of Day) - Minuti
CIA2_TOD_HOURS  = cia2regsbase + $0B     ; Orologio (Time of Day) - Ore
CIA2_SERIAL_BUF = cia2regsbase + $0C     ; Registro dati seriale a scorrimento (Shift Register)
CIA2_INT_CTRL   = cia2regsbase + $0D     ; Controllo interruzioni (Stato flag / Abilitazione NMI)
CIA2_CTRL_TIMA  = cia2regsbase + $0E     ; Registro di controllo del Timer A
CIA2_CTRL_TIMB  = cia2regsbase + $0F     ; Registro di controllo del Timer B
