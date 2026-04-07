import { create } from 'zustand'
import type { Language, POI } from '@/lib/types'

export type { Language, POI }

export interface UserPosition {
  lat: number
  lng: number
  accuracy: number
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
