import { Check, Heart, Clock } from 'lucide-react'
import type { POI, Translation, Language, Section } from '@/lib/types'

// ─── Helpers ─────────────────────────────────────────────────────────────────

function formatDuration(seconds: number | null): string | null {
  if (!seconds) return null
  const m = Math.floor(seconds / 60)
  const s = seconds % 60
  return s === 0 ? `${m} min` : `${m}:${String(s).padStart(2, '0')}`
}

const SECTION_LABELS: Record<Language, Record<Section, string>> = {
  es: { jardines: 'Jardines', casa: 'La Casa', dependencias: 'Dependencias' },
  en: { jardines: 'Gardens', casa: 'The House', dependencias: 'Estate' },
  de: { jardines: 'Gärten', casa: 'Das Haus', dependencias: 'Nebengebäude' },
  ca: { jardines: 'Jardins', casa: 'La Casa', dependencias: 'Dependències' },
  fr: { jardines: 'Jardins', casa: 'La Maison', dependencias: 'Dépendances' },
}

const SECTION_COLORS: Record<Section, string> = {
  jardines: 'bg-emerald-50 text-emerald-700',
  casa: 'bg-amber-50 text-amber-700',
  dependencias: 'bg-stone-100 text-stone-600',
}

// ─── Component ───────────────────────────────────────────────────────────────

interface POICardProps {
  poi: POI
  translation: Translation
  language: Language
  isListened: boolean
  isFavorite: boolean
  onClick: () => void
}

export default function POICard({
  poi,
  translation,
  language,
  isListened,
  isFavorite,
  onClick,
}: POICardProps) {
  const duration = formatDuration(poi.durationSeconds)
  const sectionLabel = SECTION_LABELS[language][poi.section]
  const sectionColor = SECTION_COLORS[poi.section]

  return (
    <button
      type="button"
      onClick={onClick}
      className="w-full flex items-center gap-3 px-4 py-3 bg-white border border-alfabia-border rounded-xl text-left transition-colors active:bg-alfabia-cream hover:bg-alfabia-cream/60 focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-alfabia-green"
    >
      {/* Number badge */}
      <span
        className="shrink-0 w-9 h-9 rounded-full flex items-center justify-center text-sm font-semibold"
        style={{
          backgroundColor: isListened ? '#233B29' : '#E5E0D5',
          color: isListened ? '#F8F2E7' : '#6B7280',
        }}
      >
        {poi.number}
      </span>

      {/* Main content */}
      <div className="flex-1 min-w-0">
        <p className="text-sm font-medium text-alfabia-text leading-snug truncate">
          {translation.title}
        </p>
        <div className="flex items-center gap-2 mt-0.5 flex-wrap">
          <span className={`text-xs px-1.5 py-0.5 rounded-md font-medium ${sectionColor}`}>
            {sectionLabel}
          </span>
          {duration && (
            <span className="flex items-center gap-0.5 text-xs text-alfabia-text-muted">
              <Clock className="w-3 h-3" />
              {duration}
            </span>
          )}
        </div>
      </div>

      {/* Status badges */}
      <div className="shrink-0 flex items-center gap-1.5">
        {isListened && (
          <span
            title="Escuchado"
            className="w-6 h-6 rounded-full bg-emerald-100 flex items-center justify-center"
          >
            <Check className="w-3.5 h-3.5 text-emerald-600" strokeWidth={2.5} />
          </span>
        )}
        {isFavorite && (
          <span
            title="Favorito"
            className="w-6 h-6 rounded-full bg-rose-50 flex items-center justify-center"
          >
            <Heart className="w-3.5 h-3.5 fill-rose-500 text-rose-500" />
          </span>
        )}
      </div>
    </button>
  )
}
