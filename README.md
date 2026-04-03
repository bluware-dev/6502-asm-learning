# 6502/6510 Assembly en Commodore 64

Repositorio orientado a comprender los fundamentos estructurales de programación en ensamblador 6502/6510 sobre C64, priorizando ampliar el modelo mental, control del hardware y modelos de ejecución.

---

## Índice

- [Setup de entorno](docs/SETUP.md)
- [Introducción](docs/00-introduccion.md)
- [Recursos](docs/RESOURCES.md)

---

## Descripción

Este repositorio documenta un entorno mínimo y un conjunto de apuntes para estudiar:

- Flujo de ensamblado (`ASM -> PRG`)
- Modelo de carga y ejecución en C64 (`LOAD`, `SYS`)
- Diferencias entre uso de KERNAL y acceso directo a hardware
- Conceptos de memoria: load address, ensamblado, entrypoint

El enfoque es deliberadamente simple y controlado:

- Sin toolchains complejos (no `cc65`)
- Sin runtime
- Sin dependencias innecesarias

Se prioriza:

- Entender el modelo de ejecución real
- Observar el comportamiento del sistema
- Minimizar abstracciones

---

## Flujo de trabajo

```sh
xa -o build/main.prg main.asm
x64 build/main.prg # Asume '-autostart'
```

Ejecución dentro de VICE:

```basic
LOAD "MAIN",8,1
SYS 49152
```

> No suele ser necesario ejecutar `LOAD "MAIN",8,1` gracias al default `-autostart` en VICE.

---

## Utilidad `./compile`

El repositorio incluye un wrapper para simplificar la compilación y ejecución de ejemplos ASM.

Permite:

* Compilar por nombre (búsqueda en `learn/` y `examples/`)
* Compilar por path directo
* Listar archivos disponibles
* Ejecutar automáticamente en VICE

Uso básico:

```sh
./compile <name|path.asm>
# o
./compile --help
```

Ejemplos:

```sh
./compile hello-basic
./compile examples/hello-basic.asm
```

Listado de archivos:

```sh
./compile --list
# forma corta:
./compile -ls
```

Compilar y ejecutar:

```sh
./compile hello-basic --execute
# formas cortas:
./compile hello-basic -x
./compile hello-basic -x64
```

Output generado:

```sh
build/main.prg
```

---

## Alcance

Este material no busca productividad ni desarrollo de aplicaciones completas.

Está orientado a:

* Formación conceptual
* Exploración de arquitectura básica
* Comprensión del hardware subyacente

---

## Notas

* El código está pensado para ser portable entre ensambladores compatibles, evitando features específicas.
* Se asume conocimiento básico de sistemas (memoria, CPU, representación numérica).
* El repositorio puede contener referencias externas con distintos niveles de formalidad técnica.

---

## Licencia

[MIT](LICENSE)
