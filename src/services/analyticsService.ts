import { supabase } from '@/services/supabase'

// ─── Types ────────────────────────────────────────────────────────────────────

type EventType =
  | 'audio_play'
  | 'audio_complete'
  | 'poi_view'
  | 'language_select'
  | 'session_start'
  | 'session_end'
  | 'offline_download'
  | 'map_view'

interface AnalyticsEvent {
  event_type: EventType
  poi_number: number | null
  language: string | null
  duration_listened_seconds: number | null
  session_id: string
  device_type: 'ios' | 'android' | 'desktop' | null
}

// ─── Session ID (unique per browser tab visit) ────────────────────────────────

const SESSION_KEY = 'alfabia-session-id'
const QUEUE_KEY   = 'alfabia-analytics-queue'

function getOrCreateSessionId(): string {
  const existing = sessionStorage.getItem(SESSION_KEY)
  if (existing) return existing
  const id = crypto.randomUUID()
  sessionStorage.setItem(SESSION_KEY, id)
  return id
}

// ─── Device detection ─────────────────────────────────────────────────────────

function detectDeviceType(): 'ios' | 'android' | 'desktop' {
  const ua = navigator.userAgent
  if (/iphone|ipad|ipod/i.test(ua)) return 'ios'
  if (/android/i.test(ua)) return 'android'
  return 'desktop'
}

// ─── Offline queue (localStorage) ─────────────────────────────────────────────

function getQueue(): AnalyticsEvent[] {
  try {
    const raw = localStorage.getItem(QUEUE_KEY)
    return raw ? (JSON.parse(raw) as AnalyticsEvent[]) : []
  } catch {
    return []
  }
}

function saveQueue(queue: AnalyticsEvent[]): void {
  try {
    localStorage.setItem(QUEUE_KEY, JSON.stringify(queue))
  } catch {
    // Storage full — silently skip
  }
}

function enqueue(event: AnalyticsEvent): void {
  const queue = getQueue()
  queue.push(event)
  saveQueue(queue)
}

async function flushQueue(): Promise<void> {
  const queue = getQueue()
  if (queue.length === 0) return
  const { error } = await supabase.from('analytics_events').insert(queue)
  if (!error) saveQueue([])
}

// Flush queued events when connectivity is restored
if (typeof window !== 'undefined') {
  window.addEventListener('online', () => { void flushQueue() })
}

// ─── Core function ────────────────────────────────────────────────────────────

export async function trackEvent(
  eventType: EventType,
  extras: {
    poiNumber?: number | null
    language?: string | null
    durationListenedSeconds?: number | null
  } = {},
): Promise<void> {
  const event: AnalyticsEvent = {
    event_type: eventType,
    poi_number: extras.poiNumber ?? null,
    language: extras.language ?? null,
    duration_listened_seconds: extras.durationListenedSeconds ?? null,
    session_id: getOrCreateSessionId(),
    device_type: detectDeviceType(),
  }

  if (!navigator.onLine) {
    enqueue(event)
    return
  }

  const { error } = await supabase.from('analytics_events').insert(event)
  if (error) {
    // Network failed despite onLine — queue for retry
    enqueue(event)
  }
}

// ─── Convenience wrappers ─────────────────────────────────────────────────────

export function trackAudioPlay(poiNumber: number, lang: string): void {
  void trackEvent('audio_play', { poiNumber, language: lang })
}

export function trackAudioComplete(poiNumber: number, lang: string, durationSeconds: number): void {
  void trackEvent('audio_complete', { poiNumber, language: lang, durationListenedSeconds: durationSeconds })
}

export function trackPOIView(poiNumber: number): void {
  void trackEvent('poi_view', { poiNumber })
}

export function trackLanguageSelect(lang: string): void {
  void trackEvent('language_select', { language: lang })
}

export function trackSessionStart(): void {
  void trackEvent('session_start')
}

export function trackSessionEnd(): void {
  void trackEvent('session_end')
}

export function trackOfflineDownload(lang: string): void {
  void trackEvent('offline_download', { language: lang })
}

export function trackMapView(): void {
  void trackEvent('map_view')
}
