@echo off
echo ==========================================
echo       Opening SONIA APP Admin...
echo ==========================================

cd web

echo.
echo [1/3] Checking dependencies...
if not exist node_modules (
    echo Installing dependencies... This might take a minute.
    call npm install
) else (
    echo Dependencies already installed.
)

echo.
echo [2/3] Opening Admin Panel...
start "" "http://localhost:3000/admin"

echo.
echo [3/3] Starting Development Server...
echo Press Ctrl+C to stop the server.
echo.
npm run dev

pause
