; BASIC stub
; ACME 0.97

!cpu 6510

* = $0801
!byte $0C,$08               ; link pointer (2060)
!byte $b0,$07               ; line number (1968)
!byte $9e,$20               ; SYS
!byte $31,$36,$33,$38,$34   ; "16384"
!byte $00                   ; line terminator
!byte $00,$00               ; program terminator
