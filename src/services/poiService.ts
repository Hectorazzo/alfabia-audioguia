import { supabase } from './supabase'
import {
  type POI,
  type POIRow,
  type Translation,
  type TranslationRow,
  type Language,
  rowToPOI,
  rowToTranslation,
} from '@/lib/types'

// ─── Error handling ──────────────────────────────────────────────────────────

export class POIServiceError extends Error {
  constructor(message: string, cause?: unknown) {
    super(message, { cause })
    this.name = 'POIServiceError'
  }
}

function assertData<T>(data: T | null, error: unknown, context: string): T {
  if (error) throw new POIServiceError(`${context}: ${String(error)}`, error)
  if (data === null) throw new POIServiceError(`${context}: no data returned`)
  return data
}

// ─── Queries ─────────────────────────────────────────────────────────────────

/**
 * Fetch all 18 POIs ordered by sort_order.
 * Results are cached on first successful fetch via Network First strategy.
 */
export async function getAllPOIs(): Promise<POI[]> {
  const { data, error } = await supabase
    .from('pois')
    .select('*')
    .order('sort_order', { ascending: true })
    .returns<POIRow[]>()

  const rows = assertData(data, error, 'getAllPOIs')
  return rows.map(rowToPOI)
}

/**
 * Fetch a single POI by UUID.
 */
export async function getPOIById(id: string): Promise<POI> {
  const { data, error } = await supabase
    .from('pois')
    .select('*')
    .eq('id', id)
    .single<POIRow>()

  const row = assertData(data, error, `getPOIById(${id})`)
  return rowToPOI(row)
}

/**
 * Fetch a single POI by its sequential number (1–18).
 */
export async function getPOIByNumber(number: number): Promise<POI> {
  const { data, error } = await supabase
    .from('pois')
    .select('*')
    .eq('number', number)
    .single<POIRow>()

  const row = assertData(data, error, `getPOIByNumber(${number})`)
  return rowToPOI(row)
}

/**
 * Fetch the translation for a given POI + language combination.
 */
export async function getTranslation(
  poiId: string,
  language: Language,
): Promise<Translation> {
  const { data, error } = await supabase
    .from('translations')
    .select('*')
    .eq('poi_id', poiId)
    .eq('language', language)
    .single<TranslationRow>()

  const row = assertData(data, error, `getTranslation(${poiId}, ${language})`)
  return rowToTranslation(row)
}

/**
 * Fetch all translations for a given POI (all 5 languages).
 * Useful for pre-caching during offline download.
 */
export async function getAllTranslationsForPOI(
  poiId: string,
): Promise<Translation[]> {
  const { data, error } = await supabase
    .from('translations')
    .select('*')
    .eq('poi_id', poiId)
    .returns<TranslationRow[]>()

  const rows = assertData(data, error, `getAllTranslationsForPOI(${poiId})`)
  return rows.map(rowToTranslation)
}

/**
 * Fetch all POIs with their translation for a given language in a single query.
 * Used to populate the HomePage list without N+1 requests.
 */
export async function getPOIsWithTranslations(
  language: Language,
): Promise<Array<{ poi: POI; translation: Translation }>> {
  const { data, error } = await supabase
    .from('pois')
    .select(`
      *,
      translations!inner (*)
    `)
    .eq('translations.language', language)
    .order('sort_order', { ascending: true })

  const rows = assertData(data, error, `getPOIsWithTranslations(${language})`)

  return (rows as Array<POIRow & { translations: TranslationRow[] }>).map(
    ({ translations, ...poiRow }) => ({
      poi: rowToPOI(poiRow),
      translation: rowToTranslation(translations[0]),
    }),
  )
}
