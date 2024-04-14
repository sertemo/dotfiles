#!/bin/bash

# Ejecuta verificaciones
# Black, mypy, flake8 y pytest
# Estos paquetes deben estar instalados dentro de poetry en el proyecto correspondiente
# Asume que los scripts del proyecto están dentro de carpeta 'src'

# Define colores
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[0;33m'
NC='\033[0m' # Sin color

# Revisa si se proporcionó un argumento
# if [ "$#" -ne 1 ]; then
#    echo -e "${RED}Error: Debes proporcionar la ruta del proyecto como argumento.${NC}"
#    exit 1
# fi

# Usa el primer argumento como la ruta del proyecto
# project_path="$1"
project_path="src"

echo -e "${YELLOW}Ejecutando Black...${NC}"
black .
echo -e "${GREEN}Black finalizado correctamente.${NC}"

echo -e "${YELLOW}Ejecutando MyPy...${NC}"
mypy .
echo -e "${GREEN}MyPy finalizado correctamente.${NC}"

echo -e "${YELLOW}Ejecutando Flake8...${NC}"
if flake8 .; then
    echo -e "${GREEN}Flake8 finalizado correctamente. No se encontraron problemas.${NC}"
else
    echo -e "${RED}Flake8 encontró problemas.${NC}"
fi

echo -e "${YELLOW}Ejecutando Pytest...${NC}"
pytest
echo -e "${GREEN}Pytest finalizado correctamente.${NC}"


