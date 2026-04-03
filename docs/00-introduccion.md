# Introducción a la programacion en 6502/6510 Assembly (Commodore 64)

## ¿Que vamos a ver?

### Enfoques y Objetivo

Este primer apunte contiene las bases minimas para estructurar y ejecutar código ensamblador 6502/6510 para la Commodore 64 (C64) en VICE (Versatile Commodore Emulator), poniendonos como objetivo ejecutar un "Hello, World!".

> Nota: El MOS 6502 y 6510 no son lo mismo. El 6510 es una variante del 6502 que mantiene exactamente el mismo ISA, pero agrega un puerto de I/O integrado que permite controlar el memory banking y el mapeo de memoria. Se hace mención de ambos ya que el 6510 es compatible con el 6502, siendo este ultimo la referencia historica que vamos a usar para escribir código ensamblador. 


> En este material se abordan ambos enfoques de programación sobre C64:
>
> * Uso de subrutinas del KERNAL, como interfaz de más alto nivel para operaciones comunes (I/O, control de pantalla, etc.).
> * Acceso directo al hardware mediante memoria mapeada (por ejemplo, screen RAM, color RAM), evitando intermediación del sistema.
>
> El objetivo es contrastar ambos modelos, entendiendo sus implicancias en términos de abstracción, control y acoplamiento con la plataforma.

### Host y Entorno

En el host vamos a estar usando principalmente `xa65` como ensamblador de código ASM a PRG (`main.asm` -> `main.prg`), ya que la C64 no tiene un flujo óptimo para ensamblar de forma nativa.

> Web oficial: https://www.floodgap.com/retrotech/xa/
> GitHub https://github.com/fachat/xa65
> VER SETUP.md PARA INSTALACIÓN

Flujo básico:

```
main.asm -> main.prg -> LOAD -> SYS
```

Compilación:

```
xa -o build/main.prg main.asm
```

El binario generado (`.prg`) se carga en VICE usando:

```
x64 build/main.prg
```

Dentro de VICE, el programa se carga en memoria (`LOAD`) y se ejecuta manualmente con `SYS {ENTRYPOINT_ADDRESS}`.

> NOTA: VICE en modo `-autostart` intenta ejecutar automáticamente el programa usando `RUN` solo si el PRG contiene un stub BASIC válido en $0801. En ausencia de este, es necesario ejecutar manualmente con `SYS`.

> NOTA: Aunque `xa` es el ensamblador principal, el código debería ser compatible con Kick Assembler. Sin embargo, este es case-sensitive en sus directivas y presenta diferencias en sintaxis (por ejemplo, manejo de comentarios), por lo que no se utilizarán características específicas de ningún ensamblador.

### Aclaraciones Tecnicas

No usamos cc65 en estas practicas, este se reserva para proyectos donde se requiera linking, uso de C, control de memoria más preciso o runtime más complejo. En este contexto se prioriza ensamblador directo y archivos standalone, evitando sobreingeniería.

## Entrypoints?, Memoria?, LOAD? SYS?, RUN?

### Entrypoint

El entrypoint o punto de entrada es la dirección de memoria donde comienza la ejecución del programa.

En la C64, esta dirección es la que se invoca manualmente mediante `SYS`, transfiriendo el control del CPU a esa ubicación.

En ensambladores como `xa`, es necesario distinguir dos conceptos:

* **Load Address (dirección de carga)**
  Se define mediante `.WORD $XXXX` al inicio del archivo PRG. Indica en qué dirección de memoria se copiarán los datos al ejecutar `LOAD`.

* **Dirección de ensamblado**
  Se define mediante `*=$XXXX`. Indica al ensamblador dónde ubicar el código en memoria al generar los offsets y direcciones internas.

En programas simples, ambas direcciones coinciden, y el entrypoint se corresponde con esa misma dirección.

Ejemplo:

```asm
.WORD $C000      ; load address
*=$C000          ; dirección de ensamblado

START:
    JMP START    ; loop infinito de ejemplo
```

> Entrypoint, load address y dirección de ensamblado son conceptos distintos, aunque en este caso coinciden.

En el `main.asm` la posición se define en HEXADECIMAL `*=$C000`, que corresponde a la dirección de carga en memoria del programa. En la C64 se hace el salto con `SYS` usando su equivalente en DECIMAL: `SYS 49152` o `SYS(49152)`.

`SYS` transfiere el control de ejecución a una dirección específica de memoria, modificando el Program Counter del CPU.

> EXTRAS: Utilidades para convertir HEXADECIMAL a DECIMAL desde linea de comandos.
>
> * Via Bash: `echo $((16#FF))` # 255
> * Via BC: `echo "ibase=16; FF" | bc` # 255
> * Via PERL: `perl -le 'print hex("FF");'` # 255
> * Via Python: `python -c 'print(int("0xff", 16))'` # 255

### Comandos necesarios (BASIC)

* `LOAD`
  Carga un programa PRG en memoria usando la dirección de carga especificada en sus primeros 2 bytes.

* `RUN`
  Ejecuta un programa BASIC. Solo funciona si el PRG contiene un stub BASIC válido en $0801.

* `SYS`
  Ejecuta código máquina en una dirección específica de memoria.

### El STUB de Basic

Un stub BASIC es un pequeño programa ubicado en $0801 que permite que `RUN` ejecute código máquina indirectamente.

Este contiene una instrucción BASIC que llama a `SYS`, apuntando al entrypoint del programa en ensamblador.

Si el PRG no incluye este stub, `RUN` no ejecutará el programa, siendo necesario usar `SYS` manualmente.
