import type { Language } from '@/lib/types'

// ─── Constants ────────────────────────────────────────────────────────────────

const AUDIO_CACHE_PREFIX = 'alfabia-audio-v1'
const FETCH_TIMEOUT_MS = 30_000
export const LOW_SPACE_THRESHOLD_BYTES = 50 * 1024 * 1024 // 50 MB

// ─── Types ────────────────────────────────────────────────────────────────────

export interface AudioItem {
  poiId: string
  audioUrl: string
}

export interface DownloadCallbacks {
  onProgress: (downloaded: number, total: number, poiId: string) => void
  onItemError: (err: unknown, poiId: string) => void
}

// ─── Helpers ──────────────────────────────────────────────────────────────────

function audioCacheName(language: Language): string {
  return `${AUDIO_CACHE_PREFIX}-${language}`
}

function cacheAvailable(): boolean {
  return typeof caches !== 'undefined'
}

// ─── Download ─────────────────────────────────────────────────────────────────

/**
 * Download the audio files for one language sequentially (1 at a time) into
 * Cache Storage. Already-cached entries are skipped without re-fetching.
 * Throws DOMException('AbortError') if the signal fires.
 */
export async function downloadAudiosForLanguage(
  language: Language,
  items: AudioItem[],
  callbacks: DownloadCallbacks,
  signal?: AbortSignal,
): Promise<void> {
  if (!cacheAvailable()) {
    throw new Error('Cache API is not available in this browser context')
  }

  const cache = await caches.open(audioCacheName(language))

  for (let i = 0; i < items.length; i++) {
    if (signal?.aborted) throw new DOMException('Download cancelled', 'AbortError')

    const { poiId, audioUrl } = items[i]

    // Skip if already in cache
    const hit = await cache.match(audioUrl)
    if (hit) {
      callbacks.onProgress(i + 1, items.length, poiId)
      continue
    }

    const inner = new AbortController()
    const timeoutId = setTimeout(() => inner.abort(), FETCH_TIMEOUT_MS)
    const onParentAbort = () => inner.abort()
    signal?.addEventListener('abort', onParentAbort, { once: true })

    try {
      const response = await fetch(audioUrl, { signal: inner.signal })
      clearTimeout(timeoutId)
      signal?.removeEventListener('abort', onParentAbort)

      if (!response.ok) throw new Error(`HTTP ${response.status} — ${audioUrl}`)
      await cache.put(audioUrl, response)
    } catch (err) {
      clearTimeout(timeoutId)
      signal?.removeEventListener('abort', onParentAbort)

      if (err instanceof DOMException && err.name === 'AbortError') {
        throw err
      }
      callbacks.onItemError(err, poiId)
      throw err
    }

    callbacks.onProgress(i + 1, items.length, poiId)
  }
}

// ─── Clear ────────────────────────────────────────────────────────────────────

/**
 * Remove audio cache for a specific language, or all languages if omitted.
 * Does NOT touch useProgressStore (listened / favorites).
 */
export async function clearAudioCache(language?: Language): Promise<void> {
  if (!cacheAvailable()) return

  if (language) {
    await caches.delete(audioCacheName(language))
    return
  }

  const keys = await caches.keys()
  await Promise.all(
    keys.filter((k) => k.startsWith(AUDIO_CACHE_PREFIX)).map((k) => caches.delete(k)),
  )
}

// ─── Storage estimate ─────────────────────────────────────────────────────────

export interface StorageEstimate {
  available: number
  quota: number
  usage: number
}

/**
 * Returns available, quota, and usage in bytes.
 * Returns zeros if the StorageManager API is unavailable.
 */
export async function estimateStorage(): Promise<StorageEstimate> {
  if (!navigator.storage?.estimate) {
    return { available: 0, quota: 0, usage: 0 }
  }
  const { quota = 0, usage = 0 } = await navigator.storage.estimate()
  return { available: quota - usage, quota, usage }
}
