; Programa que cuenta en binario del 1 al 255 con los LEDs del Puerto C.

.include "m8515def.inc"

; SP
LDI R16, HIGH(RAMEND)
OUT SPH, R16
LDI R16, LOW(RAMEND)
OUT SPL, R16

; Configurar Puerto C como salida
LDI R16, 0xFF
OUT DDRC, R16

; R16 guarda el número que se está contando, empieza en 1
LDI R16, 1

INICIO:

    ; Mostrar el número en los LEDs
    OUT PORTC, R16
    RCALL delay

    ; Sumar 1 al número
    INC R16

    ; Si el resultado NO es 0, seguir contando
    ; (al pasar de 255 el número da la vuelta y queda en 0)
    BRNE INICIO

    ; Si llegó a 0, volver a empezar desde 1
    LDI R16, 1

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
