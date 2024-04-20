#!/bin/bash

# Directorio donde se encuentran tus dotfiles
# Ejecutar desde consola bash
DOTFILES_DIR="$HOME/.dotfiles"

# Configuración para VS Code
VSCODE_DIR="$HOME/AppData/Roaming/Code/User"

# Crear enlaces simbólicos
# Este proceso eliminará los archivos de configuración existentes 
# y los reemplazará con enlaces a tus dotfiles
# Crear enlaces simbólicos para la configuración de VS Code
ln -sfv "$DOTFILES_DIR/vscode/settings.json" "$VSCODE_DIR/settings.json"
ln -sfv "$DOTFILES_DIR/vscode/snippets" "$VSCODE_DIR/snippets"

# -s: Crea un enlace simbólico.
# -f: Fuerza la creación del enlace simbólico y elimina el archivo de destino si ya existe.
# -v: Verboso, muestra detalles de lo que el comando está haciendo.

# Bash
ln -sfv "$DOTFILES_DIR/.bashrc" $HOME/.bashrc

# Git
ln -sfv "$DOTFILES_DIR/.gitconfig" $HOME/.gitconfig

# Iniciar SshAgent
ln -sfv "$DOTFILES_DIR/IniciarSshAgent.ps1" $HOME/IniciarSshAgent.ps1

# instalar extensiones de vscode
cat $HOME/.dotfiles/vscode/extensions.list | xargs -L 1 code --install-extension


echo "Dotfiles instalados correctamente."

# Asegurarse de hacer el script este ejecutable con:
# chmod +x $HOME/.dotfiles/install.sh
