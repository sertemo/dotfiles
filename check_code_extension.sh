#!/bin/bash

# Ubicación del archivo extensions.list
EXTENSIONS_FILE="$HOME/.dotfiles/vscode/extensions.list"

# Verificar la disponibilidad de cada extensión en el marketplace
echo "Checking availability of extensions listed in $EXTENSIONS_FILE..."

#! No funciona la API
while IFS= read -r extension
do
    if [[ $extension = \#* || -z $extension ]]; then
        continue  # Ignorar líneas que son comentarios o vacías
    fi
    echo "Checking availability for $extension..."
    response=$(curl -s -o /dev/null -w "%{http_code}" "https://marketplace.visualstudio.com/items?itemName=$extension")
    echo "HTTP Response Code: $response"  # Imprimir código de estado HTTP
    if [ "$response" -eq 200 ]; then
        echo "$extension is available."
    else
        echo "$extension is NOT available."
    fi
done < "$EXTENSIONS_FILE"

echo "All extensions have been checked."