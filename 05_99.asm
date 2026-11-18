; Escribir programa que cuente de manera cíclica del 0 al 99
; (utilizar 2 puertos como salidas)

.include "m8515def.inc"

; SP
LDI R16, HIGH(RAMEND)
OUT SPH, R16
LDI R16, LOW(RAMEND)
OUT SPL, R16

; Configurar Puerto A y Puerto B como salida
LDI R16, 0xFF
OUT DDRA, R16
OUT DDRB, R16

INICIO:

    ; Cada decena se pone en el Puerto B y luego se cuentan
    ; las unidades de 0 a 9 en el Puerto A.

    ;0
    LDI R16, 0b11000000
    OUT PORTB, R16
    RCALL unidades

    ;1
    LDI R16, 0b11111001
    OUT PORTB, R16
    RCALL unidades

    ;2
    LDI R16, 0b10100100
    OUT PORTB, R16
    RCALL unidades

    ;3
    LDI R16, 0b10110000
    OUT PORTB, R16
    RCALL unidades

    ;4
    LDI R16, 0b10011001
    OUT PORTB, R16
    RCALL unidades

    ;5
    LDI R16, 0b10010010
    OUT PORTB, R16
    RCALL unidades

    ;6
    LDI R16, 0b10000010
    OUT PORTB, R16
    RCALL unidades

    ;7
    LDI R16, 0b11111000
    OUT PORTB, R16
    RCALL unidades

    ;8
    LDI R16, 0b10000000
    OUT PORTB, R16
    RCALL unidades

    ;9
    LDI R16, 0b10010000
    OUT PORTB, R16
    RCALL unidades

RJMP INICIO


; Cuenta las unidades de 0 a 9 en el Puerto A
unidades:

    ;0
    LDI R16, 0b11000000
    OUT PORTA, R16
    RCALL delay

    ;1
    LDI R16, 0b11111001
    OUT PORTA, R16
    RCALL delay

    ;2
    LDI R16, 0b10100100
    OUT PORTA, R16
    RCALL delay

    ;3
    LDI R16, 0b10110000
    OUT PORTA, R16
    RCALL delay

    ;4
    LDI R16, 0b10011001
    OUT PORTA, R16
    RCALL delay

    ;5
    LDI R16, 0b10010010
    OUT PORTA, R16
    RCALL delay

    ;6
    LDI R16, 0b10000010
    OUT PORTA, R16
    RCALL delay

    ;7
    LDI R16, 0b11111000
    OUT PORTA, R16
    RCALL delay

    ;8
    LDI R16, 0b10000000
    OUT PORTA, R16
    RCALL delay

    ;9
    LDI R16, 0b10010000
    OUT PORTA, R16
    RCALL delay

    RET


delay:
    LDI R24, 10
    ciclo_ext:
    LDI R25, 0xFF
    ciclo_med:
    LDI R26, 0xFF
    ciclo_int:
    DEC R26
    BRNE ciclo_int
    DEC R25
    BRNE ciclo_med
    DEC R24
    BRNE ciclo_ext
    RET