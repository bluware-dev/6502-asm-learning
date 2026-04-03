# Setup de entorno

## VICE (Versatile Commodore Emulator)

Arch:

```sh
sudo pacman -S vice
```

Debian:

```sh
sudo apt install vice
```

> Para configuraciones adicionales en Debian:
> https://forums.debian.net/viewtopic.php?t=150499

Flatpak:

```sh
flatpak install --user flathub net.sf.VICE
```

Web oficial:
https://vice-emu.sourceforge.io/index.html#download

El emulador se ejecuta con:

```sh
x64
```

---

## xa (6502 Assembler)

Web oficial:
https://www.floodgap.com/retrotech/xa/

Repositorio:
https://github.com/fachat/xa65

Compilación en sistemas UNIX-like:

```sh
git clone https://github.com/fachat/xa65
cd xa65/xa/
make
```

El binario resultante (`xa`) puede ejecutarse directamente o agregarse al `PATH`.

---

## Windows (MSYS2)

https://www.msys2.org/

Dentro de la shell:

```sh
pacman -S --needed git base-devel
git clone https://github.com/fachat/xa65
cd xa65/xa/
make
```
