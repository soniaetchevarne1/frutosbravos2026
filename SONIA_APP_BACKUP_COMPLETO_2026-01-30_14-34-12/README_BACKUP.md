# 📦 BACKUP COMPLETO PORTABLE - SONIA APP

**Fecha de creación:** 30 de Enero de 2026  
**Versión:** Backup Completo Portable

---

## ✅ CONTENIDO DEL BACKUP

Este backup incluye **TODO** lo necesario para ejecutar la aplicación SONIA APP en cualquier computadora:

### 📁 Archivos incluidos:
- ✅ **Código fuente completo** (`web/`)
  - Todos los componentes React/Next.js
  - Estilos CSS
  - Configuración del proyecto
  
- ✅ **Base de datos** (`web/src/data/db.json`)
  - Todos los productos
  - Todos los pedidos
  - Información de clientes
  
- ✅ **Imágenes de productos** (`web/public/uploads/`)
  - Todas las fotos de productos
  - Logos e imágenes del sitio
  
- ✅ **Scripts de inicio**
  - `Run Sonia App.bat` - Inicia la aplicación
  - `Run Sonia Admin.bat` - Abre el panel de administración
  - `SUBIR_A_GITHUB.bat` - Para subir cambios a GitHub
  
- ✅ **Documentación**
  - Guías de uso
  - Instrucciones de backup
  - Documentación de GitHub

---

## 🚀 CÓMO RESTAURAR EN OTRA COMPUTADORA

### Requisitos previos:
1. **Node.js** instalado (versión 18 o superior)
   - Descargar de: https://nodejs.org/
   
2. **Git** instalado (opcional, pero recomendado)
   - Descargar de: https://git-scm.com/

### Pasos para restaurar:

#### **Opción 1: Restauración Rápida (Recomendada)**

1. **Copia esta carpeta completa** a la ubicación deseada en la nueva computadora
   - Ejemplo: `C:\Users\TuUsuario\Escritorio\SONIA APP`

2. **Abre PowerShell o CMD** en la carpeta del backup

3. **Navega a la carpeta web:**
   ```bash
   cd web
   ```

4. **Instala las dependencias:**
   ```bash
   npm install
   ```
   ⏱️ Esto puede tardar 2-5 minutos

5. **Compila el proyecto:**
   ```bash
   npm run build
   ```
   ⏱️ Esto puede tardar 1-3 minutos

6. **¡Listo!** Ahora puedes usar los scripts de inicio:
   - Doble clic en `Run Sonia App.bat` para iniciar la app
   - Doble clic en `Run Sonia Admin.bat` para abrir el admin

---

#### **Opción 2: Restauración Manual**

Si los scripts .bat no funcionan en tu sistema:

1. Abre una terminal en la carpeta `web`

2. Instala dependencias:
   ```bash
   npm install
   ```

3. Compila el proyecto:
   ```bash
   npm run build
   ```

4. Inicia la aplicación:
   ```bash
   npm start
   ```

5. Abre tu navegador en:
   - **Tienda:** http://localhost:3000
   - **Admin:** http://localhost:3000/admin

---

## 💾 PORTABILIDAD

Este backup es **100% portable** y puede ser:

- ✅ Copiado a un **USB** o disco externo
- ✅ Subido a **Google Drive** / **OneDrive** / **Dropbox**
- ✅ Enviado por **email** (si comprimido en ZIP)
- ✅ Movido a **otra computadora**
- ✅ Usado como **backup de seguridad**

---

## 📊 VERIFICAR QUE TODO ESTÉ INCLUIDO

Después de restaurar, verifica que:

1. ✅ La carpeta `web/src/data/db.json` existe
2. ✅ La carpeta `web/public/uploads/` contiene tus imágenes
3. ✅ Los archivos `.bat` están presentes
4. ✅ La carpeta `web/node_modules/` se creó después de `npm install`

---

## 🔧 SOLUCIÓN DE PROBLEMAS

### Problema: "npm no se reconoce como comando"
**Solución:** Instala Node.js desde https://nodejs.org/

### Problema: "Error al compilar"
**Solución:** 
1. Borra la carpeta `web/node_modules`
2. Borra el archivo `web/package-lock.json`
3. Ejecuta `npm install` nuevamente

### Problema: "No se ven las imágenes"
**Solución:** Verifica que la carpeta `web/public/uploads/` tenga tus imágenes

### Problema: "No aparecen los productos"
**Solución:** Verifica que el archivo `web/src/data/db.json` exista y tenga contenido

---

## 📞 INFORMACIÓN ADICIONAL

### Estructura de carpetas importante:
```
SONIA_APP_BACKUP_COMPLETO/
├── web/                          # Código fuente
│   ├── src/
│   │   ├── app/                  # Páginas de la aplicación
│   │   ├── components/           # Componentes React
│   │   ├── data/
│   │   │   └── db.json          # ⭐ BASE DE DATOS
│   │   └── lib/                  # Utilidades
│   ├── public/
│   │   └── uploads/             # ⭐ IMÁGENES
│   ├── package.json
│   └── next.config.js
├── Run Sonia App.bat            # ⭐ Script de inicio
├── Run Sonia Admin.bat          # ⭐ Script admin
└── LEEME_PRIMERO.txt           # Este archivo

```

### Comandos útiles:
- `npm run dev` - Modo desarrollo (con hot reload)
- `npm run build` - Compilar para producción
- `npm start` - Iniciar en modo producción
- `npm run lint` - Verificar código

---

## ⚠️ IMPORTANTE

1. **Guarda este backup en un lugar seguro**
2. **Haz backups periódicos** de tu base de datos (`db.json`)
3. **No borres la carpeta `uploads/`** - contiene tus imágenes
4. **Mantén Node.js actualizado** para mejor rendimiento

---

## 🎉 ¡LISTO!

Tu aplicación SONIA APP está completamente respaldada y lista para ser restaurada en cualquier momento y en cualquier computadora.

**¿Necesitas ayuda?** Revisa los archivos de documentación incluidos:
- `GUIA_BACKUP_DATOS.md`
- `GUIA_GITHUB.md`

---

**Backup creado:** 30/01/2026  
**Versión de la app:** Latest  
**Estado:** ✅ Completo y verificado
