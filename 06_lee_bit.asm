; Programa que lee UN BIT de un puerto (PB0) de forma cíclica:
;   si vale 1 -> muestra el conteo de 0 a 9 en el Display de 7 segmentos
;   si vale 0 -> muestra las letras de la A a la F

.include "m8515def.inc"

; SP
LDI R16, HIGH(RAMEND)
OUT SPH, R16
LDI R16, LOW(RAMEND)
OUT SPL, R16

; Configurar Puerto A como salida
LDI R16, 0xFF
OUT DDRA, R16

; Configurar Puerto B como entrada, con resistencia Pull-Up (Bit en PB0)
LDI R16, 0x00
OUT DDRB, R16
LDI R16, 0xFF
OUT PORTB, R16

INICIO:

    ; Leer el bit PB0: si vale 0 salta a las letras, si vale 1 sigue a los números
    SBIS PINB, PB0
    RJMP LETRAS


NUMEROS:

    ; Después de cada número se vuelve a leer el bit.
    ; Si cambió a 0, se salta a las letras.

    ;0
    LDI R16, 0b11000000
    OUT PORTA, R16
    RCALL delay
    SBIS PINB, PB0
    RJMP LETRAS

    ;1
    LDI R16, 0b11111001
    OUT PORTA, R16
    RCALL delay
    SBIS PINB, PB0
    RJMP LETRAS

    ;2
    LDI R16, 0b10100100
    OUT PORTA, R16
    RCALL delay
    SBIS PINB, PB0
    RJMP LETRAS

    ;3
    LDI R16, 0b10110000
    OUT PORTA, R16
    RCALL delay
    SBIS PINB, PB0
    RJMP LETRAS

    ;4
    LDI R16, 0b10011001
    OUT PORTA, R16
    RCALL delay
    SBIS PINB, PB0
    RJMP LETRAS

    ;5
    LDI R16, 0b10010010
    OUT PORTA, R16
    RCALL delay
    SBIS PINB, PB0
    RJMP LETRAS

    ;6
    LDI R16, 0b10000010
    OUT PORTA, R16
    RCALL delay
    SBIS PINB, PB0
    RJMP LETRAS

    ;7
    LDI R16, 0b11111000
    OUT PORTA, R16
    RCALL delay
    SBIS PINB, PB0
    RJMP LETRAS

    ;8
    LDI R16, 0b10000000
    OUT PORTA, R16
    RCALL delay
    SBIS PINB, PB0
    RJMP LETRAS

    ;9
    LDI R16, 0b10010000
    OUT PORTA, R16
    RCALL delay
    SBIS PINB, PB0
    RJMP LETRAS

RJMP NUMEROS


LETRAS:

    ; Después de cada letra se vuelve a leer el bit.
    ; Si cambió a 1, se salta a los números.

    ;A
    LDI R16, 0b10001000
    OUT PORTA, R16
    RCALL delay
    SBIC PINB, PB0
    RJMP NUMEROS

    ;b
    LDI R16, 0b10000011
    OUT PORTA, R16
    RCALL delay
    SBIC PINB, PB0
    RJMP NUMEROS

    ;C
    LDI R16, 0b11000110
    OUT PORTA, R16
    RCALL delay
    SBIC PINB, PB0
    RJMP NUMEROS

    ;d
    LDI R16, 0b10100001
    OUT PORTA, R16
    RCALL delay
    SBIC PINB, PB0
    RJMP NUMEROS

    ;E
    LDI R16, 0b10000110
    OUT PORTA, R16
    RCALL delay
    SBIC PINB, PB0
    RJMP NUMEROS

    ;F
    LDI R16, 0b10001110
    OUT PORTA, R16
    RCALL delay
    SBIC PINB, PB0
    RJMP NUMEROS

RJMP LETRAS


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

;=============================================
;        NUEVOS CONCEPTOS/INSTRUCCONES:
;=============================================


; SBIS: (Skip if Bit in I/O Register is Set). Revisa un bit específico en un registro de E/S 
;       (como un pin de un puerto). Si ese bit está en 1, salta la instrucción que le sigue 
;       inmediatamente, si está en 0, la ejecuta normal. Se usa mucho para leer botones con polling.

; TST: (Test for Zero or Minus). Realiza una operación lógica AND de un registro consigo mismo (Rd & Rd). 
;      No modifica el valor del registro, pero actualiza automáticamente las banderas de estado (Z para cero y 
;      N para negativo) para que puedas evaluarlas con un salto condicional.