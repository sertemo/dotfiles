# .dotfiles
## Para instalar los archivos de configuración:
1. Descargar de GitHub la carpeta **.dotfiles**

2. Hacer ejecutable desde **consola bash** el script **install.sh**:

```sh 
chmod +x $HOME/.dotfiles/install.sh
```

3. Ejecutar el script desde terminal bash

```sh
$HOME/.dotfiles/install.sh
```

- Esta ejecución creará enlaces simbólicos en las carpetas correspondientes de:
 .bashrc -> ~/
 .gitconfig -> ~/
 settings.json (vscode): -> ~/AppData/Roaming/Code/User/
 snippets/ (vscode): -> ~/AppData/Roaming/Code/User/

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
