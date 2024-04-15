# .dotfiles
## Para instalar los archivos de configuración en un nuevo ordenador
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

## Para añadir la lista de extensiones de VSCode

```sh
code --list-extensions > ~/dotfiles/vscode/extensions.list
```
Esto crea un archivo extensions.list en la carpeta .dotfiles/vscode

---
## .create.sh y .check.sh

El 01/04/2024 se han añadido los scripts:
- .check.sh
- .create.sh

Estos archivos son scripts para automatizar la creación de un proyecto con poetry y la ejecución de chequeos de código.

### Requisitos
- **poetry** - IMPORTANTE - Problemas con la shell sin resolver
- **git** (con Bash)
- Cuenta de **GitHub**
- **GitHub CLI** instalado
- Variable GH_TOKEN en el PATH con un token válido


El archivo **.create.sh** crea un proyecto con poetry (*poetry new*).

Requiere de 2 argumentos:
1. El nombre del proyecto (**sin espacios**). Ejemplo: **miProyecto**
2. Descripción del proyecto. Ejemplo: **"Proyecto de ejemplo para probar automatizaciones"**

Se ejecuta:
```sh
$ sh .create.sh <nombre_del_proyecto> "<descripción del proyecto>"
```

Se realizarán las siguientes tareas:
1. Crea un nuevo proyecto con **poetry** y fichero '**src**'
2. Cambia la versión de Python a ^3.10 en el archivo **pyproject.toml**
3. Copia el archivo **check.sh** dentro de la carpeta del proyecto y lo hace ejecutable
4. Añade dependencias de desarrollo con poetry: **black**, **mypy**, **pytest**, **pytest-cov** y **flake8**
5. Añade la librería **toml** y **python-dotenv** para manejar la versión de pyproject.toml y gestionar keys
6. Crea archivo de **licencia** con Apache 2.0
7. Escribe en **README** una estructura de partida con encabezados
8. Crea el archivo **conftest.py** en tests/ y define una fixture tipo
9. Crea un archivo **test_example.py** en tests/ con un dummy test para que pytest no de problemas
10. Crea archivo **setup.cfg** con la configuración de flake8
11. Añade configuración de **mypy** y **pytest-cov** a pyproject.toml
12. Crea un archivo **.env** para gestionar secretos
12. Crea un repositorio en **GitHub**. NOTA: Debes tener en la variable de entorno GH_TOKEN tu token de acceso e instalado **Github CLI**
13. Inicializa **git**
14. Crea un **.gitignore** y añade algunos folders como build y dist
15. Crea la carpeta **.github/workflows** con el archivo **tests.yml** con lo siguiente:
    - 2 os: **ubuntu** y **windows**
    - 2 versiones python: **3.10** y **3.11**
    - Se lanzan los tests de mypy, black, flake8 y pytest al hacer **push** y **pull request**
16. Crea el **requirements.txt** vacío 
17. Crea el **requirements_dev.txt** con las dependencias de desarrollo
18. Lanza **black** con poetry
19. Realiza el **primer commit**
120. Realiza el primer **push** al repo de  GitHub


El archivo **check.sh** realiza lo siguiente:
1. Ejecuta **black** con poetry run (se suprimer el **poetry run**)
2. Ejecuta **mypy** con poetry run (se suprimer el **poetry run**)
3. Ejecuta **flake8** con poetry run (se suprimer el **poetry run**)
4. Ejecuta **pytest-cov** con poetry run (se suprimer el **poetry run**)

El archivo **.check.sh** realiza las comprobaciones dentro del directorio del proyecto.

Para ejecutar los chequeos:

```sh
$ ./.check.sh
```
### Actualizaciones
- 15/04/2024
    - Se añade instalación manual del plugin de poetry para export: **poetry-plugin-export**
    - Se activa el entorno virtual manualmente antes de ejecutar black con **source .venv/Scripts/activate**