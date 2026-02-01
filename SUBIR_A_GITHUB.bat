@echo off
chcp 65001 >nul
title SUBIR CAMBIOS A GITHUB - SONIA APP
color 0A

echo ========================================================
echo      ASISTENTE DE SUBIDA A GITHUB - SONIA APP
echo ========================================================
echo.

:: 1. Verificar si git está instalado (aunque ya sabemos que si, es buena practica)
git --version >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERROR] Git no está instalado o no se encuentra en el PATH.
    echo Por favor instala Git para Windows: https://git-scm.com/download/win
    pause
    exit /b
)

:: 2. Verificar si existe repositorio local
if not exist ".git" (
    echo [INFO] No se detectó un repositorio Git. Inicializando...
    git init
    git branch -M main
    echo [OK] Repositorio inicializado.
    echo.
)

:: 3. Verificar si existe remoto 'origin'
git remote get-url origin >nul 2>&1
if %errorlevel% neq 0 (
    echo [ATENCION] No hay un repositorio remoto configurado.
    echo Por favor, ve a GitHub, crea un nuevo repositorio y copia la URL.
    echo (Debe verse como: https://github.com/tu-usuario/tu-repo.git)
    echo.
    set /p REPO_URL="Pega la URL del repositorio aqui y presiona ENTER: "
    
    if "%REPO_URL%"=="" (
        echo [ERROR] No ingresaste ninguna URL. Cancelando.
        pause
        exit /b
    )

    git remote add origin %REPO_URL%
    echo [OK] Repositorio remoto configurado.
    echo.
)

echo [INFO] Preparando cambios para subir...
git add .

echo [INFO] Creando copia de seguridad...
set FECHA=%DATE% %TIME%
git commit -m "Actualizacion automatica: %FECHA%"

echo [INFO] Subiendo a GitHub...
git push -u origin main

if %errorlevel% neq 0 (
    echo.
    echo [ERROR] Hubo un problema al subir los cambios.
    echo Posibles causas:
    echo  1. No tienes internet.
    echo  2. Es la primera vez y necesitas iniciar sesion en la ventana emergente.
    echo  3. El repositorio remoto tiene cambios que tu no tienes (ejecuta git pull primero).
    echo.
    echo Intenta ejecutar 'git pull origin main --allow-unrelated-histories' si el repo no estaba vacio.
) else (
    echo.
    echo ========================================================
    echo      CAMBIOS SUBIDOS EXITOSAMENTE A GITHUB
    echo ========================================================
)

echo.
pause
