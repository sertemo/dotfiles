#!/bin/bash

## README ##

# Este script requiere 2 argumentos:
# 1. Nombre del proyecto/repositorio
# 2. Descripción del proyecto/repositorio (breve) -> Para el repo de Github
# Script para crear e inicializar un proyecto con poetry dentro de una carpeta src (source)

# Instala las depedencias black, mypy y flake8 y pytest
# Crea archivo de configuración setup.cfg de flake8
# Añade a pyproject.toml la configuración de mypy y de pytest
# Crea archivo LICENSE con Apache 2.0
# Escribe una estructura del archivo README
# Copia el script .check.sh dentro del proyecto y lo hace ejecutable
# Es importante que ambos archivos .create.sh y check.sh estén originariamente en el mismo directorio
# El archivo .check.sh ejecuta las verificaciones de black, mypy, flake8 y pytest
# El archivo .check.sh asume que el proyecto está dentro de la carpeta src
# Es necesario tener poetry, git y Git CLI instalados en el sistema
# También será necesario tener la variable de entorno GH_TOKEN con el valor del token

# Colores para los mensajes
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # Sin color


# Verificar si se pasaron el nombre del proyecto y la descripción como argumentos
if [ "$#" -ne 2 ]; then
   echo -e "${RED}Error: Debes proporcionar el nombre y la descripción del proyecto.${NC}"
   echo -e "${RED}Ejemplo:$ sh $0 MiProyecto 'Mi mejor proyecto hasta la fecha'${NC}"
   exit 1
fi

# Obtiene la ruta al directorio del script
script_dir="$(dirname "$0")"
project_name="$1"
project_description="$2"
python_version="^3.10"
username=sertemo

echo "Directorio raiz: $script_dir"
# Crear el proyecto con Poetry
echo "Creando proyecto: $project_name"
poetry new --src "$project_name"

# Copiar el script .check.sh al directorio del proyecto
if [ ! -f "${script_dir}/.check.sh" ]; then
   echo "El archivo .check.sh no existe en la ubicación especificada. El archivo .check.sh y .create.sh debe estar en la misma ruta"
   exit 1
fi
echo "Copiando script .check.sh..."
cp "${script_dir}/.check.sh" ./${project_name}
chmod +x .check.sh

# Navegar al nuevo directorio del proyecto
echo "Creando proyecto: $project_name"
cd "$project_name" || exit

# Actualizar la versión de Python en pyproject.toml a ^3.10
echo "Configurando la versión de Python a ${python_version} en pyproject.toml..."
sed -i "s/^python = .*/python = \"${python_version}\"/" pyproject.toml

echo "Instalando dependencias del proyecto..."
poetry install

# Añadir poetry plugin: Export para poder sacar requirements.txt
# https://pypi.org/project/poetry-plugin-export/
poetry self add poetry-plugin-export

# Añadir dependencias de desarrollo
echo "Añadiendo dependencias de desarrollo: mypy, flake8, pytest, pytest-cov y black"
poetry add -G dev black flake8 mypy pytest pytest-cov toml
# Añadimos dependencia toml (para sacar la versión de pyproject.toml si necesario)
# Y también python-dotenv para gestionar secrets como api keys etc
echo "Añadiendo dependencias: toml y python-dotenv..."
poetry add toml python-dotenv

# Crear archivo LICENSE Apache 2.0
echo "Creando archivo LICENSE..."
cat > LICENSE << "EOF"
                                 Apache License
                           Version 2.0, January 2004
                        http://www.apache.org/licenses/

   TERMS AND CONDITIONS FOR USE, REPRODUCTION, AND DISTRIBUTION

   1. Definitions.

      "License" shall mean the terms and conditions for use, reproduction,
      and distribution as defined by Sections 1 through 9 of this document.

      "Licensor" shall mean the copyright owner or entity authorized by
      the copyright owner that is granting the License.

      "Legal Entity" shall mean the union of the acting entity and all
      other entities that control, are controlled by, or are under common
      control with that entity. For the purposes of this definition,
      "control" means (i) the power, direct or indirect, to cause the
      direction or management of such entity, whether by contract or
      otherwise, or (ii) ownership of fifty percent (50%) or more of the
      outstanding shares, or (iii) beneficial ownership of such entity.

      "You" (or "Your") shall mean an individual or Legal Entity
      exercising permissions granted by this License.

      "Source" form shall mean the preferred form for making modifications,
      including but not limited to software source code, documentation
      source, and configuration files.

      "Object" form shall mean any form resulting from mechanical
      transformation or translation of a Source form, including but
      not limited to compiled object code, generated documentation,
      and conversions to other media types.

      "Work" shall mean the work of authorship, whether in Source or
      Object form, made available under the License, as indicated by a
      copyright notice that is included in or attached to the work
      (an example is provided in the Appendix below).

      "Derivative Works" shall mean any work, whether in Source or Object
      form, that is based on (or derived from) the Work and for which the
      editorial revisions, annotations, elaborations, or other modifications
      represent, as a whole, an original work of authorship. For the purposes
      of this License, Derivative Works shall not include works that remain
      separable from, or merely link (or bind by name) to the interfaces of,
      the Work and Derivative Works thereof.

      "Contribution" shall mean any work of authorship, including
      the original version of the Work and any modifications or additions
      to that Work or Derivative Works thereof, that is intentionally
      submitted to Licensor for inclusion in the Work by the copyright owner
      or by an individual or Legal Entity authorized to submit on behalf of
      the copyright owner. For the purposes of this definition, "submitted"
      means any form of electronic, verbal, or written communication sent
      to the Licensor or its representatives, including but not limited to
      communication on electronic mailing lists, source code control systems,
      and issue tracking systems that are managed by, or on behalf of, the
      Licensor for the purpose of discussing and improving the Work, but
      excluding communication that is conspicuously marked or otherwise
      designated in writing by the copyright owner as "Not a Contribution."

      "Contributor" shall mean Licensor and any individual or Legal Entity
      on behalf of whom a Contribution has been received by Licensor and
      subsequently incorporated within the Work.

   2. Grant of Copyright License. Subject to the terms and conditions of
      this License, each Contributor hereby grants to You a perpetual,
      worldwide, non-exclusive, no-charge, royalty-free, irrevocable
      copyright license to reproduce, prepare Derivative Works of,
      publicly display, publicly perform, sublicense, and distribute the
      Work and such Derivative Works in Source or Object form.

   3. Grant of Patent License. Subject to the terms and conditions of
      this License, each Contributor hereby grants to You a perpetual,
      worldwide, non-exclusive, no-charge, royalty-free, irrevocable
      (except as stated in this section) patent license to make, have made,
      use, offer to sell, sell, import, and otherwise transfer the Work,
      where such license applies only to those patent claims licensable
      by such Contributor that are necessarily infringed by their
      Contribution(s) alone or by combination of their Contribution(s)
      with the Work to which such Contribution(s) was submitted. If You
      institute patent litigation against any entity (including a
      cross-claim or counterclaim in a lawsuit) alleging that the Work
      or a Contribution incorporated within the Work constitutes direct
      or contributory patent infringement, then any patent licenses
      granted to You under this License for that Work shall terminate
      as of the date such litigation is filed.

   4. Redistribution. You may reproduce and distribute copies of the
      Work or Derivative Works thereof in any medium, with or without
      modifications, and in Source or Object form, provided that You
      meet the following conditions:

      (a) You must give any other recipients of the Work or
          Derivative Works a copy of this License; and

      (b) You must cause any modified files to carry prominent notices
          stating that You changed the files; and

      (c) You must retain, in the Source form of any Derivative Works
          that You distribute, all copyright, patent, trademark, and
          attribution notices from the Source form of the Work,
          excluding those notices that do not pertain to any part of
          the Derivative Works; and

      (d) If the Work includes a "NOTICE" text file as part of its
          distribution, then any Derivative Works that You distribute must
          include a readable copy of the attribution notices contained
          within such NOTICE file, excluding those notices that do not
          pertain to any part of the Derivative Works, in at least one
          of the following places: within a NOTICE text file distributed
          as part of the Derivative Works; within the Source form or
          documentation, if provided along with the Derivative Works; or,
          within a display generated by the Derivative Works, if and
          wherever such third-party notices normally appear. The contents
          of the NOTICE file are for informational purposes only and
          do not modify the License. You may add Your own attribution
          notices within Derivative Works that You distribute, alongside
          or as an addendum to the NOTICE text from the Work, provided
          that such additional attribution notices cannot be construed
          as modifying the License.

      You may add Your own copyright statement to Your modifications and
      may provide additional or different license terms and conditions
      for use, reproduction, or distribution of Your modifications, or
      for any such Derivative Works as a whole, provided Your use,
      reproduction, and distribution of the Work otherwise complies with
      the conditions stated in this License.

   5. Submission of Contributions. Unless You explicitly state otherwise,
      any Contribution intentionally submitted for inclusion in the Work
      by You to the Licensor shall be under the terms and conditions of
      this License, without any additional terms or conditions.
      Notwithstanding the above, nothing herein shall supersede or modify
      the terms of any separate license agreement you may have executed
      with Licensor regarding such Contributions.

   6. Trademarks. This License does not grant permission to use the trade
      names, trademarks, service marks, or product names of the Licensor,
      except as required for reasonable and customary use in describing the
      origin of the Work and reproducing the content of the NOTICE file.

   7. Disclaimer of Warranty. Unless required by applicable law or
      agreed to in writing, Licensor provides the Work (and each
      Contributor provides its Contributions) on an "AS IS" BASIS,
      WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or
      implied, including, without limitation, any warranties or conditions
      of TITLE, NON-INFRINGEMENT, MERCHANTABILITY, or FITNESS FOR A
      PARTICULAR PURPOSE. You are solely responsible for determining the
      appropriateness of using or redistributing the Work and assume any
      risks associated with Your exercise of permissions under this License.

   8. Limitation of Liability. In no event and under no legal theory,
      whether in tort (including negligence), contract, or otherwise,
      unless required by applicable law (such as deliberate and grossly
      negligent acts) or agreed to in writing, shall any Contributor be
      liable to You for damages, including any direct, indirect, special,
      incidental, or consequential damages of any character arising as a
      result of this License or out of the use or inability to use the
      Work (including but not limited to damages for loss of goodwill,
      work stoppage, computer failure or malfunction, or any and all
      other commercial damages or losses), even if such Contributor
      has been advised of the possibility of such damages.

   9. Accepting Warranty or Additional Liability. While redistributing
      the Work or Derivative Works thereof, You may choose to offer,
      and charge a fee for, acceptance of support, warranty, indemnity,
      or other liability obligations and/or rights consistent with this
      License. However, in accepting such obligations, You may act only
      on Your own behalf and on Your sole responsibility, not on behalf
      of any other Contributor, and only if You agree to indemnify,
      defend, and hold each Contributor harmless for any liability
      incurred by, or claims asserted against, such Contributor by reason
      of your accepting any such warranty or additional liability.

   END OF TERMS AND CONDITIONS

   APPENDIX: How to apply the Apache License to your work.

      To apply the Apache License to your work, attach the following
      boilerplate notice, with the fields enclosed by brackets "[]"
      replaced with your own identifying information. (Don't include
      the brackets!)  The text should be enclosed in the appropriate
      comment syntax for the file format. We also recommend that a
      file or class name and description of purpose be included on the
      same "printed page" as the copyright notice for easier
      identification within third-party archives.

   Copyright 2024 Sergio Tejedor Moreno

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License..

EOF

# Escribimos la estructura del archivo README.md
cat > README.md << EOF
# $project_name
v0.1.0

![Tests](https://github.com/sertemo/$project_name/actions/workflows/tests.yml/badge.svg)
![Dependabot](https://img.shields.io/badge/dependabot-enabled-blue.svg?logo=dependabot)
![GitHub](https://img.shields.io/github/license/sertemo/$project_name)

## Descripción

## Empezando

### Pre-requisitos

### Instalación

## Uso

## Desarrollo

### Código de Conducta

### Proceso de Pull Request

## Tests

## Construido Con

## Contribuyentes

## Licencia
Copyright 2024 Sergio Tejedor Moreno

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
EOF

# Creamos archivo update_readme.py para cambiar primera linea
# del README y poner automaticamente la versión y el nombre del proyecto
echo "Creando archivo update_readme.py..."
cat > update_readme.py << EOF
"""Actualiza en el README la versión"""

import toml


def update_readme():
    # Leer la configuración del proyecto
    with open('pyproject.toml', 'r') as file:
        data = toml.load(file)
        project_version = data['tool']['poetry']['version']

    # Leer el contenido actual de README.md y actualizar
    with open('README.md', 'r') as file:
        readme_contents = file.readlines()

    # La versión está en la segunda fila
    readme_contents[1] = f"## {project_version}\n"

    # Escribir el contenido actualizado de nuevo a README.md
    with open('README.md', 'w') as file:
        file.writelines(readme_contents)

if __name__ == "__main__":
    update_readme()
EOF

# Crear archivo setup.cfg para Flake8
echo "Creando archivo setup.cfg..."
cat > setup.cfg << EOF
[flake8]
max-line-length = 120
exclude = .git,__pycache__,build,dist,.venv,.github,.env
ignore = I101,D100,D101,D102,D103,D104,D105,D107,D401,E203,I900,N802,N806,N812,W503,S311,S605,S607
EOF

# Añadimos a tests un archivo para las fixtures
echo "Creando archivo conftest.py para fixtures..."
cat > tests/conftest.py << EOF
# Copyright 2024 Sergio Tejedor Moreno

# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at

#     http://www.apache.org/licenses/LICENSE-2.0

# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

import pytest


@pytest.fixture(scope="session")
def mi_fixture():
   raise NotImplementedError()
EOF

# Añadimos también un dummy test para que pase pytest
echo "Creando archivo test_example.py..."
cat > tests/test_example.py << EOF
# Copyright 2024 Sergio Tejedor Moreno

# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at

#     http://www.apache.org/licenses/LICENSE-2.0

# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.


def test_example():
   assert True
EOF


# Añadir la configuración de MyPy a pyproject.toml
echo "Configurando MyPy en pyproject.toml..."

echo -e "\n[tool.mypy]" >> pyproject.toml
echo -e "mypy_path = \"src\"" >> pyproject.toml #! Ojo está puesto src
echo "check_untyped_defs = true" >> pyproject.toml
echo "disallow_any_generics = true" >> pyproject.toml
echo "ignore_missing_imports = true" >> pyproject.toml
echo "no_implicit_optional = true" >> pyproject.toml
echo "show_error_codes = true" >> pyproject.toml
echo "strict_equality = true" >> pyproject.toml
echo "warn_redundant_casts = true" >> pyproject.toml
echo "warn_return_any = true" >> pyproject.toml
echo "warn_unreachable = true" >> pyproject.toml
echo "warn_unused_configs = true" >> pyproject.toml
echo "no_implicit_reexport = true" >> pyproject.toml

# Añadir la configuración de pytest
echo "Configurando Pytest en pyproject.toml..."
echo -e "\n[tool.pytest.ini_options]" >> pyproject.toml
cat >> pyproject.toml << EOF
addopts = "--cov=$project_name"
testpaths = [
   "tests",
]
EOF

# Añadimos archivo .env
echo "Creando archivo .env ..."
touch .env

# Creando el repositorio de GitHub
# Para poder hacer esto hace falta tener un token y guardarlo en la variable de entorno GH_TOKEN
echo "Creando el repositorio en Github..."
gh repo create "$project_name" --public -d "$project_description"


# Crea un gitignore
# Lo descarga de la web haciendo una query con windows y python
# Ojo he tenido que instalar wget con chocolatey
# Para instalar chocolatey desde PowerShell como administrador
# Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
# choco install wget
wget -O .gitignore https://www.toptal.com/developers/gitignore/api/python,windows


# Inicializar Git
echo "Inicializando repositorio Git..."
git init


# Crear la carpeta .github/workflows
# Crear el workflow
# Decido no incluir 'continue-on-error: true' en los steps
# Para forzar visualización de errores si los hay
echo "Creando workflow de github..."
mkdir -p .github/workflows
cat > .github/workflows/tests.yml << EOF
name: Tests

on:
  push:
    branches:
      - main
  pull_request:

jobs:
  test:
    runs-on: \${{ matrix.os }}
    strategy:
      matrix:
        os: [ubuntu-latest, windows-latest]
        python-version: ['3.10', '3.11']

    steps:
    - uses: actions/checkout@v4
    
    - name: Set up Python \${{ matrix.python-version }}
      uses: actions/setup-python@v5
      with:
        python-version: \${{ matrix.python-version }}
        
    - name: Upgrade pip and Install Poetry
      run: |
        python -m pip install --upgrade pip
        pip install poetry

    - name: Install dependencies
      run: poetry install --only dev

    - name: Update version in README
      run: poetry run python update_readme.py
      if: github.ref == 'refs/heads/main'

    - name: Run Black
      run: poetry run black --check .

    - name: Run MyPy
      run: poetry run mypy .

    - name: Run Flake8
      run: poetry run flake8 .

    - name: Run Pytest
      run: poetry run pytest

EOF

# Crear archivos de requisitos si es necesario
# Puedes crear un entorno virtual y exportar las dependencias
echo "Creando archivos de requisitos..."
poetry export -f requirements.txt --output requirements.txt --without-hashes
poetry export --with dev -f requirements.txt --output requirements_dev.txt --without-hashes

# Lanzamos black antes de subir a github para asegurarnos de que los checks pasen en Github Actions
# poetry run black .
#! Modificación porque no me va la shell de poetry
# Hay que activar el entorno virtual primero
# Para esto tengo que tener el alias poetryshell="source .venv\Scripts\activate" en .bashrc
source .venv/Scripts/activate
black .
#! Si consigo hacer que funcione volveremos a poetry run black .

# Realizamos el primer commit
echo "Realizamos el primer commit..."
git add .
git commit -m "Proyecto inicial con configuración de Poetry, Black, Pytest, Flake8, MyPy y licencia Apache."
git branch -M main


# Vinculamos remote y main
echo "Haciendo primer push..."
git remote add origin git@github.com:$username/$project_name.git
git push -u origin main


echo -e "${GREEN}Proyecto $project_name creado y configurado con éxito.${NC}"

# Activar el entorno virtual
# echo "Activando el entorno virtual..."
# poetry shell

