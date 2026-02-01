@echo off
chcp 65001 >nul
echo ==========================================
echo   COMPRIMIR BACKUP PARA TRANSPORTE
echo ==========================================
echo.
echo Este script te ayudará a comprimir el backup
echo para que sea más fácil de transportar.
echo.
echo OPCIONES:
echo.
echo 1. COMPRIMIR CON WINDOWS (ZIP)
echo    - Haz clic derecho en la carpeta del backup
echo    - Selecciona "Enviar a" ^> "Carpeta comprimida"
echo    - Espera a que se cree el archivo .zip
echo.
echo 2. USAR 7-ZIP (Mejor compresión)
echo    - Descarga 7-Zip de: https://www.7-zip.org/
echo    - Instálalo
echo    - Haz clic derecho en la carpeta del backup
echo    - Selecciona "7-Zip" ^> "Añadir al archivo..."
echo    - Elige formato .7z para mejor compresión
echo.
echo 3. USAR WINRAR
echo    - Descarga WinRAR de: https://www.winrar.es/
echo    - Instálalo
echo    - Haz clic derecho en la carpeta del backup
echo    - Selecciona "Añadir al archivo..."
echo.
echo ==========================================
echo   TAMAÑOS ESTIMADOS DESPUÉS DE COMPRIMIR
echo ==========================================
echo.
echo Tamaño original: ~866 MB
echo.
echo Con ZIP (Windows):    ~400-500 MB
echo Con 7-Zip (.7z):      ~300-400 MB
echo Con RAR:              ~350-450 MB
echo.
echo ==========================================
echo   RECOMENDACIONES
echo ==========================================
echo.
echo 1. Si vas a subir a la nube: Usa 7-Zip (.7z)
echo    - Menor tamaño
echo    - Más rápido de subir
echo.
echo 2. Si vas a enviar por email: Usa ZIP
echo    - Compatible con todos los sistemas
echo    - No requiere software adicional
echo.
echo 3. Si vas a copiar a USB: No comprimas
echo    - Más rápido de copiar
echo    - Fácil de restaurar
echo.
echo ==========================================
echo.
echo ¿Quieres que Windows abra la carpeta del backup?
echo Presiona cualquier tecla para abrir...
echo.
pause >nul

explorer "%~dp0SONIA_APP_BACKUP_COMPLETO_2026-01-30_14-34-12"

echo.
echo ¡Listo! Ahora puedes comprimir la carpeta.
echo.
pause
