# 📚 Guía Completa de Backup de Datos - SONIA APP

## 🎯 Introducción

Esta guía te explica **dónde están todos tus datos** en SONIA APP y **cómo hacer backup** de cada tipo de dato.

---

## 📊 Tipos de Datos en SONIA APP

### 1. 🖼️ Imágenes de Productos (DATOS PRINCIPALES)

**Ubicación**: `web/public/uploads/`

**Descripción**: Todas las imágenes de productos que has subido desde el panel de administración.

**Cantidad actual**: 13 archivos

**Archivos incluidos**:
- Nueces, pasas de uva, ciruelas
- Orejones, dátiles, banana chips
- Tomates secos, pistachos
- Mix tropical, mix europeo
- Imágenes de recetas

#### 🔄 Cómo hacer backup manual:

```cmd
# Opción 1: Copiar carpeta completa
xcopy "C:\Users\marma\OneDrive\Escritorio\SONIA APP\web\public\uploads" "D:\Backup\uploads\" /E /I /Y

# Opción 2: Comprimir en ZIP
# Click derecho en la carpeta uploads > Enviar a > Carpeta comprimida
```

#### 📥 Cómo restaurar:

1. Copia la carpeta `uploads` completa
2. Pégala en `web/public/uploads/` de tu nueva instalación
3. Reinicia la aplicación

---

### 2. 🎨 Assets Estáticos

**Ubicación**: `web/public/`

**Archivos importantes**:
- `logo-fruto-bravo.png` - Logo de la marca
- `walnut-mascot.png` - Mascota (nuez musculosa)
- `background-pattern.png` - Patrón de fondo
- `placeholder/` - Imágenes de ejemplo para productos

#### 🔄 Cómo hacer backup:

```cmd
# Copiar todos los assets públicos
xcopy "C:\Users\marma\OneDrive\Escritorio\SONIA APP\web\public" "D:\Backup\public\" /E /I /Y
```

---

### 3. 💻 Código Fuente

**Ubicación**: `web/src/`

**Contenido**:
- Componentes React (Navbar, Footer, Mascot, etc.)
- Páginas (Home, Tienda, Admin, etc.)
- Estilos CSS
- Configuración de la aplicación

#### 🔄 Cómo hacer backup:

El script `CREAR_BACKUP_PORTABLE.bat` ya incluye todo el código fuente.

Para backup manual:
```cmd
xcopy "C:\Users\marma\OneDrive\Escritorio\SONIA APP\web\src" "D:\Backup\src\" /E /I /Y
```

---

### 4. ⚙️ Configuración

**Archivos de configuración**:
- `web/package.json` - Dependencias de Node.js
- `web/tsconfig.json` - Configuración de TypeScript
- `web/next.config.ts` - Configuración de Next.js

#### 🔄 Cómo hacer backup:

Estos archivos están incluidos en el backup portable automático.

---

### 5. 🗄️ Base de Datos (Futuro)

**Estado actual**: No se detectó base de datos

**Si agregas una base de datos en el futuro**:

#### Para SQLite:
```cmd
# Copiar archivo .db
copy "web\database.db" "D:\Backup\database.db"
```

#### Para MySQL/PostgreSQL:
```cmd
# Exportar dump
mysqldump -u usuario -p nombre_db > backup.sql

# Restaurar
mysql -u usuario -p nombre_db < backup.sql
```

---

## 🔄 Estrategias de Backup

### 📅 Backup Diario Automático

Puedes programar el script de backup para que se ejecute automáticamente:

1. Abre **Programador de tareas** de Windows
2. Crear tarea básica
3. Nombre: "Backup SONIA APP"
4. Desencadenador: Diariamente a las 23:00
5. Acción: Ejecutar `CREAR_BACKUP_PORTABLE.bat`

### ☁️ Backup en la Nube

#### Opción 1: OneDrive (Ya lo tienes)

Tu aplicación ya está en OneDrive:
```
C:\Users\marma\OneDrive\Escritorio\SONIA APP
```

**Ventajas**:
- ✅ Sincronización automática
- ✅ Acceso desde cualquier dispositivo
- ✅ Historial de versiones

**Importante**: OneDrive sincroniza todo EXCEPTO `node_modules` y `.next` (que es correcto).

#### Opción 2: Google Drive

1. Instala Google Drive Desktop
2. Copia la carpeta de backup a Google Drive
3. Se sincronizará automáticamente

#### Opción 3: Dropbox

Similar a Google Drive.

### 💾 Backup en Disco Externo

**Recomendado para backups importantes**:

1. Conecta USB o disco externo
2. Ejecuta `CREAR_BACKUP_PORTABLE.bat`
3. Copia la carpeta generada al disco externo
4. Guarda en lugar seguro

---

## 📋 Checklist de Backup Completo

Antes de hacer cambios importantes, verifica:

- [ ] Ejecutar `CREAR_BACKUP_PORTABLE.bat`
- [ ] Verificar que la carpeta `uploads` está incluida
- [ ] Verificar cantidad de imágenes (debe ser 13 o más)
- [ ] Copiar backup a ubicación segura (USB, nube, etc.)
- [ ] Probar restauración en carpeta temporal
- [ ] Verificar que las imágenes se ven correctamente

---

## 🚨 Backup de Emergencia Rápido

Si necesitas hacer un backup rápido de solo los datos:

```cmd
@echo off
set TIMESTAMP=%date:~-4%%date:~3,2%%date:~0,2%_%time:~0,2%%time:~3,2%
set BACKUP_DIR=C:\Backup_Emergencia_%TIMESTAMP%

mkdir "%BACKUP_DIR%"
xcopy "C:\Users\marma\OneDrive\Escritorio\SONIA APP\web\public\uploads" "%BACKUP_DIR%\uploads\" /E /I /Y
xcopy "C:\Users\marma\OneDrive\Escritorio\SONIA APP\web\src" "%BACKUP_DIR%\src\" /E /I /Y

echo Backup de emergencia completado en: %BACKUP_DIR%
pause
```

Guarda esto como `BACKUP_EMERGENCIA.bat`

---

## 📊 Tamaños Aproximados

Para planificar tu espacio de almacenamiento:

| Componente | Tamaño Aprox. |
|------------|---------------|
| Imágenes uploads | ~1.7 MB |
| Código fuente | ~500 KB |
| Assets públicos | ~1.5 MB |
| Configuración | ~50 KB |
| **Total (sin node_modules)** | **~3.7 MB** |
| node_modules (si incluyes) | ~200-300 MB |

**Conclusión**: El backup portable (sin node_modules) es muy ligero (~4 MB).

---

## 🔍 Verificar Integridad del Backup

Después de crear un backup, verifica:

### 1. Verificar archivos de imágenes:

```cmd
dir "SONIA_APP_PORTABLE_BACKUP_*\web\public\uploads" /b
```

Debe mostrar 13 archivos (o más si has agregado).

### 2. Verificar estructura:

```cmd
tree "SONIA_APP_PORTABLE_BACKUP_*" /F
```

Debe mostrar toda la estructura de carpetas.

### 3. Verificar tamaño:

```cmd
dir "SONIA_APP_PORTABLE_BACKUP_*" /s
```

Debe mostrar el tamaño total (~3-4 MB sin node_modules).

---

## 💡 Mejores Prácticas

### ✅ DO (Hacer):

- ✅ Hacer backup ANTES de actualizar código
- ✅ Hacer backup DESPUÉS de agregar muchos productos
- ✅ Guardar backups en múltiples ubicaciones
- ✅ Probar la restauración periódicamente
- ✅ Documentar cambios importantes

### ❌ DON'T (No hacer):

- ❌ Confiar en un solo backup
- ❌ Guardar backups solo en la misma computadora
- ❌ Olvidar hacer backup de las imágenes
- ❌ Incluir `node_modules` en backups (se regenera)
- ❌ Sobrescribir backups antiguos sin verificar

---

## 🎯 Resumen Rápido

### Para backup completo portable:
```
1. Ejecutar: CREAR_BACKUP_PORTABLE.bat
2. Copiar carpeta generada a lugar seguro
3. Listo!
```

### Para backup solo de imágenes:
```
1. Copiar: web\public\uploads\
2. Pegar en lugar seguro
3. Listo!
```

### Para restaurar:
```
1. Copiar carpeta de backup
2. Ejecutar: Run Sonia App.bat
3. Esperar instalación de dependencias
4. Listo!
```

---

## 📞 Preguntas Frecuentes

**P: ¿Debo incluir node_modules en el backup?**  
R: No, se regenera automáticamente con `npm install`.

**P: ¿Con qué frecuencia debo hacer backup?**  
R: Después de cambios importantes o agregar productos nuevos.

**P: ¿Dónde guardo los backups?**  
R: En múltiples lugares: USB, nube (OneDrive/Google Drive), disco externo.

**P: ¿Puedo automatizar los backups?**  
R: Sí, usando el Programador de tareas de Windows.

**P: ¿Qué pasa si pierdo las imágenes?**  
R: Por eso es importante hacer backups regulares. Sin backup, se pierden.

---

**Última actualización**: 27 de Enero de 2026  
**Versión**: SONIA APP - Fruto Bravo v1.0
