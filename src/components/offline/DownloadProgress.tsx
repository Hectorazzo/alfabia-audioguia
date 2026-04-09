import type { Language } from '@/lib/types'

interface DownloadProgressProps {
  current: number
  total: number
  progress: number // 0–100
  language: Language
}

const COPY: Record<Language, { label: string }> = {
  es: { label: 'descargando' },
  en: { label: 'downloading' },
  de: { label: 'wird geladen' },
  ca: { label: 'descarregant' },
  fr: { label: 'en cours' },
}

export default function DownloadProgress({
  current,
  total,
  progress,
  language,
}: DownloadProgressProps) {
  const { label } = COPY[language]

  return (
    <div className="flex flex-col gap-1.5 w-full">
      <div className="flex items-center justify-between">
        <span className="flex items-center gap-2 text-sm font-medium text-alfabia-green">
          <span
            aria-hidden="true"
            className="w-3.5 h-3.5 rounded-full border-2 border-alfabia-green border-t-transparent animate-spin shrink-0"
          />
          Audio {current}/{total} {label}…
        </span>
        <span className="text-xs tabular-nums text-alfabia-text-muted">
          {Math.round(progress)}%
        </span>
      </div>

      <div
        role="progressbar"
        aria-valuenow={Math.round(progress)}
        aria-valuemin={0}
        aria-valuemax={100}
        className="h-1.5 bg-alfabia-border rounded-full overflow-hidden"
      >
        <div
          className="h-full bg-alfabia-green rounded-full transition-all duration-300"
          style={{ width: `${progress}%` }}
        />
      </div>
    </div>
  )
}
