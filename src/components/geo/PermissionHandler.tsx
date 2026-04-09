import { useState } from 'react'
import { MapPin, Navigation, AlertTriangle, WifiOff } from 'lucide-react'
import { useGeolocation } from '@/hooks/useGeolocation'
import { useAppStore } from '@/stores/useAppStore'
import type { Language } from '@/lib/types'

// ─── UI copy ─────────────────────────────────────────────────────────────────

const COPY = {
  es: {
    preTitle: 'Explora el jardín con GPS',
    preDesc:
      'Para sugerirte los puntos más cercanos a medida que recorres el jardín necesitamos acceder a tu ubicación.',
    preButton: 'Activar ubicación',
    preSkip: 'Continuar sin GPS',
    requestingTitle: 'Esperando permiso…',
    requestingDesc: 'Acepta el permiso de ubicación en la ventana del navegador.',
    deniedTitle: 'Ubicación desactivada',
    deniedDesc:
      'Puedes seguir usando la audioguía manualmente. Si cambias de opinión, activa la ubicación en los ajustes de tu navegador.',
    unavailableTitle: 'Señal GPS débil',
    unavailableDesc:
      'No se puede obtener tu posición en este momento. Puedes seguir navegando manualmente.',
    weakBadge: 'GPS impreciso — sugerencias aproximadas',
  },
  en: {
    preTitle: 'Explore the garden with GPS',
    preDesc:
      'To suggest the nearest stops as you walk through the garden, we need access to your location.',
    preButton: 'Enable location',
    preSkip: 'Continue without GPS',
    requestingTitle: 'Waiting for permission…',
    requestingDesc: 'Accept the location permission in the browser prompt.',
    deniedTitle: 'Location disabled',
    deniedDesc:
      'You can still use the audio guide manually. If you change your mind, enable location in your browser settings.',
    unavailableTitle: 'Weak GPS signal',
    unavailableDesc:
      'Your position cannot be determined right now. You can still browse manually.',
    weakBadge: 'Imprecise GPS — approximate suggestions',
  },
  de: {
    preTitle: 'Garten mit GPS erkunden',
    preDesc:
      'Um dir die nächsten Punkte während des Rundgangs vorzuschlagen, benötigen wir Zugriff auf deinen Standort.',
    preButton: 'Standort aktivieren',
    preSkip: 'Ohne GPS fortfahren',
    requestingTitle: 'Warte auf Erlaubnis…',
    requestingDesc: 'Bestätige die Standortanfrage im Browser-Fenster.',
    deniedTitle: 'Standort deaktiviert',
    deniedDesc:
      'Du kannst den Audioguide weiterhin manuell nutzen. Aktiviere den Standort in deinen Browsereinstellungen.',
    unavailableTitle: 'Schwaches GPS-Signal',
    unavailableDesc:
      'Dein Standort kann momentan nicht ermittelt werden. Du kannst weiterhin manuell navigieren.',
    weakBadge: 'Ungenauer GPS — ungefähre Vorschläge',
  },
  ca: {
    preTitle: 'Explora el jardí amb GPS',
    preDesc:
      "Per suggerir-te els punts més propers mentre recorres el jardí, necessitem accedir a la teva ubicació.",
    preButton: 'Activar ubicació',
    preSkip: 'Continuar sense GPS',
    requestingTitle: 'Esperant permís…',
    requestingDesc: "Accepta el permís d'ubicació a la finestra del navegador.",
    deniedTitle: 'Ubicació desactivada',
    deniedDesc:
      "Pots continuar usant l'audioguia manualment. Si canvies d'opinió, activa la ubicació als ajustos del navegador.",
    unavailableTitle: 'Senyal GPS dèbil',
    unavailableDesc:
      'No es pot obtenir la teva posició en aquest moment. Pots seguir navegant manualment.',
    weakBadge: 'GPS imprecís — suggeriments aproximats',
  },
  fr: {
    preTitle: 'Explorez le jardin avec le GPS',
    preDesc:
      "Pour vous suggérer les points les plus proches au fil de votre visite, nous avons besoin d'accéder à votre position.",
    preButton: 'Activer la localisation',
    preSkip: 'Continuer sans GPS',
    requestingTitle: 'En attente de permission…',
    requestingDesc: "Acceptez la demande de localisation dans la fenêtre du navigateur.",
    deniedTitle: 'Localisation désactivée',
    deniedDesc:
      "Vous pouvez toujours utiliser l'audioguide manuellement. Si vous changez d'avis, activez la localisation dans les paramètres de votre navigateur.",
    unavailableTitle: 'Signal GPS faible',
    unavailableDesc:
      "Votre position ne peut pas être déterminée pour l'instant. Vous pouvez continuer à naviguer manuellement.",
    weakBadge: 'GPS imprécis — suggestions approximatives',
  },
} satisfies Record<Language, Record<string, string>>

// ─── Sub-screens ──────────────────────────────────────────────────────────────

interface PrePermissionScreenProps {
  language: Language
  onActivate: () => void
  onSkip: () => void
}

function PrePermissionScreen({ language, onActivate, onSkip }: PrePermissionScreenProps) {
  const c = COPY[language]
  return (
    <div className="flex flex-col items-center justify-center gap-6 px-8 py-16 text-center">
      <div className="w-16 h-16 rounded-full bg-alfabia-green/10 flex items-center justify-center">
        <MapPin className="w-8 h-8 text-alfabia-green" />
      </div>
      <div className="space-y-2">
        <h2 className="font-display text-xl text-alfabia-green-dark">{c.preTitle}</h2>
        <p className="text-sm text-alfabia-text-muted leading-relaxed">{c.preDesc}</p>
      </div>
      <div className="w-full flex flex-col gap-3">
        <button
          type="button"
          onClick={onActivate}
          className="w-full py-3 px-6 bg-alfabia-green text-alfabia-cream text-sm font-medium rounded-xl transition-colors active:bg-alfabia-green-dark focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-offset-2 focus-visible:ring-alfabia-green"
        >
          {c.preButton}
        </button>
        <button
          type="button"
          onClick={onSkip}
          className="w-full py-2 px-6 text-sm text-alfabia-text-muted underline underline-offset-2"
        >
          {c.preSkip}
        </button>
      </div>
    </div>
  )
}

function RequestingScreen({ language }: { language: Language }) {
  const c = COPY[language]
  return (
    <div className="flex flex-col items-center justify-center gap-4 px-8 py-16 text-center">
      <Navigation className="w-10 h-10 text-alfabia-green animate-pulse" />
      <div className="space-y-1">
        <p className="font-medium text-alfabia-text">{c.requestingTitle}</p>
        <p className="text-sm text-alfabia-text-muted">{c.requestingDesc}</p>
      </div>
    </div>
  )
}

// ─── Non-blocking notice (denied / unavailable) ───────────────────────────────

interface NoticeProps {
  language: Language
  variant: 'denied' | 'unavailable'
}

function GpsNotice({ language, variant }: NoticeProps) {
  const c = COPY[language]
  const title = variant === 'denied' ? c.deniedTitle : c.unavailableTitle
  const desc = variant === 'denied' ? c.deniedDesc : c.unavailableDesc
  const Icon = variant === 'denied' ? AlertTriangle : WifiOff

  return (
    <div className="mx-4 mt-4 flex items-start gap-3 rounded-xl border border-alfabia-border bg-white px-4 py-3">
      <Icon className="mt-0.5 w-4 h-4 shrink-0 text-alfabia-accent" />
      <div className="space-y-0.5">
        <p className="text-xs font-semibold text-alfabia-text">{title}</p>
        <p className="text-xs text-alfabia-text-muted leading-snug">{desc}</p>
      </div>
    </div>
  )
}

// ─── Weak-signal badge ────────────────────────────────────────────────────────

function WeakSignalBadge({ language }: { language: Language }) {
  return (
    <div className="mx-4 mt-3 flex items-center gap-1.5 rounded-lg bg-amber-50 border border-amber-200 px-3 py-2">
      <Navigation className="w-3.5 h-3.5 text-amber-600 shrink-0" />
      <span className="text-xs text-amber-700 font-medium">{COPY[language].weakBadge}</span>
    </div>
  )
}

// ─── PermissionHandler ───────────────────────────────────────────────────────

interface PermissionHandlerProps {
  children: React.ReactNode
}

/**
 * Manages the GPS permission UX flow:
 *
 * idle        → PrePermissionScreen (custom UI before the native browser prompt)
 * requesting  → RequestingScreen (waiting for browser response)
 * granted     → renders children; shows WeakSignalBadge when accuracy > 50 m
 * denied      → renders children with a non-blocking denial notice
 * unavailable → renders children with a non-blocking unavailability notice
 *
 * This component owns the geolocation watcher for the app — mount it once
 * high in the tree. All other components read position from useAppStore.
 */
export default function PermissionHandler({ children }: PermissionHandlerProps) {
  const language = useAppStore((s) => s.language)
  const userPosition = useAppStore((s) => s.userPosition)
  const { permissionState, startWatching } = useGeolocation()

  // Track whether the user explicitly chose to skip GPS
  const [skipped, setSkipped] = useState(false)

  const isWeakSignal = userPosition !== null && userPosition.accuracy > 50

  if (permissionState === 'idle' && !skipped) {
    return (
      <PrePermissionScreen
        language={language}
        onActivate={startWatching}
        onSkip={() => setSkipped(true)}
      />
    )
  }

  if (permissionState === 'requesting') {
    return <RequestingScreen language={language} />
  }

  return (
    <>
      {permissionState === 'denied' && (
        <GpsNotice language={language} variant="denied" />
      )}
      {permissionState === 'unavailable' && (
        <GpsNotice language={language} variant="unavailable" />
      )}
      {permissionState === 'granted' && isWeakSignal && (
        <WeakSignalBadge language={language} />
      )}
      {children}
    </>
  )
}

