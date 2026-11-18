; Programa "Péndulo"

.include "m8515def.inc"

; Configuración del Stack Pointer
LDI R16, HIGH(RAMEND)       ; Carga la parte alta de la memoria RAM (High) en R16
OUT SPH, R16                ; Envía R16 al registro del Stack Pointer High (SPH)
LDI R16, LOW(RAMEND)        ; Carga la parte baja de la memoria RAM (Low) en R16
OUT SPL, R16                ; Envía R16 al registro del Stack Pointer Low

; Configurar el Puerto C (PC) como salida
LDI R16, 0xFF
OUT DDRC, R16;

Derecha: 
    LDI R16, 0B10000000     ; 0x80
CicloD:    
    OUT PORTC, R16          ; Se muestra en el Puerto C lo que hay en el Registro 16
    RCALL Tiempo            ; Llamada a una subrutina para manipular el tiempo de retardo
    LSR R16                 ; Desplazamiento lógico a la derecha
    CPI R16, 0B00000001     ; La instrucción resta el registro actual - la constante proporcionada
    BREQ Izquierda          ; Si el resultado de esto es 0, se prende flag Z y avanza a la etiqueta marcada
RJMP CicloD

Izquierda:
    LDI R16, 0B00000001     ; 0x01, 1
CicloI:
    OUT PORTC, R16          ; Se muestra en el Puerto C lo que hay en el Registro 16
    RCALL Tiempo            ; Llamada a una subrutina para manipular el tiempo de retardo
    LSL R16                 ; Desplazamiento a la izquierda
    CPI R16, 0B10000000     ; La instrucción resta el registro actual menos la constante proporcionada
    BREQ Derecha            ; Si el resultado es 0, se prende la bandera Z y avanza a la etiqueta marcada
RJMP CicloI

Tiempo:                     ; Subrutina para manipular el retardo
    LDI R24, 10             ; Carga el contador externo (ciclo grande)
    ciclo_ext:                  
        LDI R25, 255            ; Carga el contador mediano
        ciclo_med:
            LDI R26, 255            ; Carga el contador interno (el más pequeño y rápido)
            ciclo_int:
                DEC R26                 ; Resta 1 al registro interno
                BRNE ciclo_int          ; Si no es 0, repite el ciclo interno
                DEC R25                 ; Resta 1 al registro medio
                BRNE ciclo_med          ; si no es 0, repite el ciclo medio
                DEC R24                 ; Resta 1 al ciclo externo
                BRNE ciclo_ext          ; si no es 0, repite el ciclo externo
                RET                     ; Retorna al punto exacto donde fue llamada la subrutina

; ============================================
;        NUEVOS CONCEPTOS/INSTRUCCONES:
;=============================================

; --- HIGH(RAMEND) y LOW(RAMEND) ---
; Definición: Directivas del ensamblador que calculan automáticamente la parte
;             alta y baja de la dirección final de la memoria RAM.
; Función:    Configuran de forma dinámica el Stack Pointer (SPH y SPL) para
;             adaptarse al microcontrolador sin usar valores numéricos fijos, que en este caso serían 0x02 y 0x5f.

; --- LSR (Logical Shift Right) ---
; Definición: Instrucción de desplazamiento lógico a la derecha.
; Función:    Mueve todos los bits del registro un lugar hacia la derecha; el bit 7
;             se rellena con 0 y el bit que sale por la derecha pasa al Carry.

; --- LSL (Logical Shift Left) ---
; Definición: Instrucción de desplazamiento lógico a la izquierda.
; Función:    Mueve todos los bits del registro un lugar hacia la izquierda; el bit 0
;             se rellena con 0 y el bit que sale por la izquierda pasa al Carry.

; --- BREQ (Branch if EQual) ---
; Definición: Salto condicional si el resultado es cero (Bandera Z = 1).
; Función:    Salta a una etiqueta cuando la operación anterior da como resultado cero
;             (se usa para detectar el fin del corrimiento de los LEDs).

; --- BRNE (Branch if Not EQual) ---
; Definición: Salto condicional si el resultado no es cero (Bandera Z = 0).
; Función:    Mantiene la ejecución repitiendo un ciclo (como en los delays) 
;             mientras el contador interno no se agote.

; --- RCALL y RET ---
; Definición: Llamada a subrutina (RCALL) y retorno de subrutina (RET).
; Función:    RCALL salta a ejecutar un bloque secundario guardando el regreso en 
;             la pila; RET devuelve el flujo a la línea exacta donde se llamó.


; --- CPI (Compare with Immediate) ---
; Definición: Instrucción que compara el valor de un registro con una constante inmediata.
; Función:    Resta el valor inmediato del registro sin modificarlo, actualizando 
;             las banderas de estado (como la bandera Z) para evaluar condiciones.
