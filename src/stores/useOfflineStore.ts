import { create } from 'zustand'
import { persist } from 'zustand/middleware'

export type DownloadState = 'idle' | 'downloading' | 'complete' | 'error'

interface OfflineState {
  downloadState: DownloadState
  downloadProgress: number
  cachedAudios: string[]
  availableSpace: number

  setDownloadState: (state: DownloadState) => void
  setDownloadProgress: (progress: number) => void
  addCachedAudio: (poiId: string) => void
  removeCachedAudio: (poiId: string) => void
  clearCachedAudios: () => void
  setAvailableSpace: (bytes: number) => void
  isAudioCached: (poiId: string) => boolean
}

export const useOfflineStore = create<OfflineState>()(
  persist(
    (set, get) => ({
      downloadState: 'idle',
      downloadProgress: 0,
      cachedAudios: [],
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
        set({ cachedAudios: [], downloadState: 'idle', downloadProgress: 0 }),

      setAvailableSpace: (availableSpace) => set({ availableSpace }),

      isAudioCached: (poiId) => get().cachedAudios.includes(poiId),
    }),
    {
      name: 'alfabia-offline',
      // Don't persist transient download state across sessions
      partialize: (state) => ({
        cachedAudios: state.cachedAudios,
        availableSpace: state.availableSpace,
      }),
    },
  ),
)
