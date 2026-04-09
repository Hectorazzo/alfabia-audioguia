import { create } from 'zustand'
import { persist } from 'zustand/middleware'
import type { Language } from '@/lib/types'

export type DownloadState = 'idle' | 'downloading' | 'complete' | 'error'

interface OfflineState {
  downloadState: DownloadState
  downloadProgress: number
  cachedAudios: string[]
  cachedLanguage: Language | null
  availableSpace: number

  setDownloadState: (state: DownloadState) => void
  setDownloadProgress: (progress: number) => void
  addCachedAudio: (poiId: string) => void
  removeCachedAudio: (poiId: string) => void
  clearCachedAudios: () => void
  setCachedLanguage: (language: Language | null) => void
  setAvailableSpace: (bytes: number) => void
  isAudioCached: (poiId: string) => boolean
}

export const useOfflineStore = create<OfflineState>()(
  persist(
    (set, get) => ({
      downloadState: 'idle',
      downloadProgress: 0,
      cachedAudios: [],
      cachedLanguage: null,
      availableSpace: 0,

      setDownloadState: (downloadState) => set({ downloadState }),

      setDownloadProgress: (downloadProgress) => set({ downloadProgress }),

      addCachedAudio: (poiId) =>
        set((state) => ({
          cachedAudios: state.cachedAudios.includes(poiId)
            ? state.cachedAudios
            : [...state.cachedAudios, poiId],
        })),

      removeCachedAudio: (poiId) =>
        set((state) => ({
          cachedAudios: state.cachedAudios.filter((id) => id !== poiId),
        })),

      clearCachedAudios: () =>
        set({ cachedAudios: [], cachedLanguage: null, downloadState: 'idle', downloadProgress: 0 }),

      setCachedLanguage: (cachedLanguage) => set({ cachedLanguage }),

      setAvailableSpace: (availableSpace) => set({ availableSpace }),

      isAudioCached: (poiId) => get().cachedAudios.includes(poiId),
    }),
    {
      name: 'alfabia-offline',
      // Don't persist transient download state across sessions
      partialize: (state) => ({
        cachedAudios: state.cachedAudios,
        cachedLanguage: state.cachedLanguage,
        availableSpace: state.availableSpace,
      }),
    },
  ),
)
