# .dotfiles
Para instalar los archivos de configuración:
1 - Descargar de GitHub la carpeta **.dotfiles**

2 - Hacer ejecutable desde **consola bash** el script **install.sh**:

```sh 
chmod +x $HOME/.dotfiles/install.sh
```

3 - Ejecutar el script desde terminal bash

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
