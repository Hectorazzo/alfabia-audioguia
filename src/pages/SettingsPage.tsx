import { useAppStore } from '@/stores/useAppStore'
import { useLanguage } from '@/contexts/LanguageContext'
import { useOfflineStore } from '@/stores/useOfflineStore'
import type { Language } from '@/lib/types'

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
    title:          'Ajustes',
    langSection:    'Idioma',
    offlineSection: 'Modo offline',
    audiosCached:   (n: number, t: number) => `Audios descargados: ${n}/${t} ✓`,
    audiosNone:     'Audios no descargados',
    creditsSection: 'Créditos',
  },
  en: {
    title:          'Settings',
    langSection:    'Language',
    offlineSection: 'Offline mode',
    audiosCached:   (n: number, t: number) => `Downloaded audio: ${n}/${t} ✓`,
    audiosNone:     'Audio not downloaded',
    creditsSection: 'Credits',
  },
  de: {
    title:          'Einstellungen',
    langSection:    'Sprache',
    offlineSection: 'Offline-Modus',
    audiosCached:   (n: number, t: number) => `Audios heruntergeladen: ${n}/${t} ✓`,
    audiosNone:     'Audios nicht heruntergeladen',
    creditsSection: 'Impressum',
  },
  ca: {
    title:          'Configuració',
    langSection:    'Llengua',
    offlineSection: 'Mode offline',
    audiosCached:   (n: number, t: number) => `Àudios descarregats: ${n}/${t} ✓`,
    audiosNone:     'Àudios no descarregats',
    creditsSection: 'Crèdits',
  },
  fr: {
    title:          'Paramètres',
    langSection:    'Langue',
    offlineSection: 'Mode hors ligne',
    audiosCached:   (n: number, t: number) => `Audios téléchargés\u00a0: ${n}/${t} ✓`,
    audiosNone:     'Audios non téléchargés',
    creditsSection: 'Crédits',
  },
} satisfies Record<Language, Record<string, string | ((n: number, t: number) => string)>>

const TOTAL_AUDIOS = 18

// ─── Component ────────────────────────────────────────────────────────────────

export default function SettingsPage() {
  const language = useAppStore((s) => s.language)
  const { setLanguage } = useLanguage()
  const copy = COPY[language]

  const cachedAudios   = useOfflineStore((s) => s.cachedAudios)
  const cachedLanguage = useOfflineStore((s) => s.cachedLanguage)

  const cachedCount = cachedLanguage === language ? cachedAudios.length : 0
  const allCached   = cachedCount >= TOTAL_AUDIOS

  return (
    <div className="flex flex-col min-h-full bg-alfabia-cream pb-20">
      {/* ── Header ── */}
      <div className="px-4 pt-6 pb-4 border-b border-alfabia-border">
        <h1 className="font-display text-2xl text-alfabia-green-dark">{copy.title as string}</h1>
      </div>

      {/* ── Language section ── */}
      <section className="px-4 pt-5 pb-2">
        <h2 className="text-xs font-semibold uppercase tracking-widest text-alfabia-text-muted mb-3">
          {copy.langSection as string}
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

      {/* ── Offline section — discrete cache status indicator ── */}
      <section className="px-4 pb-2">
        <h2 className="text-xs font-semibold uppercase tracking-widest text-alfabia-text-muted mb-3">
          {copy.offlineSection as string}
        </h2>
        <p className={`text-sm ${allCached ? 'text-emerald-700' : 'text-alfabia-text-muted'}`}>
          {allCached
            ? (copy.audiosCached as (n: number, t: number) => string)(cachedCount, TOTAL_AUDIOS)
            : cachedCount > 0
              ? (copy.audiosCached as (n: number, t: number) => string)(cachedCount, TOTAL_AUDIOS)
              : copy.audiosNone as string}
        </p>
      </section>

      <div className="mx-4 my-4 border-t border-alfabia-border" />

      {/* ── Credits section ── */}
      <section className="px-4 pb-4">
        <h2 className="text-xs font-semibold uppercase tracking-widest text-alfabia-text-muted mb-3">
          {copy.creditsSection as string}
        </h2>
        <p className="text-sm text-alfabia-text-muted">
          A digital experience — with ❤️ — by{' '}
          <a
            href="https://punk.solutions/en"
            target="_blank"
            rel="noopener noreferrer"
            className="text-alfabia-accent underline underline-offset-2 hover:text-alfabia-green transition-colors"
          >
            Punk Solutions
          </a>
        </p>
      </section>
    </div>
  )
}
