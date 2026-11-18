; Grabar el programa y construir el circuito para probar la transferencia de PB a PA
.include "m8515def.inc"

; Primero definimos los puertos como entrada (PB) y salida (PA)
LDI R16, 0B00000000     ; Aquí se está cargando el valor 0 en un registro de propósito general
OUT DDRB, R16           ; Aquí ya quedó configurado el Puerto B (PB) como entrada

LDI R17, 0B11111111     ; Se carga el valor binario 11111111 al Registro 17, también pudimos haber 
                        ; escrito un 255 (decimal) o un 0xFF (hexadecimal)
OUT DDRC, R17           ; Aquí ya quedó configurado el Puerto A (PA) como puerto de salida

OUT PORTB, R17          ; Se habilitan las resistencias Pull-Up

; Programa Principal
loop:
    IN R18, PINB        ; Se lee (IN) y se almacena en el Registro 18 (R18) lo que hay en PB
    OUT PORTC, R18      ; Se muestra (OUT) en el Puerto A lo que había guardado R18
RJMP loop               ; Ciclo infinito para que el programa siga leyendo y escribiendo



; CONCEPTOS BÁSICOS DE ENSAMBLADOR:

; LDI   - Load Immediate: Carga un valor constante de 8 bits en un registro.
; IN    - Input from I/O: Lee un registro de E/S y lo guarda en un registro general.
; OUT   - Output to I/O: Envía el contenido de un registro general a un registro de E/S.
; DDRx  - Data Direction Register: Configura los pines de un puerto como entrada (0) o salida (1).
; PORTx - Port Data Register: Escribe niveles lógicos (0/1) hacia afuera o activa resistencias pull-up.
; PINx  - Port Input Pins: Lee el estado físico real de los pines en tiempo real (solo lectura).
; loop  - Etiqueta: Marca una posición en el código para control de flujo.
; RJMP  - Relative Jump: Salto incondicional cercano hacia una etiqueta.