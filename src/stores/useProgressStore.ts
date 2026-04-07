import { create } from 'zustand'
import { persist } from 'zustand/middleware'

interface ProgressState {
  listenedPOIs: string[]
  favorites: string[]

  markAsListened: (poiId: string) => void
  toggleFavorite: (poiId: string) => void
  isListened: (poiId: string) => boolean
  isFavorite: (poiId: string) => boolean
  reset: () => void
}

const initialState = {
  listenedPOIs: [] as string[],
  favorites: [] as string[],
}

export const useProgressStore = create<ProgressState>()(
  persist(
    (set, get) => ({
      ...initialState,

      markAsListened: (poiId) =>
        set((state) => ({
          listenedPOIs: state.listenedPOIs.includes(poiId)
            ? state.listenedPOIs
            : [...state.listenedPOIs, poiId],
        })),

      toggleFavorite: (poiId) =>
        set((state) => ({
          favorites: state.favorites.includes(poiId)
            ? state.favorites.filter((id) => id !== poiId)
            : [...state.favorites, poiId],
        })),

      isListened: (poiId) => get().listenedPOIs.includes(poiId),
      isFavorite: (poiId) => get().favorites.includes(poiId),

      reset: () => set(initialState),
    }),
    {
      name: 'alfabia-progress',
    },
  ),
)
