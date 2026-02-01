@echo off
setlocal enabledelayedexpansion

echo ==========================================
echo    CREAR BACKUP PORTABLE - SONIA APP
echo ==========================================
echo.

REM Obtener fecha y hora para el nombre del backup
for /f "tokens=2 delims==" %%I in ('wmic os get localdatetime /value') do set datetime=%%I
set TIMESTAMP=%datetime:~0,4%-%datetime:~4,2%-%datetime:~6,2%_%datetime:~8,2%-%datetime:~10,2%-%datetime:~12,2%

set BACKUP_NAME=SONIA_APP_PORTABLE_BACKUP_%TIMESTAMP%
set SOURCE_DIR=%~dp0
set BACKUP_DIR=%~dp0%BACKUP_NAME%

echo [1/5] Creando carpeta de backup...
echo Nombre: %BACKUP_NAME%
echo.
mkdir "%BACKUP_DIR%"

echo [2/5] Copiando archivos de la aplicacion...
echo.

REM Copiar web sin las carpetas excluidas usando robocopy
echo   - Copiando codigo fuente...
robocopy "%SOURCE_DIR%web" "%BACKUP_DIR%\web" /E /XD node_modules .next .git /NFL /NDL /NJH /NJS /R:1 /W:1

echo   - Copiando scripts de inicio...
copy "%SOURCE_DIR%Run Sonia App.bat" "%BACKUP_DIR%\" > nul
copy "%SOURCE_DIR%Run Sonia Admin.bat" "%BACKUP_DIR%\" > nul

echo   - Copiando requerimientos y diseño...
robocopy "%SOURCE_DIR%requirements" "%BACKUP_DIR%\requirements" /E /NFL /NDL /NJH /NJS /R:1 /W:1

echo.
echo [3/5] Verificando datos importantes...
echo.

REM Verificar que la carpeta uploads existe y tiene archivos
if exist "%BACKUP_DIR%\web\public\uploads" (
    for /f %%A in ('dir /b /a-d "%BACKUP_DIR%\web\public\uploads" 2^>nul ^| find /c /v ""') do set UPLOAD_COUNT=%%A
    echo   OK Imagenes de productos: !UPLOAD_COUNT! archivos copiados
) else (
    echo   ADVERTENCIA No se encontraron imagenes subidas
    set UPLOAD_COUNT=0
)

REM Verificar logo
if exist "%BACKUP_DIR%\web\public\logo-fruto-bravo.png" (
    echo   OK Logo de Fruto Bravo incluido
) else (
    echo   ADVERTENCIA Logo no encontrado
)

REM Verificar mascota
if exist "%BACKUP_DIR%\web\public\walnut-mascot.png" (
    echo   OK Mascota incluida
) else (
    echo   ADVERTENCIA Mascota no encontrada
)

echo.
echo [4/5] Generando documentacion...
echo.

REM Crear archivo de informacion del backup
echo ========================================== > "%BACKUP_DIR%\BACKUP_INFO.txt"
echo   INFORMACION DEL BACKUP - SONIA APP >> "%BACKUP_DIR%\BACKUP_INFO.txt"
echo ========================================== >> "%BACKUP_DIR%\BACKUP_INFO.txt"
echo. >> "%BACKUP_DIR%\BACKUP_INFO.txt"
echo Fecha de creacion: %date% %time% >> "%BACKUP_DIR%\BACKUP_INFO.txt"
echo Nombre del backup: %BACKUP_NAME% >> "%BACKUP_DIR%\BACKUP_INFO.txt"
echo. >> "%BACKUP_DIR%\BACKUP_INFO.txt"
echo CONTENIDO: >> "%BACKUP_DIR%\BACKUP_INFO.txt"
echo   - Codigo fuente completo de la aplicacion web >> "%BACKUP_DIR%\BACKUP_INFO.txt"
echo   - Imagenes de productos subidas: !UPLOAD_COUNT! archivos >> "%BACKUP_DIR%\BACKUP_INFO.txt"
echo   - Scripts de inicio automatico >> "%BACKUP_DIR%\BACKUP_INFO.txt"
echo   - Archivos de configuracion >> "%BACKUP_DIR%\BACKUP_INFO.txt"
echo. >> "%BACKUP_DIR%\BACKUP_INFO.txt"
echo EXCLUIDO (se regenera automaticamente): >> "%BACKUP_DIR%\BACKUP_INFO.txt"
echo   - node_modules/ (dependencias) >> "%BACKUP_DIR%\BACKUP_INFO.txt"
echo   - .next/ (archivos compilados) >> "%BACKUP_DIR%\BACKUP_INFO.txt"
echo   - .git/ (historial de git) >> "%BACKUP_DIR%\BACKUP_INFO.txt"
echo. >> "%BACKUP_DIR%\BACKUP_INFO.txt"
echo REQUISITOS PARA RESTAURAR: >> "%BACKUP_DIR%\BACKUP_INFO.txt"
echo   - Windows 7 o superior >> "%BACKUP_DIR%\BACKUP_INFO.txt"
echo   - Node.js 18 o superior instalado >> "%BACKUP_DIR%\BACKUP_INFO.txt"
echo   - Conexion a internet (para instalar dependencias) >> "%BACKUP_DIR%\BACKUP_INFO.txt"
echo. >> "%BACKUP_DIR%\BACKUP_INFO.txt"
echo INSTRUCCIONES: >> "%BACKUP_DIR%\BACKUP_INFO.txt"
echo   1. Copiar esta carpeta completa a la nueva maquina >> "%BACKUP_DIR%\BACKUP_INFO.txt"
echo   2. Hacer doble click en "Run Sonia App.bat" >> "%BACKUP_DIR%\BACKUP_INFO.txt"
echo   3. Esperar a que se instalen las dependencias >> "%BACKUP_DIR%\BACKUP_INFO.txt"
echo   4. La aplicacion se abrira automaticamente en el navegador >> "%BACKUP_DIR%\BACKUP_INFO.txt"
echo. >> "%BACKUP_DIR%\BACKUP_INFO.txt"
echo Para mas detalles, ver: INSTRUCCIONES_RESTAURACION.md >> "%BACKUP_DIR%\BACKUP_INFO.txt"

REM Copiar las instrucciones de restauracion
copy "%SOURCE_DIR%GUIA_BACKUP_DATOS.md" "%BACKUP_DIR%\INSTRUCCIONES_RESTAURACION.md" > nul

echo   OK BACKUP_INFO.txt creado
echo   OK INSTRUCCIONES_RESTAURACION.md copiado

echo.
echo [5/5] Finalizando backup...
echo.

REM Calcular tamaño del backup
for /f "tokens=3" %%A in ('dir "%BACKUP_DIR%" /s /-c 2^>nul ^| find "bytes"') do set BACKUP_SIZE=%%A

REM Mostrar resumen
echo ==========================================
echo   BACKUP COMPLETADO EXITOSAMENTE
echo ==========================================
echo.
echo Ubicacion: %BACKUP_DIR%
echo.
echo RESUMEN:
echo   - Codigo fuente: OK Copiado
echo   - Imagenes de productos: !UPLOAD_COUNT! archivos
echo   - Scripts de inicio: OK Incluidos
echo   - Documentacion: OK Generada
echo.
if defined BACKUP_SIZE (
    echo TAMANO TOTAL: %BACKUP_SIZE% bytes
) else (
    echo TAMANO TOTAL: Calculando...
)
echo.
echo ==========================================
echo.
echo SIGUIENTE PASO:
echo   1. Copia la carpeta "%BACKUP_NAME%"
echo   2. Pegala en una USB o en otra ubicacion
echo   3. En la nueva maquina, ejecuta "Run Sonia App.bat"
echo.
echo Para mas detalles, abre:
echo   %BACKUP_DIR%\INSTRUCCIONES_RESTAURACION.md
echo.
echo ==========================================

REM Abrir la carpeta del backup
explorer "%BACKUP_DIR%"

echo.
echo Presiona cualquier tecla para cerrar...
pause > nul
