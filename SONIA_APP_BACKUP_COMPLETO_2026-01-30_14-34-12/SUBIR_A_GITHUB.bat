@echo off
echo ==========================================
echo   SUBIR A GITHUB - SONIA APP
echo ==========================================
echo.

REM Verificar que Git esta instalado
git --version >nul 2>&1
if errorlevel 1 (
    echo [ERROR] Git no esta instalado o no esta en el PATH
    echo.
    echo Por favor:
    echo 1. Cierra esta ventana
    echo 2. Abre una NUEVA ventana de PowerShell
    echo 3. Ejecuta este script nuevamente
    echo.
    pause
    exit /b 1
)

echo [OK] Git esta instalado
echo.

REM Navegar a la carpeta web
cd web

echo Paso 1: Verificando configuracion de Git...
echo.

REM Verificar si Git esta configurado
git config user.name >nul 2>&1
if errorlevel 1 (
    echo Git no esta configurado. Vamos a configurarlo ahora.
    echo.
    set /p USERNAME="Ingresa tu nombre: "
    set /p USEREMAIL="Ingresa tu email: "
    
    git config --global user.name "!USERNAME!"
    git config --global user.email "!USEREMAIL!"
    
    echo.
    echo [OK] Git configurado correctamente
    echo.
) else (
    echo [OK] Git ya esta configurado
    echo Usuario: 
    git config user.name
    echo Email: 
    git config user.email
    echo.
)

echo Paso 2: Verificando si ya existe un repositorio Git...
echo.

if exist ".git" (
    echo [OK] Repositorio Git ya existe
    echo.
) else (
    echo Inicializando repositorio Git...
    git init
    git branch -M main
    echo [OK] Repositorio inicializado
    echo.
)

echo Paso 3: Agregando archivos al staging area...
echo.
git add .
echo [OK] Archivos agregados
echo.

echo Paso 4: Creando commit...
echo.
set /p COMMIT_MSG="Mensaje del commit (o presiona Enter para usar mensaje por defecto): "
if "%COMMIT_MSG%"=="" set COMMIT_MSG=Update: cambios en SONIA APP

git commit -m "%COMMIT_MSG%"
echo.

echo Paso 5: Configurando repositorio remoto...
echo.

REM Verificar si ya existe un remote
git remote get-url origin >nul 2>&1
if errorlevel 1 (
    echo No hay repositorio remoto configurado.
    echo.
    echo IMPORTANTE: Primero debes crear un repositorio en GitHub
    echo 1. Ve a: https://github.com/new
    echo 2. Nombre: sonia-app-fruto-bravo
    echo 3. Visibilidad: Private
    echo 4. NO agregues README ni .gitignore
    echo 5. Click "Create repository"
    echo.
    echo Despues de crear el repositorio, copia la URL que aparece
    echo Ejemplo: https://github.com/tu-usuario/sonia-app-fruto-bravo.git
    echo.
    set /p REPO_URL="Pega la URL del repositorio: "
    
    git remote add origin !REPO_URL!
    echo [OK] Repositorio remoto configurado
    echo.
) else (
    echo [OK] Repositorio remoto ya configurado:
    git remote get-url origin
    echo.
)

echo Paso 6: Subiendo codigo a GitHub...
echo.
echo NOTA: Te pedira autenticacion de GitHub
echo - Usuario: tu nombre de usuario de GitHub
echo - Password: tu Personal Access Token (NO tu contrasena)
echo.
echo Si no tienes un token:
echo 1. Ve a: https://github.com/settings/tokens
echo 2. Generate new token (classic)
echo 3. Selecciona: repo (todos los permisos)
echo 4. Copia el token y pegalo aqui
echo.
pause

git push -u origin main

if errorlevel 1 (
    echo.
    echo [ERROR] Hubo un problema al subir el codigo
    echo.
    echo Posibles soluciones:
    echo 1. Verifica tu conexion a internet
    echo 2. Verifica que el repositorio existe en GitHub
    echo 3. Verifica tus credenciales
    echo.
    echo Si el error dice "failed to push some refs":
    echo Ejecuta: git pull origin main --rebase
    echo Luego ejecuta este script nuevamente
    echo.
) else (
    echo.
    echo ==========================================
    echo   CODIGO SUBIDO EXITOSAMENTE A GITHUB
    echo ==========================================
    echo.
    echo Tu codigo ahora esta en GitHub!
    echo.
    echo Proximos pasos:
    echo 1. Ve a tu repositorio en GitHub para verificar
    echo 2. Cada vez que hagas cambios, ejecuta este script
    echo.
)

cd ..
pause
