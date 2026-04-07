import POICard from './POICard'
import type { POI, Translation, Language, Section } from '@/lib/types'
import { useProgressStore } from '@/stores/useProgressStore'
import { useNavigate } from 'react-router-dom'

// ─── Types ───────────────────────────────────────────────────────────────────

export interface POIWithTranslation {
  poi: POI
  translation: Translation
}

interface POIListProps {
  items: POIWithTranslation[]
  language: Language
}

// ─── Section grouping ─────────────────────────────────────────────────────────

const SECTION_ORDER: Section[] = ['jardines', 'casa', 'dependencias']

const SECTION_HEADINGS: Record<Language, Record<Section, string>> = {
  es: { jardines: 'Jardines', casa: 'La Casa', dependencias: 'Dependencias y Cierre' },
  en: { jardines: 'Gardens', casa: 'The House', dependencias: 'Estate & Farewell' },
  de: { jardines: 'Gärten', casa: 'Das Haus', dependencias: 'Nebengebäude & Abschluss' },
  ca: { jardines: 'Jardins', casa: 'La Casa', dependencias: 'Dependències i Tancament' },
  fr: { jardines: 'Jardins', casa: 'La Maison', dependencias: 'Dépendances & Fin' },
}

// ─── Component ───────────────────────────────────────────────────────────────

export default function POIList({ items, language }: POIListProps) {
  const navigate = useNavigate()
  const isListened = useProgressStore((s) => s.isListened)
  const isFavorite = useProgressStore((s) => s.isFavorite)

  // Group items by section, preserving sort_order within each section
  const grouped = SECTION_ORDER.reduce<Record<Section, POIWithTranslation[]>>(
    (acc, section) => {
      acc[section] = items.filter((item) => item.poi.section === section)
      return acc
    },
    { jardines: [], casa: [], dependencias: [] },
  )

  return (
    <div className="space-y-6 px-4 py-4">
      {SECTION_ORDER.map((section) => {
        const sectionItems = grouped[section]
        if (sectionItems.length === 0) return null

        return (
          <section key={section}>
            <h2 className="text-xs font-semibold uppercase tracking-widest text-alfabia-text-muted mb-2 px-1">
              {SECTION_HEADINGS[language][section]}
            </h2>
            <div className="space-y-2">
              {sectionItems.map(({ poi, translation }) => (
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
          </section>
        )
      })}
    </div>
  )
}
