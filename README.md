# C64 Video Diagnostic Test Suite

[![Platform](https://shields.io)](https://wikipedia.org)
[![Language](https://shields.io)](https://wikipedia.org)
[![Assembler](https://shields.io)](https://sourceforge.net)
[![Software Version](https://shields.io)]()

Lo **C64 Video Diagnostic Test Suite** è uno strumento software professionale scritto in Assembly 6502 (ACME Assembler) progettato per l'analisi dettagliata, la calibrazione e la diagnostica del segnale video generato dal chip grafico **VIC-II** del Commodore 64. 

La suite permette di verificare la fedeltà cromatica, la geometria, la nitidezza e la stabilità del segnale su hardware reale (monitor CRT e pannelli LCD con upscaler come OSSC o RetroTINK) o su emulatori accurati come VICE.

---

## 🖥️ Requisiti di Sistema

* **Hardware:** Commodore 64 / Commodore 128 (in modalità C64).
* **Emulatori:** VICE (con accuratezza di rendering configurata su *Per-cycle / True PAL*).
* **Video Standard:** 
  * **PAL:** Ottimizzato (pieno supporto dinamico).
  * **NTSC:** Compatibile per test statici.
* **Sistemi di Visualizzazione:** Monitor CRT analogici, Monitor professionali (PVM/BVM) o monitor LCD moderni accoppiati a scaler dedicati.

---

## 🕹️ Menu Principale e Controlli

All'avvio, la suite esegue una pulizia della memoria video, imposta i bordi dello schermo su nero assoluto per eliminare distrazioni visive e mostra il menu di selezione:

* **Tasti da `1` a `5`**: Attivazione istantanea del rispettivo test pattern.
* **Tasto `SPAZIO`**: Interruzione del test attivo, ripristino delle funzioni di sistema e ritorno al menu principale.

---

## 📊 Specifiche dei Test Pattern

### 1. Crosshatch Geometry (Tasto `1`)
Attiva una schermata ad alta risoluzione (320x200 pixel) con un reticolo matematicamente perfetto di linee bianche spesse 1 pixel su sfondo nero.
* **Uso diagnostico:** Correzione delle distorsioni a barile o cuscino su CRT tramite potenziometri (`V-SIZE`, `H-SIZE`, `V-LIN`, `CUSHION`). Verifica della convergenza dei fasci catodici (assenza di aloni rossi/verdi/blu) e controllo dell'aspect ratio (4:3) o dell'uniformità dei pixel su upscaler moderni.

### 2. 16 Color Bars (Tasto `2`)
Mostra le 16 barre verticali dei colori nativi del Commodore 64 ordinati in modo lineare in base alla loro scala di luminanza reale (dal nero al bianco).
* **Uso diagnostico:** Regolazione del bilanciamento del Gamma, del contrasto e della luminosità del monitor per ottenere sfumature fluide. Evidenzia la superiorità dei collegamenti S-Video (Y/C) rispetto a connessioni a bassa qualità (Composito/RF) mostrando la riduzione delle sbavature tra colori saturi adiacenti.

### 3. Checkerboard 1x1 (Tasto `3`)
Forza l'alternanza di singoli pixel accesi e spenti in verticale e in orizzontale, creando una scacchiera microscopica ad altissima densità che satura la banda passante del segnale.
* **Uso diagnostico:** Misurazione della nitidezza (*Sharpness*) del display e valutazione dell'intensità delle **Jailbars** (barre d'ombra verticali generate dalle interferenze di clock sulla scheda madre del C64).

### 4. SMPTE Color Pattern (Tasto `4`)
Adattamento per C64 dello standard televisivo professionale SMPTE, suddiviso in barre grandi (75% superiore), barre di fase (8% centrale) e blocchi di calibrazione inferiori.
* **Procedura di Taratura:**
  1. *Luminosità:* Ridurre il livello finché il blocco *Nero Profondo* (colonne 5-14) si fonde con lo sfondo, mantenendo il blocco *Grigio Scuro* (colonne 15-19) appena visibile.
  2. *Contrasto:* Incrementare il valore usando il blocco *Bianco* centrale (colonne 20-29) fino al livello massimo prima che si verifichino distorsioni geometriche o bleeding sul tubo catodico.

### 5. Raster Timing Stability (Tasto `5`)
Test dinamico ad alta precisione che cambia il colore dello sfondo riga per riga alla frequenza del fascio video, generando una barra sfumata orizzontale (Blu ➔ Azzurro ➔ Bianco ➔ Azzurro ➔ Blu) che invade anche i bordi dello schermo.
* **Uso diagnostico:** Verifica della stabilità del clock interno. Un tremolio orizzontale (*Jitter*) indica fluttuazioni elettriche causate da condensatori degradati o alimentatori instabili. 
* *Nota per VICE:* Impostare tassativamente il rendering su **Per-cycle** per evitare artefatti o scalini verticali nell'emulazione.

---

## 🔧 Compilazione e Sviluppo

Il progetto è interamente sviluppato utilizzando la sintassi di **ACME Assembler**. Per compilare il sorgente e generare il file eseguibile `.prg`, assicurati di avere `acme` installato nel tuo percorso di sistema e digita nel terminale:

```bash
acme --format cbm -o build/c64_video_diag.prg src/main.asm
```

---

## ℹ️ Sicurezza Hardware e Disclaimer

### Sicurezza del Software
Questo software è sicuro al 100% per l'hardware del Commodore 64. A differenza dei sistemi moderni, i circuiti vintage operano a frequenza fissa e consumano la stessa quantità di energia sia con schermate vuote, sia con pattern grafici ad alta densità (es. *Checkerboard 1x1*). 
Eventuali anomalie grafiche o righe fisse stabili visibili a schermo non indicano malfunzionamenti generati dal codice, bensì limiti fisici di campionamento dei monitor LCD (*Aliasing* / *Moiré*) o interferenze analogiche native della scheda madre (*Luma Leakage*).

### ⚠️ Limitazione di Responsabilità
L'autore declina ogni responsabilità per eventuali guasti hardware che dovessero verificarsi sul computer durante l'esecuzione della suite diagnostica. I componenti interni del Commodore 64 hanno superato i quarant'anni di vita e sono soggetti a guasti spontanei dovuti al naturale invecchiamento del silicio e dei componenti passivi.

---

## 🤝 Contributi
I contributi, le segnalazioni di bug (issue) e le pull request per ottimizzazioni o porting su altre revisioni del chip VIC-II sono i benvenuti. Sii libero di aprire una richiesta di modifica o segnalazione nell'apposita sezione.

## 📄 Licenza
Questo progetto è rilasciato sotto una **Licenza per Uso Personale e Non Commerciale**. È consentito scaricare, compilare, utilizzare e modificare il codice sorgente esclusivamente per scopi personali, diagnostici e privati. È severamente vietata la vendita, la ridistribuzione a pagamento o l'utilizzo del software all'interno di attività commerciali senza il preventivo consenso scritto dell'autore. 
Consulta il file [LICENSE](LICENSE) per il testo completo della licenza.
