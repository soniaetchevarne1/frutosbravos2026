# ============================================
# SCRIPT PARA SUBIR SONIA APP A GITHUB
# ============================================
# 
# INSTRUCCIONES:
# 1. Abre una NUEVA ventana de PowerShell
# 2. Copia TODO este archivo (Ctrl+A, Ctrl+C)
# 3. Pega en PowerShell (Click derecho)
# 4. Presiona Enter
# 5. Sigue las instrucciones
#
# ============================================

Write-Host "=========================================="
Write-Host "  SUBIR SONIA APP A GITHUB"
Write-Host "=========================================="
Write-Host ""

# Verificar Git
Write-Host "Verificando Git..." -ForegroundColor Yellow
try {
    $gitVersion = git --version
    Write-Host "[OK] $gitVersion" -ForegroundColor Green
} catch {
    Write-Host "[ERROR] Git no esta instalado o no esta disponible" -ForegroundColor Red
    Write-Host "Por favor cierra PowerShell y abre una NUEVA ventana" -ForegroundColor Yellow
    exit
}

Write-Host ""

# Configurar Git (si es necesario)
Write-Host "Configurando Git..." -ForegroundColor Yellow
$gitUser = git config --global user.name
if (-not $gitUser) {
    $nombre = Read-Host "Ingresa tu nombre"
    $email = Read-Host "Ingresa tu email"
    git config --global user.name "$nombre"
    git config --global user.email "$email"
    Write-Host "[OK] Git configurado" -ForegroundColor Green
} else {
    Write-Host "[OK] Git ya configurado como: $gitUser" -ForegroundColor Green
}

Write-Host ""

# Navegar a la carpeta del proyecto
Write-Host "Navegando al proyecto..." -ForegroundColor Yellow
cd "C:\Users\marma\OneDrive\Escritorio\SONIA APP\web"
Write-Host "[OK] En carpeta: $(Get-Location)" -ForegroundColor Green

Write-Host ""

# Inicializar Git
Write-Host "Inicializando repositorio Git..." -ForegroundColor Yellow
if (Test-Path ".git") {
    Write-Host "[OK] Repositorio Git ya existe" -ForegroundColor Green
} else {
    git init
    git branch -M main
    Write-Host "[OK] Repositorio inicializado" -ForegroundColor Green
}

Write-Host ""

# Agregar archivos
Write-Host "Agregando archivos..." -ForegroundColor Yellow
git add .
Write-Host "[OK] Archivos agregados" -ForegroundColor Green

Write-Host ""

# Crear commit
Write-Host "Creando commit..." -ForegroundColor Yellow
$commitMsg = Read-Host "Mensaje del commit (Enter para usar mensaje por defecto)"
if (-not $commitMsg) {
    $commitMsg = "Initial commit: SONIA APP - Fruto Bravo"
}
git commit -m "$commitMsg"
Write-Host "[OK] Commit creado" -ForegroundColor Green

Write-Host ""

# Configurar remote
Write-Host "Configurando repositorio remoto..." -ForegroundColor Yellow
try {
    $existingRemote = git remote get-url origin 2>$null
    Write-Host "[OK] Remote ya configurado: $existingRemote" -ForegroundColor Green
} catch {
    Write-Host ""
    Write-Host "Necesitas la URL de tu repositorio de GitHub" -ForegroundColor Cyan
    Write-Host "Ejemplo: https://github.com/tu-usuario/sonia-app-fruto-bravo.git" -ForegroundColor Gray
    Write-Host ""
    $repoUrl = Read-Host "Pega la URL del repositorio"
    git remote add origin $repoUrl
    Write-Host "[OK] Remote configurado" -ForegroundColor Green
}

Write-Host ""

# Subir a GitHub
Write-Host "=========================================="
Write-Host "  SUBIENDO CODIGO A GITHUB"
Write-Host "=========================================="
Write-Host ""
Write-Host "IMPORTANTE: Cuando pida autenticacion:" -ForegroundColor Yellow
Write-Host "  - Username: tu usuario de GitHub" -ForegroundColor Cyan
Write-Host "  - Password: PEGA TU TOKEN (no tu contrasena)" -ForegroundColor Cyan
Write-Host ""
Write-Host "Presiona Enter para continuar..."
Read-Host

git push -u origin main

if ($LASTEXITCODE -eq 0) {
    Write-Host ""
    Write-Host "=========================================="
    Write-Host "  EXITO! CODIGO SUBIDO A GITHUB"
    Write-Host "=========================================="
    Write-Host ""
    Write-Host "Tu codigo ahora esta en GitHub!" -ForegroundColor Green
    Write-Host ""
    Write-Host "Proximos pasos:" -ForegroundColor Yellow
    Write-Host "1. Ve a tu repositorio en GitHub para verificar"
    Write-Host "2. Cada vez que hagas cambios, ejecuta:"
    Write-Host "   git add ."
    Write-Host "   git commit -m 'descripcion del cambio'"
    Write-Host "   git push"
    Write-Host ""
} else {
    Write-Host ""
    Write-Host "[ERROR] Hubo un problema al subir el codigo" -ForegroundColor Red
    Write-Host ""
    Write-Host "Posibles soluciones:" -ForegroundColor Yellow
    Write-Host "1. Verifica tu conexion a internet"
    Write-Host "2. Verifica que el repositorio existe en GitHub"
    Write-Host "3. Verifica que el token tiene permisos de 'repo'"
    Write-Host "4. Si dice 'failed to push', ejecuta:"
    Write-Host "   git pull origin main --rebase"
    Write-Host "   git push -u origin main"
    Write-Host ""
}

Write-Host "Presiona Enter para cerrar..."
Read-Host
