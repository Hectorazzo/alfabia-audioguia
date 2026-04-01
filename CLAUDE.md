# CLAUDE.md — Audioguía Digital Plus · Jardines de Alfabia

## Project overview

PWA audioguide for Jardines de Alfabia (Mallorca). 18 points of interest, 5 languages (ES, EN, DE, CAT, FR), proximity-based GPS navigation with free exploration (no predefined routes). Built by Punk Solutions.

Production URL: `guia.jardinesdealfabia.com` (pending CNAME setup)

## Tech stack

- **Framework**: React 18 + Vite + TypeScript
- **Styling**: Tailwind CSS 3 + shadcn/ui components
- **State management**: Zustand with localStorage persistence
- **Database**: Supabase (PostgreSQL + Storage for audio files)
- **Maps**: Leaflet or MapLibre GL JS (lightweight, offline-capable tiles optional)
- **Hosting**: Vercel (free tier)
- **Audio generation**: ElevenLabs (already produced)
- **Version control**: GitHub — `main` (protected, production) + `dev` (working branch)

## Brand identity (from official manual)

```
Primary colors:
  --alfabia-green: #233B29    (dark forest green — primary)
  --alfabia-cream: #F8F2E7    (warm cream — background)

Extended palette (derive from primary):
  --alfabia-green-light: #2E4D36   (hover states)
  --alfabia-green-dark: #1A2C1F    (headers, emphasis)
  --alfabia-text: #1A1A1A          (body text on cream)
  --alfabia-text-muted: #6B7280    (secondary text)
  --alfabia-border: #E5E0D5        (subtle borders on cream)
  --alfabia-accent: #8B7355        (warm accent, earthy tone)

Typography:
  Headings: "Teodor", serif (Regular weight for UI, Light for decorative)
  Body: system sans-serif stack (Inter or similar — Teodor is display-only)
  
  Fallback: If Teodor is not available as a web font, use a serif fallback:
  font-family: "Teodor", "Playfair Display", Georgia, serif
```

The visual style is elegant, organic, and minimal. Think historic garden estate — not tech startup. Generous whitespace, photography-forward, muted tones.

## Architecture — directory structure

```
src/
├── components/
│   ├── audio/
│   │   ├── AudioPlayer.tsx          # Main player with play/pause/seek
│   │   ├── AudioProgress.tsx        # Progress bar
│   │   └── DownloadButton.tsx       # Download for offline
│   ├── poi/
│   │   ├── POICard.tsx              # Summary card in list
│   │   ├── POIDetail.tsx            # Full detail screen
│   │   └── POIList.tsx              # List/search view
│   ├── map/
│   │   ├── MapView.tsx              # Global map with all pins
│   │   └── POIMarker.tsx            # Individual marker
│   ├── geo/
│   │   ├── GeoLocator.tsx           # Geolocation logic
│   │   ├── ProximityEngine.ts       # Haversine + suggestions
│   │   └── PermissionHandler.tsx    # GPS permission UX flow
│   ├── offline/
│   │   ├── OfflineManager.tsx       # Cache controller
│   │   ├── DownloadProgress.tsx     # Download indicator
│   │   └── StorageQuota.tsx         # Space monitor
│   ├── layout/
│   │   ├── AppShell.tsx             # Main layout wrapper
│   │   ├── BottomNav.tsx            # Bottom navigation (Home, Map, Settings)
│   │   └── LanguageSelector.tsx     # Language picker
│   └── ui/                          # shadcn/ui base components
├── hooks/
│   ├── useGeolocation.ts
│   ├── useProximity.ts
│   ├── useAudioCache.ts
│   └── useLanguage.ts
├── stores/
│   ├── useAppStore.ts               # Language, GPS position, connection state
│   ├── useProgressStore.ts          # Listened POIs + favorites (persisted)
│   └── useOfflineStore.ts           # Download state, cached audios
├── services/
│   ├── supabase.ts                  # Supabase client init
│   ├── audioService.ts              # Streaming/cache logic
│   └── poiService.ts                # POI queries
├── lib/
│   ├── haversine.ts                 # Distance calculation
│   └── constants.ts                 # Radii, URLs, config
├── pages/                           # Route-based pages
│   ├── SplashPage.tsx
│   ├── LanguagePage.tsx
│   ├── HomePage.tsx
│   ├── POIDetailPage.tsx
│   ├── MapPage.tsx
│   └── ClosingPage.tsx
└── sw.ts                            # Service Worker
```

## Screen flow

```
QR scan → SplashPage → LanguagePage → HomePage → POIDetailPage → ClosingPage
                                         ↕              ↕
                                      MapPage      (AudioPlayer)
```

1. **SplashPage**: Logo animation, app shell precache starts
2. **LanguagePage**: Auto-detect via `navigator.language`, manual override. Persist in localStorage
3. **HomePage**: Two tabs — "Cerca de mí" (GPS proximity) + "Ver todos" (full list). Download audios button
4. **POIDetailPage**: Title, image, AudioPlayer, full text (scrollable), mini-map, favorite button, suggested next
5. **MapPage**: All 18 pins + user position marker. Pin colors: gray=unvisited, green=listened, red=favorite. NO route line
6. **ClosingPage**: Farewell message, Google Reviews link, events info, contact

**BottomNav** (persistent): Home icon | Map icon | Settings icon (language, offline, credits)

## POI data (18 audios, 3 sections)

### Section A: Jardines (9 audios)

| # | Name | Guide points | Duration | Notes |
|---|------|-------------|----------|-------|
| 1 | Bienvenida y Portal Forà | Pt.2 (+17 anecdotal) | ~90s | Entry point. Sóller train = anecdotal mention only |
| 2 | Escalera de piedra y sistema hidráulico | Pts.1, 3 | ~110s | Arab water engineering |
| 3 | Chorros de agua y Pergolado | Pts.4, 5 | ~75s | |
| 4 | Mirador y Fuentes | Pts.6, 7, 8 | ~80s | Grouped with water features |
| 5 | Glicinia y Terraza | Pt.9 | ~80s | |
| 6 | Huerto de naranjos y Animales | Pts.10, 11 | ~90s | |
| 7 | Jardinet, Lago y Escultura Miró | Pts.13, 14, 15 | ~100s | **Miró sculpture confirmed: "Tête de femme (Déesse)" 1970, bronze, Cat.Raisonné #182, insured 900k€** |
| 8 | Palmeras y Picudo rojo | Pt.16 | ~75s | **BIFURCATION NODE** — after this point, visitors choose left (garden pt.9) or right (house/exit) |
| 9 | Zona de Eventos y Cedro | Pt.12 | ~60s | Events info, catering mention |

### Section B: La Casa (6 audios)

| # | Name | Guide points | Duration | Notes |
|---|------|-------------|----------|-------|
| 10 | Introducción a la Casa | Pt.18 | ~75s | House entry overview |
| 11 | Estancias de la Reina | Pts.26, 27 | ~115s | Queen Isabel II visit, 1860 |
| 12 | Silla gótica y Grabados | Pt.25 | ~75s | |
| 13 | Artesonado mozárabe y Biblioteca | Pts.24, 23 | ~120s | Unique medieval elements |
| 14 | Sala de entrada y Escudos | Pts.22, 19/20 | ~100s | Family crests, heraldry |
| 15 | Galería porticada y Pasillo hereditario | Pt.21 | ~110s | Genealogy, hereditary documents |

House visitor order is inverted from guide numbering: 26→25→24→23→22→19/20

### Section C: Dependencias y Cierre (3 audios)

| # | Name | Guide points | Duration | Notes |
|---|------|-------------|----------|-------|
| 16 | Clastra, Capilla y Tienda | Pts.28, 29, 30 | ~110s | Central courtyard, souvenir shop |
| 17 | Establo y Almazara | Pts.31, 32, 33 | ~120s | Stable + olive mill consolidated |
| 18 | Despedida y Cierre | Pt.34 | ~60s | Farewell, reviews link, events |

Total estimated duration: ~26 minutes.

## Supabase schema

### Table: pois

```sql
CREATE TABLE pois (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  number INT2 NOT NULL UNIQUE,          -- 1-18
  section TEXT NOT NULL CHECK (section IN ('jardines', 'casa', 'dependencias')),
  name_key TEXT NOT NULL,                -- translation key, e.g. 'poi_1'
  guide_points TEXT,                     -- "Pts. 1, 3"
  latitude FLOAT8 NOT NULL,
  longitude FLOAT8 NOT NULL,
  activation_radius_m INT2 DEFAULT 30,
  duration_seconds INT2,
  image_url TEXT,
  sort_order INT2 NOT NULL,
  is_bifurcation BOOLEAN DEFAULT FALSE,
  bifurcation_targets JSONB,            -- e.g. [5, 10] for POI 8
  created_at TIMESTAMPTZ DEFAULT NOW()
);
```

### Table: translations

```sql
CREATE TABLE translations (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  poi_id UUID REFERENCES pois(id) ON DELETE CASCADE,
  language TEXT NOT NULL CHECK (language IN ('es', 'en', 'de', 'ca', 'fr')),
  title TEXT NOT NULL,
  description TEXT NOT NULL,             -- full audio transcript for reading
  audio_url_mp3 TEXT,
  audio_url_ogg TEXT,
  audio_size_bytes INT4,
  UNIQUE (poi_id, language)
);
```

### Table: app_config

```sql
CREATE TABLE app_config (
  key TEXT PRIMARY KEY,
  value JSONB NOT NULL
);
-- Seed: default_language, default_radius, app_version, review_urls
```

### RLS policies

- `SELECT` enabled for `anon` role on all three tables (public read-only)
- `INSERT/UPDATE/DELETE` restricted to `service_role`
- Audio files in Supabase Storage: public bucket, read-only policy

## GPS and proximity logic

### Geolocation API config

```typescript
const geoOptions: PositionOptions = {
  enableHighAccuracy: true,
  maximumAge: 5000,       // reuse position up to 5s
  timeout: 15000          // generous for 3G
};
```

### Permission flow (CRITICAL UX)

1. **Pre-permission screen**: Custom UI explaining WHY location is needed ("Para sugerirte los puntos más cercanos"). Button: "Activar ubicación"
2. **Native prompt**: Only triggered AFTER user taps the custom button
3. **If denied**: Non-blocking message: "Puedes seguir usando la audioguía manualmente. Si cambias de opinión, activa la ubicación en los ajustes de tu navegador." Enable full manual access via list
4. **Weak signal** (accuracy > 50m): Show badge "GPS impreciso — sugerencias aproximadas". Dynamically expand activation radius. Never disable suggestions

### Haversine distance

```typescript
function haversine(lat1: number, lon1: number, lat2: number, lon2: number): number {
  const R = 6371e3; // Earth radius in meters
  const φ1 = lat1 * Math.PI / 180;
  const φ2 = lat2 * Math.PI / 180;
  const Δφ = (lat2 - lat1) * Math.PI / 180;
  const Δλ = (lon2 - lon1) * Math.PI / 180;
  const a = Math.sin(Δφ/2)**2 + Math.cos(φ1) * Math.cos(φ2) * Math.sin(Δλ/2)**2;
  return R * 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a));
}
```

### Bifurcation at POI 8 (Palmeras / Punto 9)

When user is within range of POI 8, the system MUST show TWO suggestions simultaneously:
- Left path → POI 5 (Glicinia y Terraza) / continuing garden
- Right path → POI 10 (Introducción a la Casa) / house entrance

Implement as dual-card UI, not a single "next" suggestion.

## Offline strategy

### Layer 1 — App Shell (automatic)

Service Worker caches HTML, CSS, JS, fonts, images on first visit (QR scan). Strategy: **Cache First** with background revalidation (Stale While Revalidate for static assets).

### Layer 2 — Audio (manual download)

Only cached when user taps "Descargar audios (Modo Offline)". Downloads ONLY the 18 audios for the active language (~25-30MB in OGG/Opus 48kbps), NOT all 90 files.

Storage: **Cache Storage** (Cache API), not IndexedDB for audio blobs. IndexedDB is for metadata only.

Download strategy:
- Sequential (1 at a time) — don't saturate 3G
- Show progress: "Audio 3/18 descargando..."
- Check `navigator.storage.estimate()` before starting — warn if < 50MB free
- Offer "Liberar espacio" button to clear audio cache without losing progress/favorites

### Layer 3 — Dynamic data

Supabase queries: **Network First** with cache fallback. POI/translation data cached on first successful fetch.

### Service Worker versioning

Increment `CACHE_VERSION` on every deploy. Old SW self-destructs. Stale caches purged in `activate` event.

## Audio format

- **Primary**: OGG/Opus at 48kbps (~30% smaller than MP3)
- **Fallback**: MP3 128kbps (for browsers without Opus support, mainly older Safari)
- File naming: `poi_{number}_{lang}.ogg` / `poi_{number}_{lang}.mp3`
- Example: `poi_07_es.ogg`, `poi_07_en.mp3`
- Streaming by default from Supabase Storage public bucket

## Zustand stores

### useAppStore
- `language`: active language code ('es' | 'en' | 'de' | 'ca' | 'fr')
- `userPosition`: { lat, lng, accuracy } | null
- `nearbyPOIs`: POI[] (sorted by distance)
- `selectedPOI`: POI | null
- `isOnline`: boolean

### useProgressStore (persisted in localStorage as 'alfabia-progress')
- `listenedPOIs`: string[] (array of POI IDs)
- `favorites`: string[] (array of POI IDs)
- `markAsListened(poiId)`: add to listened
- `toggleFavorite(poiId)`: toggle favorite

### useOfflineStore (persisted in localStorage as 'alfabia-offline')
- `downloadState`: 'idle' | 'downloading' | 'complete' | 'error'
- `downloadProgress`: number (0-100)
- `cachedAudios`: string[] (POI IDs with cached audio)
- `availableSpace`: number (bytes)

## Coding conventions

- **Language**: TypeScript strict mode. No `any` types
- **Components**: Functional components with hooks. No class components
- **Naming**: PascalCase for components, camelCase for hooks/utils, kebab-case for CSS classes
- **Imports**: Absolute imports via `@/` alias (configured in vite.config.ts and tsconfig.json)
- **Commits**: Conventional Commits — `feat:`, `fix:`, `chore:`, `docs:`
- **One prompt = one component/feature**. Never combine multiple unrelated changes
- **Always clean up**: `clearWatch()` on geolocation, `removeEventListener`, abort controllers on unmount
- **Error boundaries**: Wrap major sections in React Error Boundaries
- **Lazy loading**: `React.lazy()` for MapPage (Leaflet is heavy). `loading="lazy"` on all images
- **Images**: WebP format, max 200KB each, with alt text per language

## Testing checklist (before any deploy to main)

- [ ] PWA installable on iOS Safari + Android Chrome
- [ ] 18 POIs render with correct data in all 5 languages
- [ ] AudioPlayer plays, pauses, seeks correctly
- [ ] GPS permission flow works for grant, deny, and weak signal
- [ ] Proximity suggestions appear within configured radius
- [ ] Bifurcation at POI 8 shows dual suggestion
- [ ] Offline mode: app shell works without network
- [ ] Offline audio download completes and plays from cache
- [ ] Map shows 18 pins + user position, no route line
- [ ] Progress (listened/favorites) persists across sessions
- [ ] Language switch updates all text + audio URLs
- [ ] ClosingPage links to Google Reviews work

## Important notes

- GPS coordinates for POIs are PLACEHOLDER until field calibration in Alfabia (Week 5 of roadmap). Use approximate coords from Google Maps for development
- The site has very poor mobile coverage (~3G at best). Every network request must have a timeout and graceful fallback
- The Joan Miró sculpture ("Tête de femme / Déesse", 1970) is a confirmed highlight for Audio 7 — treat it prominently in the UI
- Visitors start at the garden entrance and typically follow a natural flow, but the app MUST allow completely free exploration. No locks, no gates, no "complete previous to unlock"
- The house tour order is INVERTED from the official guide numbering (visitors enter at point 26 and exit toward point 19/20)
