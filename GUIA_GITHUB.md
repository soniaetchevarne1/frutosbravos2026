# 🚀 Guía Completa: Sincronizar SONIA APP con GitHub

## 📋 Pasos para Subir tu Proyecto a GitHub

### Paso 1: Instalar Git

**Git no está instalado en tu sistema.** Necesitas instalarlo primero:

#### Opción A: Instalación Automática (Recomendado)

1. **Descargar Git**:
   - Ve a: https://git-scm.com/download/win
   - Se descargará automáticamente el instalador

2. **Ejecutar el instalador**:
   - Doble click en el archivo descargado
   - Click en "Next" en todas las pantallas (configuración por defecto está bien)
   - **IMPORTANTE**: En la pantalla "Adjusting your PATH environment", selecciona "Git from the command line and also from 3rd-party software"
   - Click "Install"
   - Click "Finish"

3. **Verificar instalación**:
   - Abre una nueva ventana de PowerShell
   - Escribe: `git --version`
   - Deberías ver algo como: `git version 2.43.0`

#### Opción B: Instalación con winget (Windows 11)

```powershell
winget install --id Git.Git -e --source winget
```

---

### Paso 2: Configurar Git (Primera Vez)

Después de instalar Git, configura tu identidad:

```powershell
# Configurar tu nombre
git config --global user.name "Tu Nombre"

# Configurar tu email (usa el mismo de GitHub)
git config --global user.email "tu-email@ejemplo.com"

# Verificar configuración
git config --global --list
```

**Ejemplo**:
```powershell
git config --global user.name "Maria Martinez"
git config --global user.email "maria@ejemplo.com"
```

---

### Paso 3: Crear Cuenta en GitHub (si no tienes)

1. Ve a: https://github.com/
2. Click en "Sign up"
3. Ingresa tu email, contraseña y nombre de usuario
4. Verifica tu email
5. ¡Listo!

---

### Paso 4: Crear Repositorio en GitHub

1. **Inicia sesión** en GitHub
2. Click en el **botón "+"** (arriba derecha) → "New repository"
3. **Configurar el repositorio**:
   - **Repository name**: `sonia-app-fruto-bravo` (o el nombre que prefieras)
   - **Description**: "Tienda online de frutos secos - Fruto Bravo"
   - **Visibilidad**: 
     - ✅ **Private** (recomendado para proyectos personales)
     - ⚪ Public (si quieres que sea público)
   - ❌ **NO** marques "Add a README file"
   - ❌ **NO** agregues .gitignore ni licencia (ya los tienes)
4. Click en **"Create repository"**
5. **Guarda la URL** que aparece (algo como: `https://github.com/tu-usuario/sonia-app-fruto-bravo.git`)

---

### Paso 5: Preparar tu Proyecto Local

#### 5.1. Crear archivo .gitignore

Tu proyecto ya debería tener un `.gitignore`, pero vamos a verificarlo:

**Ubicación**: `C:\Users\marma\OneDrive\Escritorio\SONIA APP\web\.gitignore`

**Contenido necesario**:
```
# Dependencies
node_modules/
/.pnp
.pnp.js

# Testing
/coverage

# Next.js
/.next/
/out/

# Production
/build

# Misc
.DS_Store
*.pem

# Debug
npm-debug.log*
yarn-debug.log*
yarn-error.log*

# Local env files
.env*.local
.env

# Vercel
.vercel

# TypeScript
*.tsbuildinfo
next-env.d.ts

# Backups (NO subir backups a GitHub)
SONIA_APP_PORTABLE_BACKUP_*/
BACKUPS/
```

#### 5.2. Crear archivo README.md

Crea un archivo `README.md` en la raíz de tu proyecto con información básica:

**Ubicación**: `C:\Users\marma\OneDrive\Escritorio\SONIA APP\web\README.md`

**Contenido sugerido**:
```markdown
# 🥜 Fruto Bravo - Tienda Online

Tienda online de frutos secos, especias y harinas premium.

## 🚀 Características

- ✅ Catálogo de productos con imágenes
- ✅ Panel de administración
- ✅ Diseño responsive y moderno
- ✅ Mascota animada (nuez musculosa)
- ✅ Venta minorista y mayorista

## 🛠️ Tecnologías

- Next.js 15
- React 19
- TypeScript
- CSS Modules

## 📦 Instalación

\`\`\`bash
npm install
npm run dev
\`\`\`

Abre [http://localhost:3000](http://localhost:3000) en tu navegador.

## 📝 Scripts

- `npm run dev` - Servidor de desarrollo
- `npm run build` - Build de producción
- `npm start` - Servidor de producción

## 📄 Licencia

Privado - Todos los derechos reservados
```

---

### Paso 6: Inicializar Git en tu Proyecto

Abre PowerShell en la carpeta de tu proyecto:

```powershell
# Navegar a la carpeta web
cd "C:\Users\marma\OneDrive\Escritorio\SONIA APP\web"

# Inicializar repositorio Git
git init

# Verificar estado
git status
```

Deberías ver una lista de archivos sin seguimiento (untracked files).

---

### Paso 7: Hacer el Primer Commit

```powershell
# Agregar todos los archivos al staging area
git add .

# Verificar qué se agregó
git status

# Crear el primer commit
git commit -m "Initial commit: SONIA APP - Fruto Bravo"
```

**Nota**: Si ves muchos archivos, es normal. Git está agregando todo tu código.

---

### Paso 8: Conectar con GitHub

Reemplaza `TU-USUARIO` y `TU-REPOSITORIO` con tus datos:

```powershell
# Agregar el repositorio remoto
git remote add origin https://github.com/TU-USUARIO/TU-REPOSITORIO.git

# Verificar que se agregó correctamente
git remote -v

# Cambiar a la rama main (GitHub usa 'main' por defecto)
git branch -M main
```

---

### Paso 9: Subir tu Código a GitHub

```powershell
# Subir tu código por primera vez
git push -u origin main
```

**Importante**: Te pedirá autenticación. Tienes dos opciones:

#### Opción A: Personal Access Token (Recomendado)

1. Ve a GitHub → Settings → Developer settings → Personal access tokens → Tokens (classic)
2. Click "Generate new token (classic)"
3. Nombre: "SONIA APP"
4. Selecciona: `repo` (todos los permisos de repositorio)
5. Click "Generate token"
6. **COPIA EL TOKEN** (solo se muestra una vez)
7. Cuando Git pida contraseña, pega el token

#### Opción B: GitHub Desktop (Más Fácil)

1. Descarga GitHub Desktop: https://desktop.github.com/
2. Instala y abre
3. File → Add local repository
4. Selecciona: `C:\Users\marma\OneDrive\Escritorio\SONIA APP\web`
5. Click "Publish repository"
6. ¡Listo!

---

### Paso 10: Verificar en GitHub

1. Ve a tu repositorio en GitHub
2. Deberías ver todos tus archivos
3. ✅ ¡Tu código está en GitHub!

---

## 🔄 Flujo de Trabajo Diario

Una vez configurado, cada vez que hagas cambios:

```powershell
# 1. Ver qué cambió
git status

# 2. Agregar cambios
git add .

# 3. Hacer commit con mensaje descriptivo
git commit -m "Descripción de los cambios"

# 4. Subir a GitHub
git push
```

**Ejemplo**:
```powershell
git add .
git commit -m "Agregado nuevo diseño creativo al hero"
git push
```

---

## 📝 Comandos Git Útiles

### Ver Historial
```powershell
git log --oneline
```

### Ver Diferencias
```powershell
git diff
```

### Deshacer Cambios (antes de commit)
```powershell
git checkout -- archivo.txt
```

### Ver Ramas
```powershell
git branch
```

### Crear Nueva Rama
```powershell
git checkout -b nombre-rama
```

### Cambiar de Rama
```powershell
git checkout main
```

---

## 🚨 Problemas Comunes

### "Git no se reconoce como comando"
**Solución**: Reinicia PowerShell después de instalar Git.

### "Permission denied (publickey)"
**Solución**: Usa HTTPS en lugar de SSH, o configura SSH keys.

### "Failed to push some refs"
**Solución**: 
```powershell
git pull origin main --rebase
git push
```

### "Merge conflict"
**Solución**: Edita los archivos en conflicto, luego:
```powershell
git add .
git commit -m "Resolved merge conflict"
git push
```

---

## 🔒 Seguridad: Archivos a NO Subir

**NUNCA subas**:
- ❌ `node_modules/` (ya está en .gitignore)
- ❌ `.env` con contraseñas o API keys
- ❌ Archivos de backup grandes
- ❌ Información personal sensible

**Siempre verifica** con `git status` antes de hacer commit.

---

## 📚 Recursos Adicionales

- **Documentación Git**: https://git-scm.com/doc
- **GitHub Guides**: https://guides.github.com/
- **Git Cheat Sheet**: https://education.github.com/git-cheat-sheet-education.pdf
- **GitHub Desktop**: https://desktop.github.com/

---

## ✅ Checklist de Configuración

- [ ] Git instalado y verificado (`git --version`)
- [ ] Git configurado (nombre y email)
- [ ] Cuenta de GitHub creada
- [ ] Repositorio creado en GitHub
- [ ] `.gitignore` configurado
- [ ] `README.md` creado
- [ ] Repositorio inicializado (`git init`)
- [ ] Primer commit realizado
- [ ] Conectado con GitHub (`git remote add origin`)
- [ ] Código subido (`git push`)
- [ ] Verificado en GitHub

---

## 🎯 Resumen Rápido

```powershell
# 1. Instalar Git (solo una vez)
# Descargar de: https://git-scm.com/download/win

# 2. Configurar Git (solo una vez)
git config --global user.name "Tu Nombre"
git config --global user.email "tu-email@ejemplo.com"

# 3. Crear repositorio en GitHub (solo una vez)
# https://github.com/new

# 4. Inicializar y subir (solo una vez)
cd "C:\Users\marma\OneDrive\Escritorio\SONIA APP\web"
git init
git add .
git commit -m "Initial commit"
git remote add origin https://github.com/TU-USUARIO/TU-REPO.git
git branch -M main
git push -u origin main

# 5. Flujo diario (cada vez que hagas cambios)
git add .
git commit -m "Descripción del cambio"
git push
```

---

**¡Listo!** Ahora tu código estará sincronizado con GitHub y tendrás un respaldo en la nube. 🎉
