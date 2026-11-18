; Programa que muestra de manera cíclica en un Display de 7 segmentos el
; conteo de 0 a 9. Con la Interrupción 0 (botón en PD2) muestra de la A a la F
; y después continúa el conteo donde se quedó.

.include "m8515def.inc"

; ---------- Tabla de vectores ----------
.ORG 0x0000
    RJMP PROGRAMA          ; Reset
.ORG INT0addr
    RJMP INTERRUPCION      ; Interrupción 0 (PD2)

.ORG 0x0020

PROGRAMA:

; SP
LDI R16, HIGH(RAMEND)
OUT SPH, R16
LDI R16, LOW(RAMEND)
OUT SPL, R16

; Configurar Puerto A como salida (display)
LDI R16, 0xFF
OUT DDRA, R16

; Configurar PD2 (INT0) como entrada con resistencia Pull-Up
LDI R16, 0x00
OUT DDRD, R16
LDI R16, 0b00000100
OUT PORTD, R16

; INT0 se activa con flanco de bajada (al presionar el botón)
LDI R16, 0b00000010
OUT MCUCR, R16

; Habilitar la INT0
LDI R16, 0b01000000
OUT GICR, R16

; Habilitar interrupciones en general
SEI

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


; ---------- Rutina de la Interrupción 0 ----------
INTERRUPCION:

    ; Guardar lo que el conteo estaba usando
    PUSH R16
    IN R17, SREG           ; guardar banderas
    IN R18, PORTA          ; guardar el dígito que se estaba mostrando

    ;A
    LDI R16, 0b10001000
    OUT PORTA, R16
    RCALL delay_letra

    ;b
    LDI R16, 0b10000011
    OUT PORTA, R16
    RCALL delay_letra

    ;C
    LDI R16, 0b11000110
    OUT PORTA, R16
    RCALL delay_letra

    ;d
    LDI R16, 0b10100001
    OUT PORTA, R16
    RCALL delay_letra

    ;E
    LDI R16, 0b10000110
    OUT PORTA, R16
    RCALL delay_letra

    ;F
    LDI R16, 0b10001110
    OUT PORTA, R16
    RCALL delay_letra

    ; Regresar el dígito que se estaba mostrando
    OUT PORTA, R18

    ; Borrar cualquier rebote del botón que haya quedado pendiente
    LDI R16, 0b01000000
    OUT GIFR, R16

    ; Restaurar y regresar al conteo
    OUT SREG, R17
    POP R16
    RETI


; ---------- Delays ----------
; Delay del conteo (usa R24, R25, R26)
delay:
LDI R24, 50
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

; Delay de las letras (usa otros registros: R21, R22, R23)
delay_letra:
LDI R21, 50
l_ext:
LDI R22, 0xFF
l_med:
LDI R23, 0xFF
l_int:
DEC R23
BRNE l_int
DEC R22
BRNE l_med
DEC R21
BRNE l_ext
RET

;=============================================
;        NUEVOS CONCEPTOS/INSTRUCCONES:
;=============================================

; Tabla de vectores: Mapa ubicado al inicio de la memoria Flash (0x0000) que actúa como un directorio para 
;                    indicarle al microcontrolador a qué dirección saltar cuando ocurre un evento crítico 
;                    (como el Reset o una interrupción).
; .ORG: Directiva que le indica al ensamblador en qué dirección exacta de la memoria Flash debe colocarse 
;       el código o bloque que viene a continuación.
; INT0addr: Nombre simbólico (etiqueta) de la dirección asignada por el hardware donde se ubica el vector 
;           de la Interrupción Externa 0.
; MCUCR: (MCU Control Register). Registro de control del microcontrolador; se usa para configurar si las 
;        interrupciones externas se disparan por flanco de bajada, de subida, etc.
; GICR: (General Interrupt Control Register). Registro encargado de habilitar o deshabilitar de forma individual 
;       los canales de interrupción externa (como INT0 o INT1).
; SEI: (Set Interrupt Flag). Instrucción que activa el interruptor maestro global de interrupciones dentro del 
;      registro SREG.
; PUSH: Instrucción que toma el valor de un registro y lo guarda temporalmente en la pila (Stack) para protegerlo 
;       de ser sobreescrito.
; POP: Instrucción inversa a PUSH; recupera de la pila el valor guardado y lo devuelve a su registro original.
; SREG: (Status Register). Registro de estado que almacena las banderas matemáticas y el interruptor global de
;       interrupciones.
; GIFR: (General Interrupt Flag Register). Registro donde se limpian las banderas de interrupción pendientes
;       (por ejemplo, para borrar rebotes acumulados de un botón).
; RETI: (Return from Interrupt). Instrucción final de una subrutina de interrupción; restaura el estado y regresa
;       la ejecución exactamente a la línea del programa principal que se estaba ejecutando antes del evento.