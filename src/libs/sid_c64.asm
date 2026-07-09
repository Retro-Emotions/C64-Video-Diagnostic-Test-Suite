; ==============================================================================
; REGISTRI AUDIO SID (Relativi a sidregsbase = $D400)
; ACME 0.97
; ==============================================================================

!cpu 6510

!src "src/lib/memory_c64.asm"

; --- VOCE 1 ---
SID_V1_FREQ_LO  = sidregsbase + $00     ; Frequenza Voce 1 (Low Byte)
SID_V1_FREQ_HI  = sidregsbase + $01     ; Frequenza Voce 1 (High Byte)
SID_V1_PW_LO    = sidregsbase + $02     ; Larghezza impulso Voce 1 (Low Byte)
SID_V1_PW_HI    = sidregsbase + $03     ; Larghezza impulso Voce 1 (High Byte)
SID_V1_CTRL     = sidregsbase + $04     ; Registro di controllo Voce 1 (Waveform, Gate...)
SID_V1_ATT_DEC  = sidregsbase + $05     ; Attacco / Decadimento Voce 1
SID_V1_SUS_REL  = sidregsbase + $06     ; Sostegno / Rilascio Voce 1

; --- VOCE 2 ---
SID_V2_FREQ_LO  = sidregsbase + $07     ; Frequenza Voce 2 (Low Byte)
SID_V2_FREQ_HI  = sidregsbase + $08     ; Frequenza Voce 2 (High Byte)
SID_V2_PW_LO    = sidregsbase + $09     ; Larghezza impulso Voce 2 (Low Byte)
SID_V2_PW_HI    = sidregsbase + $0A     ; Larghezza impulso Voce 2 (High Byte)
SID_V2_CTRL     = sidregsbase + $0B     ; Registro di controllo Voce 2
SID_V2_ATT_DEC  = sidregsbase + $0C     ; Attacco / Decadimento Voce 2
SID_V2_SUS_REL  = sidregsbase + $0D     ; Sostegno / Rilascio Voce 2

; --- VOCE 3 ---
SID_V3_FREQ_LO  = sidregsbase + $0E     ; Frequenza Voce 3 (Low Byte)
SID_V3_FREQ_HI  = sidregsbase + $0F     ; Frequenza Voce 3 (High Byte)
SID_V3_PW_LO    = sidregsbase + $10     ; Larghezza impulso Voce 3 (Low Byte)
SID_V3_PW_HI    = sidregsbase + $11     ; Larghezza impulso Voce 3 (High Byte)
SID_V3_CTRL     = sidregsbase + $12     ; Registro di controllo Voce 3
SID_V3_ATT_DEC  = sidregsbase + $13     ; Attacco / Decadimento Voce 3
SID_V3_SUS_REL  = sidregsbase + $14     ; Sostegno / Rilascio Voce 3

; --- FILTRI E VOLUME ---
SID_FLT_CUT_LO  = sidregsbase + $15     ; Frequenza di taglio del filtro (Low Bits 0-2)
SID_FLT_CUT_HI  = sidregsbase + $16     ; Frequenza di taglio del filtro (High Byte)
SID_FLT_RESO_RT = sidregsbase + $17     ; Risonanza e instradamento delle voci nel filtro
SID_FLT_MODE_VOL= sidregsbase + $18     ; Modalità filtro (High/Band/Low-pass) e Volume globale

; --- LETTURE ANALOGICHE E OSCILLATORI (Sola Lettura) ---
SID_POT_X       = sidregsbase + $19     ; Lettura analogica Paddle X / Mouse della porta 1 o 2
SID_POT_Y       = sidregsbase + $1A     ; Lettura analogica Paddle Y / Mouse della porta 1 o 2
SID_V3_OSC      = sidregsbase + $1B     ; Output dell'oscillatore della Voce 3
SID_V3_ENV      = sidregsbase + $1C     ; Output dell'inviluppo della Voce 3
