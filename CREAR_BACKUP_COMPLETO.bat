@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion

echo ==========================================
echo    BACKUP COMPLETO PORTABLE - SONIA APP
echo ==========================================
echo.
echo.

REM Obtener fecha y hora
for /f "tokens=2 delims==" %%I in ('wmic os get localdatetime /value') do set datetime=%%I
set TIMESTAMP=%datetime:~0,4%-%datetime:~4,2%-%datetime:~6,2%_%datetime:~8,2%-%datetime:~10,2%-%datetime:~12,2%

REM Nombre del backup
set BACKUP_NAME=SONIA_APP_BACKUP_COMPLETO_%TIMESTAMP%
set BACKUP_DIR=%~dp0%BACKUP_NAME%

echo [1/8] Creando carpeta de backup...
echo Nombre: %BACKUP_NAME%
mkdir "%BACKUP_DIR%" 2>nul

echo.
echo [2/8] Copiando código fuente (web)...
xcopy /E /I /Y /Q "web" "%BACKUP_DIR%\web\" >nul 2>&1
if %errorlevel% equ 0 (
    echo   ✓ Código fuente copiado
) else (
    echo   ✗ Error copiando código fuente
)

echo.
echo [3/8] Copiando scripts de inicio...
copy /Y "Run Sonia App.bat" "%BACKUP_DIR%\" >nul 2>&1
copy /Y "Run Sonia Admin.bat" "%BACKUP_DIR%\" >nul 2>&1
if exist "SUBIR_A_GITHUB.bat" copy /Y "SUBIR_A_GITHUB.bat" "%BACKUP_DIR%\" >nul 2>&1
if exist "SUBIR_A_GITHUB.ps1" copy /Y "SUBIR_A_GITHUB.ps1" "%BACKUP_DIR%\" >nul 2>&1
echo   ✓ Scripts de inicio copiados

echo.
echo [4/8] Copiando archivos de configuración...
if exist "requirements" xcopy /E /I /Y /Q "requirements" "%BACKUP_DIR%\requirements\" >nul 2>&1
if exist ".env" copy /Y ".env" "%BACKUP_DIR%\" >nul 2>&1
if exist ".env.local" copy /Y ".env.local" "%BACKUP_DIR%\" >nul 2>&1
if exist "web\.env" copy /Y "web\.env" "%BACKUP_DIR%\web\" >nul 2>&1
if exist "web\.env.local" copy /Y "web\.env.local" "%BACKUP_DIR%\web\" >nul 2>&1
echo   ✓ Configuración copiada

echo.
echo [5/8] Copiando base de datos...
if exist "web\src\data\db.json" (
    mkdir "%BACKUP_DIR%\web\src\data" 2>nul
    copy /Y "web\src\data\db.json" "%BACKUP_DIR%\web\src\data\" >nul 2>&1
    echo   ✓ Base de datos copiada
) else (
    echo   ⚠ No se encontró db.json
)

echo.
echo [6/8] Copiando imágenes de productos...
if exist "web\public\uploads" (
    xcopy /E /I /Y /Q "web\public\uploads" "%BACKUP_DIR%\web\public\uploads\" >nul 2>&1
    echo   ✓ Imágenes copiadas
) else (
    echo   ⚠ No se encontró carpeta uploads
)

echo.
echo [7/8] Copiando documentación...
if exist "GUIA_BACKUP_DATOS.md" copy /Y "GUIA_BACKUP_DATOS.md" "%BACKUP_DIR%\" >nul 2>&1
if exist "GUIA_GITHUB.md" copy /Y "GUIA_GITHUB.md" "%BACKUP_DIR%\" >nul 2>&1
if exist "README.md" copy /Y "README.md" "%BACKUP_DIR%\" >nul 2>&1
echo   ✓ Documentación copiada

echo.
echo [8/8] Creando archivo de información del backup...

(
echo ==========================================
echo   BACKUP COMPLETO - SONIA APP
echo ==========================================
echo.
echo Fecha de creación: %date% %time%
echo Nombre del backup: %BACKUP_NAME%
echo.
echo CONTENIDO DEL BACKUP:
echo   - Código fuente completo ^(web/^)
echo   - Scripts de inicio ^(.bat^)
echo   - Base de datos ^(db.json^)
echo   - Imágenes de productos ^(uploads/^)
echo   - Archivos de configuración
echo   - Documentación
echo.
echo CÓMO RESTAURAR:
echo   1. Copia esta carpeta completa a donde quieras
echo   2. Abre la carpeta en la terminal
echo   3. Ejecuta: cd web
echo   4. Ejecuta: npm install
echo   5. Ejecuta: npm run build
echo   6. Usa "Run Sonia App.bat" para iniciar
echo.
echo NOTA: Este backup es completamente portable
echo y puede ser movido a cualquier computadora.
echo.
echo ==========================================
) > "%BACKUP_DIR%\LEEME_PRIMERO.txt"

echo   ✓ Información del backup creada

echo.
echo.
echo ==========================================
echo   BACKUP COMPLETADO EXITOSAMENTE
echo ==========================================
echo.
echo Ubicación: %BACKUP_DIR%
echo.
echo Contenido incluido:
echo   ✓ Código fuente completo
echo   ✓ Scripts de inicio
echo   ✓ Base de datos
echo   ✓ Imágenes de productos
echo   ✓ Configuración
echo   ✓ Documentación
echo.
echo Este backup es PORTABLE y puede ser:
echo   - Copiado a un USB
echo   - Enviado por email ^(si es pequeño^)
echo   - Subido a Google Drive / OneDrive
echo   - Movido a otra computadora
echo.
echo ==========================================
echo.

REM Calcular tamaño del backup
for /f "tokens=3" %%a in ('dir "%BACKUP_DIR%" /s /-c ^| find "bytes"') do set BACKUP_SIZE=%%a
echo Tamaño del backup: %BACKUP_SIZE% bytes
echo.

pause
