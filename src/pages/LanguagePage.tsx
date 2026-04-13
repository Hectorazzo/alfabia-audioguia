import { useState } from 'react'
import { useNavigate } from 'react-router-dom'
import { useAppStore, type Language } from '@/stores/useAppStore'
import { trackLanguageSelect } from '@/services/analyticsService'

interface LanguageOption {
  code: Language
  label: string
  localLabel: string // name in that language
}

const LANGUAGES: LanguageOption[] = [
  { code: 'es', label: 'Español',  localLabel: 'Español' },
  { code: 'en', label: 'English',  localLabel: 'English' },
  { code: 'de', label: 'Deutsch',  localLabel: 'Deutsch' },
  { code: 'ca', label: 'Català',   localLabel: 'Català'  },
  { code: 'fr', label: 'Français', localLabel: 'Français' },
]

/** Map browser language tag to one of our 5 codes, fallback to 'en'. */
function detectLanguage(): Language {
  const tag = navigator.language?.toLowerCase() ?? ''
  if (tag.startsWith('es')) return 'es'
  if (tag.startsWith('de')) return 'de'
  if (tag.startsWith('ca')) return 'ca'
  if (tag.startsWith('fr')) return 'fr'
  return 'en'
}

export default function LanguagePage() {
  const navigate = useNavigate()
  const setLanguage = useAppStore((s) => s.setLanguage)

  const [selected, setSelected] = useState<Language>(detectLanguage)

  function handleConfirm() {
    trackLanguageSelect(selected)
    setLanguage(selected)
    navigate('/home', { replace: true })
  }

  return (
    <div className="flex min-h-svh flex-col items-center justify-center bg-alfabia-cream px-6 py-12">
      {/* Header */}
      <div className="mb-10 flex flex-col items-center gap-2 text-center">
        <span className="text-xs tracking-[0.3em] text-alfabia-text-muted uppercase">
          Jardines de Alfabia
        </span>
        <h1 className="font-display text-3xl font-light text-alfabia-green-dark">
          Bienvenido
        </h1>
        <p className="mt-1 text-sm text-alfabia-text-muted">
          Choose your language · Wählen Sie Ihre Sprache
        </p>
      </div>

      {/* Language buttons */}
      <div className="flex w-full max-w-sm flex-col gap-3">
        {LANGUAGES.map(({ code, localLabel }) => {
          const isSelected = selected === code
          return (
            <button
              key={code}
              onClick={() => setSelected(code)}
              className={[
                'flex items-center justify-between rounded-xl border px-5 py-4 text-left transition-all duration-150',
                isSelected
                  ? 'border-alfabia-green bg-alfabia-green text-alfabia-cream shadow-md'
                  : 'border-alfabia-border bg-white text-alfabia-text hover:border-alfabia-green/40 hover:bg-alfabia-green/5',
              ].join(' ')}
              aria-pressed={isSelected}
            >
              <span className="text-base font-medium">{localLabel}</span>
              {isSelected && (
                <svg
                  width="18"
                  height="18"
                  viewBox="0 0 18 18"
                  fill="none"
                  aria-hidden="true"
                >
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

      {/* Confirm */}
      <button
        onClick={handleConfirm}
        className="mt-10 w-full max-w-sm rounded-xl bg-alfabia-green px-6 py-4 text-base font-medium text-alfabia-cream shadow-md transition-colors hover:bg-alfabia-green-light active:bg-alfabia-green-dark"
      >
        Continuar · Continue
      </button>
    </div>
  )
}
