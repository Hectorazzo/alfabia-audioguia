import { useState, useEffect } from 'react'
import { useNavigate } from 'react-router-dom'
import { useProgressStore } from '@/stores/useProgressStore'
import { trackMapView } from '@/services/analyticsService'
import mapaUrl from '@/assets/mapa.svg'
import './MapComponent.css'

type ViewMode = 'exterior' | 'interior'

export default function MapComponent() {
  const navigate = useNavigate()
  const [view, setView] = useState<ViewMode>('exterior')
  const [svgContent, setSvgContent] = useState<string>('')

  useEffect(() => {
    trackMapView()
    fetch(mapaUrl)
      .then((r) => r.text())
      .then((content) => setSvgContent(content))
      .catch((e) => console.error('Error loading map:', e))
  }, [])

  const handlePOIClick = (e: React.MouseEvent<HTMLDivElement>) => {
    const target = e.target as HTMLElement
    const poiWrapper = target.closest('[data-poi-id]') as HTMLElement | null
    if (poiWrapper) {
      const poiId = poiWrapper.getAttribute('data-poi-id')
      if (poiId) {
        navigate(`/poi/${poiId}`)
      }
    }
  }

  return (
    <div className="map-container">
      <div className="map-toggle">
        <button
          onClick={() => setView('exterior')}
          className={`toggle-btn ${view === 'exterior' ? 'active' : ''}`}
        >
          🌳 Jardines
        </button>
        <button
          onClick={() => setView('interior')}
          className={`toggle-btn ${view === 'interior' ? 'active' : ''}`}
        >
          🏠 Casa
        </button>
      </div>

      {svgContent && (
        <div
          className="map-wrapper"
          data-view={view}
          onClick={handlePOIClick}
          dangerouslySetInnerHTML={{ __html: svgContent }}
        />
      )}

      <div className="map-legend">
        <div className="legend-item">
          <span className="legend-color" style={{ backgroundColor: '#9CA3AF' }} />
          <span>No visitado</span>
        </div>
        <div className="legend-item">
          <span className="legend-color" style={{ backgroundColor: '#233B29' }} />
          <span>Escuchado</span>
        </div>
        <div className="legend-item">
          <span className="legend-color" style={{ backgroundColor: '#EF4444' }} />
          <span>Favorito</span>
        </div>
      </div>
    </div>
  )
}