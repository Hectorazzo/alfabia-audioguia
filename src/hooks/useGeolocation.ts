import { useState, useEffect, useCallback, useRef } from 'react'
import { useAppStore } from '@/stores/useAppStore'

// ─── Types ───────────────────────────────────────────────────────────────────

export type GeolocationPermissionState =
  | 'idle'        // not yet requested
  | 'requesting'  // watchPosition started, awaiting first response
  | 'granted'     // at least one valid position received
  | 'denied'      // PERMISSION_DENIED or Permissions API says denied
  | 'unavailable' // POSITION_UNAVAILABLE, TIMEOUT, or no geolocation API

interface UseGeolocationResult {
  permissionState: GeolocationPermissionState
  error: GeolocationPositionError | null
  /** Call this when the user taps "Activar ubicación" in the pre-permission screen */
  startWatching: () => void
}

// ─── Geolocation options (from CLAUDE.md) ────────────────────────────────────

const GEO_OPTIONS: PositionOptions = {
  enableHighAccuracy: true,
  maximumAge: 5_000,  // reuse cached position up to 5 s
  timeout: 15_000,    // generous for 3G
}

// ─── Hook ─────────────────────────────────────────────────────────────────────

export function useGeolocation(): UseGeolocationResult {
  const setUserPosition = useAppStore((s) => s.setUserPosition)
  const [permissionState, setPermissionState] = useState<GeolocationPermissionState>('idle')
  const [error, setError] = useState<GeolocationPositionError | null>(null)
  const watchIdRef = useRef<number | null>(null)

  const startWatching = useCallback(() => {
    if (watchIdRef.current !== null) return // already watching
    if (!('geolocation' in navigator)) {
      setPermissionState('unavailable')
      return
    }

    setPermissionState('requesting')

    watchIdRef.current = navigator.geolocation.watchPosition(
      (pos) => {
        setPermissionState('granted')
        setError(null)
        setUserPosition({
          lat: pos.coords.latitude,
          lng: pos.coords.longitude,
          accuracy: pos.coords.accuracy,
        })
      },
      (err) => {
        setError(err)
        // PERMISSION_DENIED = 1, POSITION_UNAVAILABLE = 2, TIMEOUT = 3
        if (err.code === 1) {
          setPermissionState('denied')
          setUserPosition(null)
        } else {
          // POSITION_UNAVAILABLE or TIMEOUT — keep trying, but surface the state
          setPermissionState('unavailable')
        }
      },
      GEO_OPTIONS,
    )
  }, [setUserPosition])

  // On mount: query the Permissions API to detect already-granted/denied state
  // and auto-start if already granted (skips the pre-permission screen)
  useEffect(() => {
    if (!('geolocation' in navigator)) {
      setPermissionState('unavailable')
      return
    }

    if (!navigator.permissions) {
      // Permissions API unavailable — stay idle, wait for user to tap button
      return
    }

    let permStatus: PermissionStatus

    navigator.permissions
      .query({ name: 'geolocation' })
      .then((status) => {
        permStatus = status

        if (status.state === 'granted') {
          startWatching()
        } else if (status.state === 'denied') {
          setPermissionState('denied')
        }
        // 'prompt' → keep 'idle', show custom pre-permission screen

        // React to the user changing browser-level permission after the fact
        status.addEventListener('change', () => {
          if (status.state === 'granted') {
            startWatching()
          } else if (status.state === 'denied') {
            setPermissionState('denied')
            setUserPosition(null)
            if (watchIdRef.current !== null) {
              navigator.geolocation.clearWatch(watchIdRef.current)
              watchIdRef.current = null
            }
          }
        })
      })
      .catch(() => {
        // Permissions API threw (e.g. Firefox Private Mode) — stay idle
      })

    // No cleanup needed for the permission listener since permStatus is a
    // browser-managed object and the component teardown below handles the watcher
  }, [startWatching, setUserPosition])

  // Clean up the position watcher on unmount
  useEffect(() => {
    return () => {
      if (watchIdRef.current !== null) {
        navigator.geolocation.clearWatch(watchIdRef.current)
        watchIdRef.current = null
      }
    }
  }, [])

  return { permissionState, error, startWatching }
}
