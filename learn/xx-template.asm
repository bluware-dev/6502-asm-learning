; 6502/6510 | C64 - Template mínimo (KERNAL)
        .WORD $C000       ; LOAD ADDRESS (PRG)
        *= $C000          ; SYS 49152

START:
        CLD               ; ESTADO DETERMINISTA (sin BCD)

        JSR $E544         ; KERNAL: clear screen
        JSR INIT
        JSR MAIN

; INIT
INIT:
        LDX #$00

; MAIN
MAIN:
        LDA DATA,X
        BEQ END
        
        JSR $FFD2         ; KERNAL: CHROUT
        INX
        JMP MAIN

; END / LOOP
END:
        JMP INIT           ; LOOP "HELLO, WORLD!"

; DATA
DATA:
        .BYTE $48,$45,$4C,$4C,$4F,$2C,$20,$57,$4F,$52,$4C,$44,$21,$00
