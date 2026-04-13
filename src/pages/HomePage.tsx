import { useState, useEffect, useMemo, useRef } from 'react'
import { MapPin, List, Loader2, AlertCircle, Navigation } from 'lucide-react'
import { useNavigate } from 'react-router-dom'
import { useAppStore } from '@/stores/useAppStore'
import { useProgressStore } from '@/stores/useProgressStore'
import { getPOIsWithTranslations } from '@/services/poiService'
import { trackSessionStart } from '@/services/analyticsService'
import POIList, { type POIWithTranslation } from '@/components/poi/POIList'
import POICard from '@/components/poi/POICard'
import OfflineManager from '@/components/offline/OfflineManager'
import type { Language } from '@/lib/types'

// ─── UI copy ─────────────────────────────────────────────────────────────────

const UI_COPY = {
  es: {
    nearbyTab: 'Cerca de mí',
    allTab: 'Ver todos',
    nearbyEmpty: 'No hay puntos cercanos',
    nearbyEmptyHint: 'Activa el GPS para recibir sugerencias según tu posición.',
    nearbyNoGps: 'Ubicación no disponible',
    nearbyNoGpsHint: 'Activa la ubicación para ver los puntos más cercanos.',
    loading: 'Cargando…',
    error: 'No se pudo cargar la lista. Comprueba tu conexión.',
    retry: 'Reintentar',
    listened: 'escuchado',
    progress: (n: number, total: number) => `${n} de ${total}`,
  },
  en: {
    nearbyTab: 'Near me',
    allTab: 'All stops',
    nearbyEmpty: 'No nearby stops',
    nearbyEmptyHint: 'Enable GPS to receive suggestions based on your location.',
    nearbyNoGps: 'Location unavailable',
    nearbyNoGpsHint: 'Enable location to see the nearest stops.',
    loading: 'Loading…',
    error: 'Could not load the list. Check your connection.',
    retry: 'Retry',
    listened: 'listened',
    progress: (n: number, total: number) => `${n} of ${total}`,
  },
  de: {
    nearbyTab: 'In der Nähe',
    allTab: 'Alle Punkte',
    nearbyEmpty: 'Keine nahen Punkte',
    nearbyEmptyHint: 'Aktiviere GPS für Vorschläge basierend auf deinem Standort.',
    nearbyNoGps: 'Standort nicht verfügbar',
    nearbyNoGpsHint: 'Aktiviere den Standort, um die nächsten Punkte zu sehen.',
    loading: 'Wird geladen…',
    error: 'Liste konnte nicht geladen werden. Verbindung prüfen.',
    retry: 'Erneut versuchen',
    listened: 'gehört',
    progress: (n: number, total: number) => `${n} von ${total}`,
  },
  ca: {
    nearbyTab: 'Prop meu',
    allTab: 'Veure tots',
    nearbyEmpty: 'No hi ha punts propers',
    nearbyEmptyHint: 'Activa el GPS per rebre suggeriments segons la teva posició.',
    nearbyNoGps: 'Ubicació no disponible',
    nearbyNoGpsHint: "Activa la ubicació per veure els punts més propers.",
    loading: 'Carregant…',
    error: "No s'ha pogut carregar la llista. Comprova la connexió.",
    retry: 'Tornar a intentar',
    listened: 'escoltat',
    progress: (n: number, total: number) => `${n} de ${total}`,
  },
  fr: {
    nearbyTab: 'Près de moi',
    allTab: 'Tout voir',
    nearbyEmpty: 'Aucun point à proximité',
    nearbyEmptyHint: 'Activez le GPS pour recevoir des suggestions selon votre position.',
    nearbyNoGps: 'Localisation indisponible',
    nearbyNoGpsHint: 'Activez la localisation pour voir les points les plus proches.',
    loading: 'Chargement…',
    error: 'Impossible de charger la liste. Vérifiez votre connexion.',
    retry: 'Réessayer',
    listened: 'écouté',
    progress: (n: number, total: number) => `${n} sur ${total}`,
  },
} satisfies Record<Language, Record<string, string | ((n: number, total: number) => string)>>

// ─── Nearby tab ───────────────────────────────────────────────────────────────

interface NearbyTabProps {
  language: Language
  nearbyItems: POIWithTranslation[]
  hasPosition: boolean
}

function NearbyTab({ language, nearbyItems, hasPosition }: NearbyTabProps) {
  const navigate = useNavigate()
  const isListened = useProgressStore((s) => s.isListened)
  const isFavorite = useProgressStore((s) => s.isFavorite)
  const copy = UI_COPY[language]

  if (!hasPosition) {
    return (
      <div className="flex flex-col items-center justify-center gap-3 px-8 py-16 text-center">
        <Navigation className="w-10 h-10 text-alfabia-border" />
        <p className="font-medium text-alfabia-text">{copy.nearbyNoGps as string}</p>
        <p className="text-sm text-alfabia-text-muted">{copy.nearbyNoGpsHint as string}</p>
      </div>
    )
  }

  if (nearbyItems.length === 0) {
    return (
      <div className="flex flex-col items-center justify-center gap-3 px-8 py-16 text-center">
        <MapPin className="w-10 h-10 text-alfabia-border" />
        <p className="font-medium text-alfabia-text">{copy.nearbyEmpty as string}</p>
        <p className="text-sm text-alfabia-text-muted">{copy.nearbyEmptyHint as string}</p>
      </div>
    )
  }

  return (
    <div className="space-y-2 px-4 py-4">
      {nearbyItems.map(({ poi, translation }) => (
        <POICard
          key={poi.id}
          poi={poi}
          translation={translation}
          language={language}
          isListened={isListened(poi.id)}
          isFavorite={isFavorite(poi.id)}
          onClick={() => navigate(`/poi/${poi.id}`)}
        />
      ))}
    </div>
  )
}

// ─── HomePage ─────────────────────────────────────────────────────────────────

type Tab = 'nearby' | 'all'

export default function HomePage() {
  const language = useAppStore((s) => s.language)
  const nearbyPOIs = useAppStore((s) => s.nearbyPOIs)
  const userPosition = useAppStore((s) => s.userPosition)

  const [activeTab, setActiveTab] = useState<Tab>('nearby')
  const [allItems, setAllItems] = useState<POIWithTranslation[]>([])
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState<string | null>(null)

  const sessionTracked = useRef(false)
  useEffect(() => {
    if (sessionTracked.current) return
    sessionTracked.current = true
    trackSessionStart()
  }, [])

  const copy = UI_COPY[language]

  async function fetchPOIs() {
    setLoading(true)
    setError(null)
    try {
      const items = await getPOIsWithTranslations(language)
      setAllItems(items)
    } catch {
      setError(copy.error as string)
    } finally {
      setLoading(false)
    }
  }

  useEffect(() => {
    void fetchPOIs()
    // Re-fetch when language changes so titles/audio URLs update
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [language])

  // Derive nearby items from the full list to avoid extra fetches
  const nearbyItems = useMemo(() => {
    const nearbyIds = new Set(nearbyPOIs.map((p) => p.id))
    return allItems.filter(({ poi }) => nearbyIds.has(poi.id))
  }, [allItems, nearbyPOIs])

  const listenedCount = useProgressStore((s) =>
    allItems.filter(({ poi }) => s.isListened(poi.id)).length,
  )

  return (
    <div className="flex flex-col min-h-full">
      {/* ── Header ── */}
      <div className="px-4 pt-6 pb-3 bg-alfabia-cream">
        <h1 className="font-display text-2xl text-alfabia-green-dark leading-tight">
          Jardines de Alfabia
        </h1>
        {!loading && allItems.length > 0 && (
          <p className="text-xs text-alfabia-text-muted mt-0.5">
            {listenedCount}/{allItems.length} {copy.listened as string}
          </p>
        )}
      </div>

      {/* ── Tabs ── */}
      <div className="px-4 pb-3 bg-alfabia-cream sticky top-0 z-10 border-b border-alfabia-border">
        <div className="flex gap-1 bg-alfabia-border/40 rounded-xl p-1">
          {(['nearby', 'all'] as Tab[]).map((tab) => (
            <button
              key={tab}
              type="button"
              onClick={() => setActiveTab(tab)}
              className={[
                'flex-1 flex items-center justify-center gap-1.5 py-2 rounded-lg text-sm font-medium transition-colors',
                activeTab === tab
                  ? 'bg-white text-alfabia-green shadow-sm'
                  : 'text-alfabia-text-muted hover:text-alfabia-text',
              ].join(' ')}
            >
              {tab === 'nearby' ? (
                <><MapPin className="w-3.5 h-3.5" />{copy.nearbyTab as string}</>
              ) : (
                <><List className="w-3.5 h-3.5" />{copy.allTab as string}</>
              )}
            </button>
          ))}
        </div>
      </div>

      {/* ── Content ── */}
      <div className="flex-1">
        {loading && (
          <div className="flex items-center justify-center gap-2 py-16 text-alfabia-text-muted">
            <Loader2 className="w-5 h-5 animate-spin" />
            <span className="text-sm">{copy.loading as string}</span>
          </div>
        )}

        {!loading && error && (
          <div className="flex flex-col items-center gap-3 px-8 py-16 text-center">
            <AlertCircle className="w-8 h-8 text-rose-400" />
            <p className="text-sm text-alfabia-text-muted">{error}</p>
            <button
              type="button"
              onClick={() => void fetchPOIs()}
              className="text-sm font-medium text-alfabia-green underline underline-offset-2"
            >
              {copy.retry as string}
            </button>
          </div>
        )}

        {!loading && !error && (
          <>
            {activeTab === 'nearby' && (
              <NearbyTab
                language={language}
                nearbyItems={nearbyItems}
                hasPosition={userPosition !== null}
              />
            )}
            {activeTab === 'all' && (
              <POIList items={allItems} language={language} />
            )}
          </>
        )}
      </div>

      {/* ── Offline manager (fixed above bottom nav) ── */}
      {!loading && !error && allItems.length > 0 && (
        <div className="shrink-0 px-4 py-3 bg-alfabia-cream border-t border-alfabia-border">
          <OfflineManager language={language} items={allItems} />
        </div>
      )}
    </div>
  )
}
