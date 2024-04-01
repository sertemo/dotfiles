# .dotfiles
## Para instalar los archivos de configuración:
1. Clona el repositorio de GitHub a la carpeta **.dotfiles**

```sh
git clone https://github.com/sertemo/dotfiles.git ~/.dotfiles

```
2. Navega hasta la carpeta .dotfiles
```sh
cd ~/.dotfiles
```

3. Hacer ejecutable desde **consola bash** el script **install.sh**:

```sh 
chmod +x $HOME/.dotfiles/install.sh
```

4. Ejecutar el script desde terminal bash

```sh
$HOME/.dotfiles/install.sh
```

- Esta ejecución creará enlaces simbólicos en las carpetas correspondientes de:
 - .bashrc -> ~/
 - .gitconfig -> ~/
 - settings.json (vscode): -> ~/AppData/Roaming/Code/User/
 - snippets/ (vscode): -> ~/AppData/Roaming/Code/User/

- Instalará las extensiones de **extensions.list**

Notas:
- **code** debe de estar en el PATH

## Para añadir archivos de configuración a la carpeta .dotfiles
1. Desde **Bash** Copia el archivo a la carpeta **.dotfiles** (por ejemplo el archivo
settings.json de vscode). La ruta es de Windows:

```sh
cp ~/AppData/Roaming/Code/User/settings.json ~/.dotfiles/vscode/

```

2. Crea un **enlace simbólico** de la carpeta .dotfiles a la carpeta original

```sh
ln -sfv ".dotfiles/vscode/settings.json" "~/AppData/Roaming/Code/User/settings.json"
```

Esto reemplazará el archivo original por el enlace simbólico
- -s: Crea un enlace simbólico.
- -f: Fuerza la creación del enlace simbólico y elimina el archivo de destino si ya existe.
- -v: Verboso, muestra detalles de lo que el comando está haciendo.

---
## .create.sh y .check.sh

El 01/04/2024 se han añadido los scripts:
- .check.sh
- .create.sh

Estos archivos son scripts para automatizar la creación de un proyecto con poetry y la ejecución de chequeos de código.

Requiere tener instalados **poetry** y **git** en el sistema.

El archivo **.create.sh** crea un proyecto con poetry (*poetry new*)

Se ejecuta:
```sh
sh .create.sh <nombre_del_proyecto>
```

Se realizarán las siguientes tareas:
1. Crea un nuevo proyecto con poetry y fichero 'src'
2. Copia el archivo **check.sh** dentro de la carpeta del proyecto y lo hace ejecutable
3. Añade dependencias de desarrollo con poetry: **black**, **mypy**, **pytest**, **pytest-cov** y **flake8**
4. Crea archivo de **licencia** con Apache 2.0
5. Escribe en **README** una estructura de partida con encabezados
6. Crea el archivo **conftest.py** en tests/ y define una fixture tipo
7. Crea archivo **setup.cfg** con la configuración de flake8
8. Añade configuración de **mypy** y **pytest-cov** a pyproject.toml
9. Inicializa **git**
10. Crea un **.gitignore** y añade algunos folders como build y dist
11. Crea el **requirements.txt** vacío
12. Crea el **requirements_dev.txt** con las dependencias de desarrollo

El archivo **check.sh** realiza lo siguiente:
1. Ejecuta **black** con poetry run
2. Ejecuta **mypy** con poetry run
3. Ejecuta **flake8** con poetry run
4. Ejecuta **pytest-cov** con poetry run

El archivo **.check.sh** busca dentro de la carpeta **src**. Para ejecutar los chequeos:

```sh
./.check.sh
```
