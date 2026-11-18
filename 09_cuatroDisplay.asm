; Programa que, con un solo puerto (Puerto A), maneja 4 Displays de 7 segmentos
; mostrando el mismo valor en todos. Se muestra el conteo de 0 a 9 de forma cíclica.
; Displays de ánodo común (lógica inversa).
;
; Conexión: los 4 displays van en paralelo. Es decir, el segmento "a" de los
; 4 displays va al mismo pin PA0, el "b" al PA1, ... el "g" al PA6.
; El ánodo común de cada display va a +5V.

.include "m8515def.inc"

; SP
LDI R16, HIGH(RAMEND)
OUT SPH, R16
LDI R16, LOW(RAMEND)
OUT SPL, R16

; Configurar Puerto A como salida
LDI R16, 0xFF
OUT DDRA, R16

INICIO:
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
    LDI R16, 0b10011000
    OUT PORTA, R16
    RCALL delay

RJMP INICIO


delay:
    LDI R24, 20
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