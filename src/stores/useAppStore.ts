import { create } from 'zustand'
import type { Language, POI } from '@/lib/types'

export type { Language, POI }

export interface UserPosition {
  lat: number
  lng: number
  accuracy: number
}

const VALID_LANGUAGES: Language[] = ['es', 'en', 'de', 'ca', 'fr']

/** Read language from localStorage so the store is correct before the context mounts */
function getInitialLanguage(): Language {
  try {
    const stored = localStorage.getItem('alfabia_lang')
    if (stored && VALID_LANGUAGES.includes(stored as Language)) return stored as Language
  } catch { /* private mode or storage unavailable */ }
  return 'es'
}

interface AppState {
  language: Language
  userPosition: UserPosition | null
  nearbyPOIs: POI[]
  selectedPOI: POI | null
  isOnline: boolean

  setLanguage: (language: Language) => void
  setUserPosition: (position: UserPosition | null) => void
  setNearbyPOIs: (pois: POI[]) => void
  setSelectedPOI: (poi: POI | null) => void
  setIsOnline: (online: boolean) => void
}

export const useAppStore = create<AppState>()((set) => ({
  language: getInitialLanguage(),
  userPosition: null,
  nearbyPOIs: [],
  selectedPOI: null,
  isOnline: navigator.onLine,

  setLanguage: (language) => set({ language }),
  setUserPosition: (userPosition) => set({ userPosition }),
  setNearbyPOIs: (nearbyPOIs) => set({ nearbyPOIs }),
  setSelectedPOI: (selectedPOI) => set({ selectedPOI }),
  setIsOnline: (isOnline) => set({ isOnline }),
}))
