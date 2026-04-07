import { create } from 'zustand'

export type Language = 'es' | 'en' | 'de' | 'ca' | 'fr'

export interface UserPosition {
  lat: number
  lng: number
  accuracy: number
}

export interface POI {
  id: string
  number: number
  section: 'jardines' | 'casa' | 'dependencias'
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
  language: 'es',
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
