import { createContext, useContext, useState, useEffect, type ReactNode } from 'react'
import type { Language } from '@/lib/types'
import { useAppStore } from '@/stores/useAppStore'

const STORAGE_KEY = 'alfabia_lang'
const VALID: readonly Language[] = ['es', 'en', 'de', 'fr', 'ca']

function readStored(): Language | null {
  try {
    const v = localStorage.getItem(STORAGE_KEY)
    return v && (VALID as string[]).includes(v) ? (v as Language) : null
  } catch {
    return null
  }
}

interface LanguageContextValue {
  language: Language | null
  setLanguage: (lang: Language) => void
}

const LanguageContext = createContext<LanguageContextValue | null>(null)

export function LanguageProvider({ children }: { children: ReactNode }) {
  const [language, setLanguageState] = useState<Language | null>(readStored)
  const setAppLanguage = useAppStore((s) => s.setLanguage)

  function setLanguage(lang: Language) {
    try {
      localStorage.setItem(STORAGE_KEY, lang)
    } catch {
      // storage unavailable (private mode or quota exceeded) — continue without persistence
    }
    setLanguageState(lang)
    setAppLanguage(lang)
  }

  // On mount, sync the Zustand store if we already have a stored language
  useEffect(() => {
    if (language !== null) setAppLanguage(language)
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [])

  return (
    <LanguageContext.Provider value={{ language, setLanguage }}>
      {children}
    </LanguageContext.Provider>
  )
}

export function useLanguage(): LanguageContextValue {
  const ctx = useContext(LanguageContext)
  if (!ctx) throw new Error('useLanguage must be used inside <LanguageProvider>')
  return ctx
}
