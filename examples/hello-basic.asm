; BASIC STUB
        .WORD $0801                     ; BYTES DE ENCABEZADO PRG (LITTLE-ENDIAN)
        *=$0801                         ; COMENZAR A ENSAMBLAR
STUB
        .BYTE $0C,$08,                  ; PUNTERO A SIGUIENTE LINEA $080C
        .BYTE $0A,$00,                  ; 10
        .BYTE $9E,                      ; SYS       
        .BYTE $20,$32,$30,$36,$34,$00   ; 2064 ASCII Y FIN DE CADENA
        .BYTE $00,$00,                  ; FIN DEL PROGRAMA BASIC

; ASSEMBLY PROGRAM
        .WORD $0810
        *=$0810
START
        JSR $E544                       ; SUBROUTINE CLEAR  <- LIMPIAR PANTALLA
        LDX #$00                        ; OPCODE LOAD X <- CARGA 0 EN X

PRINT
        LDA DATA,X                      ; OPCODE LOAD ACCUMULATOR <- "FOR X IN MSG"
        BEQ DONE                        ; CUANDO NO QUEDE ACCUMULADOR SALTA A DONE
        JSR $FFD2                       ; SUBROUTINE CHROUT <- IMPRIMIR
        INX                             ; INCREMENTA X
        JMP PRINT                       ; VUELVE A PRINT

DONE
        RTS                             ; VUELVE A BASIC

; "HELLO, WORLD!" en ASCII HEXADECIMAL + FIN DE CADENA
DATA
        .BYTE $48,$45,$4C,$4C,$4F,$2C,$20,$57,$4F,$52,$4C,$44,$21,$00,
