import { useEffect } from 'react'
import { MapContainer, TileLayer, Marker, useMap } from 'react-leaflet'
import L from 'leaflet'
import 'leaflet/dist/leaflet.css'

// ─── Fix default icon paths broken by Vite's asset hashing ───────────────────
// We use a custom DivIcon so this is only needed as a safety net.
delete (L.Icon.Default.prototype as unknown as Record<string, unknown>)._getIconUrl

// ─── Custom Alfabia marker (avoids Vite asset path issues entirely) ───────────
const alfabiaMarker = L.divIcon({
  html: `<div style="
    width:20px;height:20px;border-radius:50%;
    background:#233B29;border:3px solid #F8F2E7;
    box-shadow:0 2px 8px rgba(0,0,0,0.35);
  "></div>`,
  iconSize: [20, 20],
  iconAnchor: [10, 10],
  className: '',
})

// ─── Inner component: invalidates map size after mount ───────────────────────
function MapInvalidator() {
  const map = useMap()
  useEffect(() => {
    // Small delay ensures the container has its final CSS dimensions
    const t = setTimeout(() => map.invalidateSize(), 100)
    return () => clearTimeout(t)
  }, [map])
  return null
}

// ─── Component ───────────────────────────────────────────────────────────────

interface MiniMapProps {
  latitude: number
  longitude: number
  poiName: string
}

export default function MiniMap({ latitude, longitude, poiName }: MiniMapProps) {
  const position: [number, number] = [latitude, longitude]

  return (
    <div className="rounded-xl overflow-hidden border border-alfabia-border" style={{ height: 180 }}>
      <MapContainer
        center={position}
        zoom={17}
        style={{ height: '100%', width: '100%' }}
        zoomControl={false}
        scrollWheelZoom={false}
        dragging={false}
        doubleClickZoom={false}
        touchZoom={false}
        keyboard={false}
        attributionControl={false}
      >
        <TileLayer
          url="https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png"
          attribution='&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a>'
        />
        <Marker position={position} icon={alfabiaMarker} title={poiName} />
        <MapInvalidator />
      </MapContainer>
    </div>
  )
}
