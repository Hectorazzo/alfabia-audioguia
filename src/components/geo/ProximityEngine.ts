import { haversine } from '@/lib/haversine'
import type { POI } from '@/lib/types'

// ─── Output types ─────────────────────────────────────────────────────────────

export interface POIWithDistance extends POI {
  /** Straight-line distance from the user in metres */
  distanceM: number
}

export interface ProximityResult {
  /** POIs whose effective activation radius contains the user, sorted by distance */
  nearby: POIWithDistance[]
  /**
   * When the user is within range of a bifurcation node (POI 8), this holds
   * the two target POIs that should be shown as simultaneous dual-card suggestions.
   * null at all other times.
   */
  bifurcationSuggestions: [POI, POI] | null
}

// ─── Radius expansion for weak GPS signal ────────────────────────────────────

const WEAK_SIGNAL_THRESHOLD_M = 50

/**
 * Expands a POI's nominal activation radius to account for GPS uncertainty.
 * When accuracy > 50 m the reported position could be anywhere inside that
 * circle, so we absorb the full accuracy value into the radius.
 */
function effectiveRadius(nominalRadius: number, accuracy: number): number {
  return accuracy > WEAK_SIGNAL_THRESHOLD_M
    ? nominalRadius + accuracy
    : nominalRadius
}

// ─── Engine ──────────────────────────────────────────────────────────────────

/**
 * Pure function — no side effects.
 *
 * @param userLat  User latitude (degrees)
 * @param userLng  User longitude (degrees)
 * @param accuracy GPS accuracy in metres (from Geolocation API)
 * @param pois     Full list of 18 POIs
 */
export function computeProximity(
  userLat: number,
  userLng: number,
  accuracy: number,
  pois: POI[],
): ProximityResult {
  // 1. Compute distance to every POI
  const withDistances: POIWithDistance[] = pois.map((poi) => ({
    ...poi,
    distanceM: haversine(userLat, userLng, poi.latitude, poi.longitude),
  }))

  // 2. Filter to those inside their effective activation radius
  const nearby = withDistances
    .filter(
      (poi) =>
        poi.distanceM <= effectiveRadius(poi.activationRadiusM, accuracy),
    )
    .sort((a, b) => a.distanceM - b.distanceM)

  // 3. Bifurcation check — POI 8 (is_bifurcation=true) triggers dual suggestion
  const activeBifurcation = nearby.find((poi) => poi.isBifurcation)
  let bifurcationSuggestions: ProximityResult['bifurcationSuggestions'] = null

  if (activeBifurcation?.bifurcationTargets && activeBifurcation.bifurcationTargets.length >= 2) {
    const [targetA, targetB] = activeBifurcation.bifurcationTargets
    const poiA = pois.find((p) => p.number === targetA)
    const poiB = pois.find((p) => p.number === targetB)

    if (poiA && poiB) {
      bifurcationSuggestions = [poiA, poiB]
    }
  }

  return { nearby, bifurcationSuggestions }
}
