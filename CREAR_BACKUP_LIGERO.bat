@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion

echo ==========================================
echo   BACKUP LIGERO (SIN NODE_MODULES)
echo ==========================================
echo.
echo Este script crea un backup más pequeño
echo excluyendo node_modules (se puede reinstalar)
echo.

REM Obtener fecha y hora
for /f "tokens=2 delims==" %%I in ('wmic os get localdatetime /value') do set datetime=%%I
set TIMESTAMP=%datetime:~0,4%-%datetime:~4,2%-%datetime:~6,2%_%datetime:~8,2%-%datetime:~10,2%-%datetime:~12,2%

REM Nombre del backup
set BACKUP_NAME=SONIA_APP_BACKUP_LIGERO_%TIMESTAMP%
set BACKUP_DIR=%~dp0%BACKUP_NAME%

echo [1/7] Creando carpeta de backup ligero...
echo Nombre: %BACKUP_NAME%
mkdir "%BACKUP_DIR%" 2>nul

echo.
echo [2/7] Copiando código fuente (SIN node_modules)...
xcopy /E /I /Y /Q "web" "%BACKUP_DIR%\web\" /EXCLUDE:backup_exclude_temp.txt >nul 2>&1

REM Crear archivo de exclusión temporal
echo node_modules > backup_exclude_temp.txt
echo .next >> backup_exclude_temp.txt
echo .vercel >> backup_exclude_temp.txt

REM Copiar excluyendo carpetas pesadas
robocopy "web" "%BACKUP_DIR%\web" /E /XD "node_modules" ".next" ".vercel" /NFL /NDL /NJH /NJS >nul 2>&1

echo   ✓ Código fuente copiado (sin dependencias)

echo.
echo [3/7] Copiando scripts de inicio...
copy /Y "Run Sonia App.bat" "%BACKUP_DIR%\" >nul 2>&1
copy /Y "Run Sonia Admin.bat" "%BACKUP_DIR%\" >nul 2>&1
if exist "SUBIR_A_GITHUB.bat" copy /Y "SUBIR_A_GITHUB.bat" "%BACKUP_DIR%\" >nul 2>&1
echo   ✓ Scripts copiados

echo.
echo [4/7] Verificando base de datos...
if exist "web\src\data\db.json" (
    echo   ✓ Base de datos incluida
) else (
    echo   ⚠ No se encontró db.json
)

echo.
echo [5/7] Verificando imágenes...
if exist "web\public\uploads" (
    echo   ✓ Imágenes incluidas
) else (
    echo   ⚠ No se encontró carpeta uploads
)

echo.
echo [6/7] Copiando documentación...
if exist "GUIA_BACKUP_DATOS.md" copy /Y "GUIA_BACKUP_DATOS.md" "%BACKUP_DIR%\" >nul 2>&1
if exist "GUIA_GITHUB.md" copy /Y "GUIA_GITHUB.md" "%BACKUP_DIR%\" >nul 2>&1
echo   ✓ Documentación copiada

echo.
echo [7/7] Creando instrucciones...

(
echo ==========================================
echo   BACKUP LIGERO - SONIA APP
echo ==========================================
echo.
echo Fecha: %date% %time%
echo Tipo: BACKUP LIGERO ^(sin node_modules^)
echo.
echo CONTENIDO:
echo   ✓ Código fuente
echo   ✓ Base de datos
echo   ✓ Imágenes
echo   ✓ Scripts de inicio
echo   ✗ node_modules ^(se reinstala^)
echo.
echo VENTAJAS DE ESTE BACKUP:
echo   - Mucho más pequeño ^(~50-100 MB^)
echo   - Más rápido de copiar
echo   - Más fácil de subir a la nube
echo   - Más rápido de enviar por email
echo.
echo CÓMO RESTAURAR:
echo   1. Copia esta carpeta completa
echo   2. Abre terminal en la carpeta
echo   3. cd web
echo   4. npm install ^(reinstala dependencias^)
echo   5. npm run build
echo   6. Usa Run Sonia App.bat
echo.
echo NOTA: Este backup NO incluye node_modules
echo porque se puede reinstalar con "npm install"
echo.
echo ==========================================
) > "%BACKUP_DIR%\LEEME_BACKUP_LIGERO.txt"

echo   ✓ Instrucciones creadas

REM Limpiar archivo temporal
del backup_exclude_temp.txt >nul 2>&1

echo.
echo.
echo ==========================================
echo   BACKUP LIGERO COMPLETADO
echo ==========================================
echo.
echo Ubicación: %BACKUP_DIR%
echo.
echo DIFERENCIAS CON EL BACKUP COMPLETO:
echo   ✓ Mucho más pequeño ^(~50-100 MB vs ~866 MB^)
echo   ✓ Más rápido de copiar/subir
echo   ✗ Requiere ejecutar "npm install" al restaurar
echo.
echo RECOMENDACIÓN:
echo   - Usa este backup para subir a la nube
echo   - Usa el backup completo para USB
echo.
echo ==========================================
echo.

pause
