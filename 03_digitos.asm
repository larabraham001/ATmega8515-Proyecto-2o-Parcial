; Escribir un programa que despliegue en un Display de 7 segmentos el conteo de
; 0 a Y de forma cíclica (Se sugiere que sea con Lógica Inversa).

.include "m8515def.inc"

; SP
LDI R16, HIGH(RAMEND)
OUT SPH, R16
LDI R16, LOW(RAMEND)
OUT SPL, R16

; Configurar PA como salida
LDI R16, 0xFF
OUT DDRA, R16

INICIO:

    ; 30 dígitos con lógica inversa 
    ; (debido al display de ánodo común)

    ; 0
    LDI R16, 0b11000000
    OUT PORTA, R16
    RCALL delay

    ; 1
    LDI R16, 0b11111001
    OUT PORTA, R16
    RCALL delay

    ; 2
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
    LDI R16, 0b10011000
    OUT PORTA, R16
    RCALL delay

    ;A
    LDI R16, 0b10001000
    OUT PORTA, R16
    RCALL delay

    ;b
    LDI R16, 0b10000011
    OUT PORTA, R16
    RCALL delay
    
    ;C
    LDI R16, 0b11000110
    OUT PORTA, R16
    RCALL delay

    ;d
    LDI R16, 0b10100001
    OUT PORTA, R16
    RCALL delay

    ;E
    LDI R16, 0b10000110
    OUT PORTA, R16
    RCALL delay

    ;F
    LDI R16, 0b10001110
    OUT PORTA, R16
    RCALL delay

    ;g
    LDI R16, 0b10010000
    OUT PORTA, R16
    RCALL delay

    ;H
    LDI R16, 0b10001001
    OUT PORTA, R16
    RCALL delay

    ;i
    LDI R16, 0b11111011
    OUT PORTA, R16
    RCALL delay

    ;J
    LDI R16, 0b11100001
    OUT PORTA, R16
    RCALL delay

    ;L
    LDI R16, 0b11000111
    OUT PORTA, R16
    RCALL delay

    ;n
    LDI R16, 0b10101011
    OUT PORTA, R16
    RCALL delay

    ;o
    LDI R16, 0b10100011
    OUT PORTA, R16
    RCALL delay

    ;P
    LDI R16, 0b10001100
    OUT PORTA, R16
    RCALL delay

    ;q
    LDI R16, 0b10011000
    OUT PORTA, R16
    RCALL delay

    ;r
    LDI R16, 0b10101111
    OUT PORTA, R16
    RCALL delay

    ;S
    LDI R16, 0b10010010
    OUT PORTA, R16
    RCALL delay

    ;t
    LDI R16, 0b10000111
    OUT PORTA, R16
    RCALL delay

    ;U
    LDI R16, 0b11000001
    OUT PORTA, R16
    RCALL delay

    ;y
    LDI R16, 0b10010001
    OUT PORTA, R16
    RCALL delay

RJMP INICIO

delay:
    LDI R24, 30
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