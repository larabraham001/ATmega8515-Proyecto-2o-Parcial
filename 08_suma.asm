; Programa que lee 2 números en binario (Puerto A y Puerto B)
; y coloca la suma de ambos en un tercer puerto (Puerto C).
; Si la suma se desborda (no cabe en 8 bits, o sea, es mayor a 255),
; la salida parpadea.
; Se usan resistencias pull-up internas:
; interruptor cerrado = pin en 0, abierto = pin en 1.
; Se invierte el número con COM para que interruptor cerrado = 1.

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

    ; Sumar: R16 = R16 + R17
    ; Si el resultado no cabe en 8 bits, se activa la bandera de acarreo (Carry)
    ADD R16, R17

    ; Si hubo acarreo (desbordamiento), saltar a parpadear
    BRCS PARPADEO

    ; Si no hubo desbordamiento, mostrar la suma
    OUT PORTC, R16
RJMP INICIO

PARPADEO:

    ; Encendido (con el resultado que quedó)
    ;LDI R18, 0xFF
    OUT PORTC, R16
    RCALL delay

    ; Apagado
    LDI R18, 0x00
    OUT PORTC, R18
    RCALL delay

RJMP INICIO


delay:
    LDI R24, 15
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