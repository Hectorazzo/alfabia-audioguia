import { useEffect, useMemo } from 'react'
import { useAppStore } from '@/stores/useAppStore'
import { computeProximity, type POIWithDistance, type ProximityResult } from '@/components/geo/ProximityEngine'
import type { POI } from '@/lib/types'

const WEAK_SIGNAL_THRESHOLD_M = 50

interface UseProximityResult {
  /** Nearby POIs with their computed distances, sorted closest-first */
  nearby: POIWithDistance[]
  /**
   * Two POIs to display as simultaneous dual-card suggestions when the user
   * is near a bifurcation node (POI 8). null otherwise.
   */
  bifurcationSuggestions: ProximityResult['bifurcationSuggestions']
  /** True when GPS accuracy > 50 m — caller should show "GPS impreciso" badge */
  isWeakSignal: boolean
}

/**
 * Runs the proximity engine whenever the user's GPS position changes and
 * keeps `useAppStore.nearbyPOIs` in sync. Returns the full result including
 * per-POI distances and bifurcation suggestions.
 *
 * @param pois  Full list of POIs (typically fetched once from Supabase)
 */
export function useProximity(pois: POI[]): UseProximityResult {
  const userPosition = useAppStore((s) => s.userPosition)
  const setNearbyPOIs = useAppStore((s) => s.setNearbyPOIs)

  const result = useMemo<ProximityResult>(() => {
    if (!userPosition || pois.length === 0) {
      return { nearby: [], bifurcationSuggestions: null }
    }
    return computeProximity(
      userPosition.lat,
      userPosition.lng,
      userPosition.accuracy,
      pois,
    )
  }, [userPosition, pois])

  // Keep the store in sync so other parts of the app (e.g. BottomNav badge)
  // can subscribe to nearbyPOIs without prop-drilling.
  useEffect(() => {
    // Strip distanceM — the store holds plain POI objects
    const plainPOIs: POI[] = result.nearby.map(({ distanceM: _d, ...poi }) => poi)
    setNearbyPOIs(plainPOIs)
  }, [result.nearby, setNearbyPOIs])

  const isWeakSignal =
    userPosition !== null && userPosition.accuracy > WEAK_SIGNAL_THRESHOLD_M

  return {
    nearby: result.nearby,
    bifurcationSuggestions: result.bifurcationSuggestions,
    isWeakSignal,
  }
}
