# ATmega8515 – Proyecto 2º Parcial

Prácticas en **ensamblador AVR** para la materia de Arquitectura de Computadoras (3er semestre, Ingeniería en Sistemas Computacionales, UAA), usando el microcontrolador **ATmega8515**.

## Contenido

Cada práctica incluye su código fuente (`.asm`) y el archivo listo para grabar (`.hex`).

| Práctica | Descripción |
|---|---|
| `01_lectura` | Lee lo que entra en PA y lo muestra en PB
| `02_pendulo` | Itera una señal que va de derecha a izquierda y viceversa |
| `03_digitod` | Muestra en un display de 7 segmentos los 30 dígitos posibles |
| `04_interrupcion` | Utiliza la interrupcion propia del atmega para cambiar lo que muestra el display |
| `05_99` | Cuenta de 0 a 99 con 2 displays de 7 segmentos |
| `06_lee_bit` | Lectura de un bit de entrada |
| `07_mayor` | Comparación de valores para encontrar el mayor |
| `08_suma` | Suma de valores |
| `09_cuatroDisplay` | Manejo de cuatro displays de 7 segmentos |
| `10_contador_binario` | Contador binario |
| `m8515def.inc` | Archivo de definiciones del ATmega8515 |

## Herramientas

- Ensamblador: [Avra](https://github.com/Ro5bert/avra)
- Editor: Visual Studio Code
- Microcontrolador: ATmega8515 con cristal externo

## Cómo ensamblar

```bash
avra 08_suma.asm
```

Esto genera el archivo `.hex` que se graba en el microcontrolador. Los archivos `.asm` incluyen `m8515def.inc`, así que deben estar en la misma carpeta.

## Autor

Abraham Lara Eugenio – [@larabraham001](https://github.com/larabraham001)
