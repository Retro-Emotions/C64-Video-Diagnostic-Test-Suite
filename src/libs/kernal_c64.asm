; ==============================================================================
; KERNAL ROUTINE
; ACME 0.97
; ==============================================================================

!cpu 6510

; --- Routine Schermo, Caratteri e Cursore ---
CLEAR   = $E544     ; Pulisce lo schermo corrente
SCNKEY  = $FF9F     ; Scansiona la tastiera (da inserire nella routine IRQ)
GETIN   = $FFE4     ; Legge un carattere dal buffer della tastiera (ritorna 0 se vuoto)
CHRIN   = $FFCF     ; Legge un carattere dal canale di input corrente (attende la pressione)
CHROUT  = $FFD2     ; Scrive un carattere sul canale di output corrente (schermo di default)
PLOT    = $FFF0     ; Legge o imposta la posizione del cursore (X/Y nei registri X/Y)

; --- Gestione Canali I/O (File, Disco, Tape) ---
SETLFS  = $FFBA     ; Imposta i parametri del file (Logical File Number, Device, Secondary Address)
SETNAM  = $FFBD     ; Imposta il nome del file (Lunghezza e indirizzo della stringa)
OPEN    = $FFC0     ; Apre un canale logico usando i parametri di SETLFS e SETNAM
CLOSE   = $FFC3     ; Chiude un canale logico specifico
CHKIN   = $FFC6     ; Definisce il canale logico di input corrente
CKOUT   = $FFC9     ; Definisce il canale logico di output corrente
CLRCHN  = $FFCC     ; Ripristina i canali di I/O standard (Tastiera e Schermo)
READST  = $FFB7     ; Legge lo stato del canale I/O corrente (I/O Status Word)

; --- Caricamento e Salvataggio Memoria ---
LOAD    = $FFD5     ; Carica o verifica un file in memoria
SAVE    = $FFD8     ; Salva un'area di memoria su disco o nastro

; --- Controllo Hardware e Reset ---
STOP    = $FFE1     ; Controlla se il tasto RUN/STOP è premuto
UDTIM   = $FFEA     ; Aggiorna i timer di sistema e l'orologio software (Jiffy Clock)
IOINIT  = $FF84     ; Inizializza i chip di I/O (CIA e SID)
RAMTAS  = $FF87     ; Pulisce la memoria RAM, imposta la pagina zero e i puntatori di sistema
RESTART = $FFFC     ; Vettore di reset hardware del sistema (riavvio totale del C64)
