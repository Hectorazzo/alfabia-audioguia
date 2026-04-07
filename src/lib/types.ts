// ─── Database row types (mirror Supabase schema exactly) ────────────────────

export interface POIRow {
  id: string
  number: number
  section: 'jardines' | 'casa' | 'dependencias'
  name_key: string
  guide_points: string | null
  latitude: number
  longitude: number
  activation_radius_m: number
  duration_seconds: number | null
  image_url: string | null
  sort_order: number
  is_bifurcation: boolean
  bifurcation_targets: number[] | null
  created_at: string
}

export interface TranslationRow {
  id: string
  poi_id: string
  language: 'es' | 'en' | 'de' | 'ca' | 'fr'
  title: string
  description: string
  audio_url_mp3: string | null
  audio_url_ogg: string | null
  audio_size_bytes: number | null
}

export interface AppConfigRow {
  key: string
  value: unknown
}

// ─── Application-level types (camelCase, used throughout the UI) ─────────────

export type Language = 'es' | 'en' | 'de' | 'ca' | 'fr'
export type Section = 'jardines' | 'casa' | 'dependencias'

export interface POI {
  id: string
  number: number
  section: Section
  nameKey: string
  guidePoints: string | null
  latitude: number
  longitude: number
  activationRadiusM: number
  durationSeconds: number | null
  imageUrl: string | null
  sortOrder: number
  isBifurcation: boolean
  bifurcationTargets: number[] | null
}

export interface Translation {
  id: string
  poiId: string
  language: Language
  title: string
  description: string
  audioUrlMp3: string | null
  audioUrlOgg: string | null
  audioSizeBytes: number | null
}

// ─── Converters (snake_case → camelCase) ────────────────────────────────────

export function rowToPOI(row: POIRow): POI {
  return {
    id: row.id,
    number: row.number,
    section: row.section,
    nameKey: row.name_key,
    guidePoints: row.guide_points,
    latitude: row.latitude,
    longitude: row.longitude,
    activationRadiusM: row.activation_radius_m,
    durationSeconds: row.duration_seconds,
    imageUrl: row.image_url,
    sortOrder: row.sort_order,
    isBifurcation: row.is_bifurcation,
    bifurcationTargets: row.bifurcation_targets,
  }
}

export function rowToTranslation(row: TranslationRow): Translation {
  return {
    id: row.id,
    poiId: row.poi_id,
    language: row.language,
    title: row.title,
    description: row.description,
    audioUrlMp3: row.audio_url_mp3,
    audioUrlOgg: row.audio_url_ogg,
    audioSizeBytes: row.audio_size_bytes,
  }
}
