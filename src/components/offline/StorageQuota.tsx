import type { Language } from '@/lib/types'
import { LOW_SPACE_THRESHOLD_BYTES } from '@/services/audioService'

interface StorageQuotaProps {
  availableBytes: number
  language: Language
}

function formatBytes(bytes: number): string {
  if (bytes <= 0) return '0 MB'
  if (bytes < 1_048_576) return `${Math.round(bytes / 1024)} KB`
  return `${Math.round(bytes / 1_048_576)} MB`
}

const COPY: Record<Language, { available: string; low: string }> = {
  es: { available: 'disponible', low: 'Espacio bajo — puede que no quepa todo' },
  en: { available: 'available', low: 'Low space — download may not complete' },
  de: { available: 'verfügbar', low: 'Wenig Speicher — Download evtl. unvollständig' },
  ca: { available: 'disponible', low: 'Poc espai — pot ser que no hi càpiga tot' },
  fr: { available: 'disponible', low: 'Peu d\'espace — le téléchargement peut échouer' },
}

export default function StorageQuota({ availableBytes, language }: StorageQuotaProps) {
  if (availableBytes <= 0) return null

  const isLow = availableBytes < LOW_SPACE_THRESHOLD_BYTES
  const copy = COPY[language]

  return (
    <p className={`text-xs text-center ${isLow ? 'text-amber-600 font-medium' : 'text-alfabia-text-muted'}`}>
      {isLow ? `⚠ ${copy.low}` : `${formatBytes(availableBytes)} ${copy.available}`}
    </p>
  )
}
