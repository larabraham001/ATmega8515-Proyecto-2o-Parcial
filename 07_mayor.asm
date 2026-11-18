; Programa que lee 2 números en binario (Puerto A y Puerto B)
; y coloca el mayor de los dos en un tercer puerto (Puerto C).
; Se usan resistencias pull-up interna: interruptor cerrado = pin en 0, abierto = pin en 1.
; Como eso queda "al revés", se invierte el número con COM para que interruptor cerrado = 1.
; El resultado sale en el Puerto C (8 LEDs).

.include "m8515def.inc"

; SP
LDI R16, HIGH(RAMEND)
OUT SPH, R16
LDI R16, LOW(RAMEND)
OUT SPL, R16

; Configurar Puerto A como entrada, con resistencia Pull-Up
LDI R16, 0x00
OUT DDRA, R16
LDI R16, 0xFF
OUT PORTA, R16

; Configurar Puerto B como entrada, con resistencia Pull-Up
LDI R16, 0x00
OUT DDRB, R16
LDI R16, 0xFF
OUT PORTB, R16

; Configurar Puerto C como salida
LDI R16, 0xFF
OUT DDRC, R16

INICIO:

    ; Leer los dos números
    IN R16, PINA
    IN R17, PINB

    ; Invertirlos (interruptor cerrado = 1)
    COM R16
    COM R17

    ; Comparar: R16 - R17
    CP R16, R17

    ; Si R16 es menor que R17, el mayor es R17
    BRLO MAYOR_B

    ; Si no, el mayor es R16 (o son iguales)
    OUT PORTC, R16
RJMP INICIO

MAYOR_B:
    OUT PORTC, R17
RJMP INICIO