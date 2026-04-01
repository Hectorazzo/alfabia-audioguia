# Guía rápida — Primeros pasos con Claude Code
## Audioguía Digital Plus · Jardines de Alfabia

---

## Requisitos previos

1. **Node.js** v18+ instalado
2. **Claude Code** instalado: `npm install -g @anthropic-ai/claude-code` (o método actualizado — consultar docs)
3. **Cuenta Supabase** creada (supabase.com, free tier)
4. **Repositorio GitHub** creado (privado, vacío)

---

## Paso 0: Scaffold del proyecto

```bash
# Dar permisos y ejecutar
chmod +x setup-alfabia.sh
./setup-alfabia.sh

# Entrar al proyecto
cd alfabia-audioguia

# Copiar el archivo de instrucciones
cp ../CLAUDE.md .

# Conectar con GitHub
git remote add origin git@github.com:punk-solutions/alfabia-audioguia.git
git push -u origin dev
git push -u origin main
```

---

## Paso 1: Abrir Claude Code

```bash
cd alfabia-audioguia
claude
```

Claude Code leerá automáticamente el `CLAUDE.md` y tendrá todo el contexto del proyecto.

---

## Primeros 10 prompts (en orden)

### Prompt 1 — Configuración base
```
Lee CLAUDE.md. Configura tailwind.config.ts con los colores de marca de Alfabia 
(green #233B29, cream #F8F2E7) y la tipografía Teodor como font-display serif. 
Configura los path aliases en vite.config.ts y tsconfig.json para usar @/ como 
alias de src/. Actualiza src/index.css con los imports de Tailwind y las CSS 
custom properties de la marca.
```

### Prompt 2 — Supabase client
```
Configura el cliente Supabase en src/services/supabase.ts. Lee las variables de 
entorno VITE_SUPABASE_URL y VITE_SUPABASE_ANON_KEY desde .env.local. Crea un 
archivo .env.example con placeholders. Añade .env.local al .gitignore.
```

### Prompt 3 — Zustand stores
```
Implementa los 3 stores de Zustand según CLAUDE.md: useAppStore.ts, 
useProgressStore.ts (persistido en localStorage como 'alfabia-progress'), y 
useOfflineStore.ts (persistido como 'alfabia-offline'). Usa el middleware 
persist de Zustand. Tipado estricto TypeScript.
```

### Prompt 4 — Routing y AppShell
```
Configura React Router en App.tsx con las 6 rutas: /, /language, /home, 
/poi/:id, /map, /closing. Implementa AppShell.tsx como layout wrapper con 
BottomNav.tsx (3 iconos: Home, Map, Settings usando lucide-react). El BottomNav 
no debe mostrarse en SplashPage ni LanguagePage.
```

### Prompt 5 — SplashPage y LanguagePage
```
Implementa SplashPage.tsx: logo de Alfabia centrado (usa un placeholder SVG 
con la "A" por ahora), animación fade-in, auto-redirect a /language tras 2 
segundos. Implementa LanguagePage.tsx: detectar idioma del navegador con 
navigator.language, mostrar 5 botones (Español, English, Deutsch, Català, 
Français), guardar selección en useAppStore, redirigir a /home. Estilo elegante 
con los colores de marca.
```

### Prompt 6 — POI service y tipos
```
Crea los tipos TypeScript en src/lib/types.ts para POI y Translation según el 
schema de Supabase en CLAUDE.md. Implementa poiService.ts con funciones: 
getAllPOIs(), getPOIById(id), getTranslation(poiId, language). Incluye manejo 
de errores y tipado de retorno.
```

### Prompt 7 — HomePage con tabs
```
Implementa HomePage.tsx con dos pestañas: "Cerca de mí" y "Ver todos". La 
pestaña "Ver todos" muestra POIList.tsx con todas las POICards ordenadas por 
sort_order. Cada POICard.tsx muestra: número, título (en idioma activo), 
duración, badges de escuchado (check verde) y favorito (corazón). Incluye un 
botón "Descargar audios" fijo en la parte inferior. Usa datos de Supabase.
```

### Prompt 8 — Haversine y ProximityEngine
```
Implementa haversine.ts con la fórmula de distancia según CLAUDE.md. 
Implementa ProximityEngine.ts que: recibe posición del usuario y lista de POIs, 
calcula distancia a cada uno, filtra los que están dentro de su 
activation_radius_m, los ordena por cercanía, y para POI 8 (is_bifurcation=true) 
devuelve ambos bifurcation_targets como sugerencias simultáneas. Implementa 
useProximity.ts como hook que usa el engine.
```

### Prompt 9 — useGeolocation hook
```
Implementa useGeolocation.ts: usa navigator.geolocation.watchPosition con las 
opciones de CLAUDE.md (enableHighAccuracy, maximumAge 5000, timeout 15000). 
Expón: position, error, accuracy, permissionState. Limpia el watcher al 
desmontar. Implementa PermissionHandler.tsx con el flujo de pre-permiso descrito 
en CLAUDE.md (pantalla propia antes del prompt nativo del navegador).
```

### Prompt 10 — AudioPlayer
```
Implementa AudioPlayer.tsx: reproduce audio desde URL (streaming por defecto). 
Controles: play/pause toggle, barra de progreso con seek, indicador de tiempo 
actual/total, botón de favorito. Detecta soporte de OGG/Opus con canPlayType(), 
fallback a MP3. Muestra spinner durante buffering. Cuando el audio termina, 
llama a markAsListened() del useProgressStore. Diseño limpio con colores Alfabia.
```

---

## Después de cada prompt

1. Revisa el código generado
2. Ejecuta `npm run dev` para verificar
3. Si todo OK: `git add . && git commit -m "feat: [descripción]" && git push`
4. Si hay errores: dile a Claude Code qué falla y que lo corrija

---

## Regla de oro

**Nunca acumules más de 2-3 cambios sin commitear.** Si Claude Code rompe algo, 
puedes revertir con `git checkout -- .` y volver al último commit estable.

---

## Recursos

- CLAUDE.md → Especificación técnica completa
- Roadmap_Protocolo_Audioguia_Alfabia.docx → Roadmap y protocolo de desarrollo
- Manual de identidad → Colores, tipografía, logotipo
- Guion R3 → Textos de los 18 audios en español
