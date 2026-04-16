import { useEffect, useState } from 'react'
import { useAppStore } from '@/stores/useAppStore'
import { useLanguage } from '@/contexts/LanguageContext'
import { getPOIsWithTranslations } from '@/services/poiService'
import OfflineManager from '@/components/offline/OfflineManager'
import type { Language, POI, Translation } from '@/lib/types'

// ─── Constants ────────────────────────────────────────────────────────────────

interface LanguageOption {
  code: Language
  label: string
}

const LANGUAGES: LanguageOption[] = [
  { code: 'es', label: 'Español' },
  { code: 'en', label: 'English' },
  { code: 'de', label: 'Deutsch' },
  { code: 'ca', label: 'Català' },
  { code: 'fr', label: 'Français' },
]

const COPY = {
  es: {
    title: 'Ajustes',
    langSection: 'Idioma',
    offlineSection: 'Modo offline',
    creditsSection: 'Créditos',
  },
  en: {
    title: 'Settings',
    langSection: 'Language',
    offlineSection: 'Offline mode',
    creditsSection: 'Credits',
  },
  de: {
    title: 'Einstellungen',
    langSection: 'Sprache',
    offlineSection: 'Offline-Modus',
    creditsSection: 'Impressum',
  },
  ca: {
    title: 'Ajustos',
    langSection: 'Llengua',
    offlineSection: 'Mode offline',
    creditsSection: 'Crèdits',
  },
  fr: {
    title: 'Paramètres',
    langSection: 'Langue',
    offlineSection: 'Mode hors ligne',
    creditsSection: 'Crédits',
  },
} satisfies Record<Language, Record<string, string>>

// ─── Component ────────────────────────────────────────────────────────────────

export default function SettingsPage() {
  const language = useAppStore((s) => s.language)
  const { setLanguage } = useLanguage()
  const copy = COPY[language]

  // POI items needed by OfflineManager to build audio download list
  const [items, setItems] = useState<Array<{ poi: POI; translation: Translation }>>([])

  useEffect(() => {
    getPOIsWithTranslations(language)
      .then(setItems)
      .catch(() => {/* No network — OfflineManager shows cached state only */})
  }, [language])

  return (
    <div className="flex flex-col min-h-full bg-alfabia-cream pb-20">
      {/* ── Header ── */}
      <div className="px-4 pt-6 pb-4 border-b border-alfabia-border">
        <h1 className="font-display text-2xl text-alfabia-green-dark">{copy.title}</h1>
      </div>

      {/* ── Language section ── */}
      <section className="px-4 pt-5 pb-2">
        <h2 className="text-xs font-semibold uppercase tracking-widest text-alfabia-text-muted mb-3">
          {copy.langSection}
        </h2>

        <div className="flex flex-col gap-2">
          {LANGUAGES.map(({ code, label }) => {
            const isActive = language === code
            return (
              <button
                key={code}
                type="button"
                onClick={() => setLanguage(code)}
                aria-pressed={isActive}
                className={[
                  'flex items-center justify-between rounded-xl border px-5 py-3.5 text-left transition-all duration-150',
                  isActive
                    ? 'border-alfabia-green bg-alfabia-green text-alfabia-cream shadow-sm'
                    : 'border-alfabia-border bg-white text-alfabia-text hover:border-alfabia-green/40 hover:bg-alfabia-green/5',
                ].join(' ')}
              >
                <span className="text-sm font-medium">{label}</span>
                {isActive && (
                  <svg width="16" height="16" viewBox="0 0 18 18" fill="none" aria-hidden="true">
                    <circle cx="9" cy="9" r="8.25" stroke="#F8F2E7" strokeWidth="1.5" />
                    <path
                      d="M5.5 9l2.5 2.5 4.5-5"
                      stroke="#F8F2E7"
                      strokeWidth="1.5"
                      strokeLinecap="round"
                      strokeLinejoin="round"
                    />
                  </svg>
                )}
              </button>
            )
          })}
        </div>
      </section>

      <div className="mx-4 my-4 border-t border-alfabia-border" />

      {/* ── Offline section ── */}
      <section className="px-4 pb-2">
        <h2 className="text-xs font-semibold uppercase tracking-widest text-alfabia-text-muted mb-3">
          {copy.offlineSection}
        </h2>
        <OfflineManager language={language} items={items} />
      </section>

      <div className="mx-4 my-4 border-t border-alfabia-border" />

      {/* ── Credits section ── */}
      <section className="px-4 pb-4">
        <h2 className="text-xs font-semibold uppercase tracking-widest text-alfabia-text-muted mb-3">
          {copy.creditsSection}
        </h2>
        <div className="text-sm text-alfabia-text-muted leading-relaxed space-y-1">
          <p>Audioguía Digital Plus</p>
          <p>Jardines de Alfabia</p>
          <p>
            Desarrollado por{' '}
            <a
              href="https://punk.solutions"
              target="_blank"
              rel="noopener noreferrer"
              className="text-alfabia-accent underline underline-offset-2 hover:text-alfabia-green transition-colors"
            >
              Punk Solutions
            </a>
          </p>
          <p className="text-xs text-alfabia-border mt-2">punk.solutions</p>
        </div>
      </section>
    </div>
  )
}
