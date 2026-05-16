import { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import mapaSvg from './mapa.svg?raw';

export default function MapComponent() {
  const [showExterior, setShowExterior] = useState(true);
  const navigate = useNavigate();

  const handlePOIClick = (poiId) => {
    console.log(`Clicked POI: ${poiId}`);
    navigate(`/poi/${poiId}`);
  };

  return (
    <div style={{ maxWidth: '100%', margin: '0 auto' }}>
      {/* Toggle Buttons */}
      <div style={{
        display: 'flex',
        gap: '12px',
        marginBottom: '16px',
        justifyContent: 'center'
      }}>
        <button
          onClick={() => setShowExterior(true)}
          style={{
            padding: '8px 16px',
            borderRadius: '8px',
            border: 'none',
            background: showExterior ? '#233B29' : '#E5E0D5',
            color: showExterior ? '#fff' : '#374151',
            cursor: 'pointer',
            fontWeight: 600,
            fontSize: '14px',
            transition: 'all 0.2s'
          }}
        >
          🌳 Jardines
        </button>
        <button
          onClick={() => setShowExterior(false)}
          style={{
            padding: '8px 16px',
            borderRadius: '8px',
            border: 'none',
            background: !showExterior ? '#233B29' : '#E5E0D5',
            color: !showExterior ? '#fff' : '#374151',
            cursor: 'pointer',
            fontWeight: 600,
            fontSize: '14px',
            transition: 'all 0.2s'
          }}
        >
          🏠 Casa
        </button>
      </div>

      {/* Map SVG */}
      <div
        style={{
          width: '100%',
          maxWidth: '600px',
          margin: '0 auto',
          border: '1px solid #E5E0D5',
          borderRadius: '12px',
          overflow: 'hidden',
          background: '#F8F2E7'
        }}
        dangerouslySetInnerHTML={{ __html: mapaSvg }}
        onClick={(e) => {
          const target = e.target;
          const poiWrapper = target.closest('[data-poi-id]');
          if (poiWrapper) {
            const poiId = poiWrapper.getAttribute('data-poi-id');
            handlePOIClick(poiId);
          }
        }}
      />

      {/* Styles for toggle */}
      <style>{`
        .map-layer {
          transition: opacity 0.3s ease;
        }
        .exterior-layer {
          opacity: ${showExterior ? '1' : '0.2'};
          pointer-events: ${showExterior ? 'auto' : 'none'};
        }
        .interior-layer {
          opacity: ${!showExterior ? '1' : '0.2'};
          pointer-events: ${!showExterior ? 'auto' : 'none'};
        }
        .poi-marker {
          cursor: pointer;
          transition: all 0.2s;
        }
        .poi-marker:hover circle {
          r: 16;
          filter: drop-shadow(0 0 8px rgba(35, 59, 41, 0.6));
        }
      `}</style>
    </div>
  );
}
