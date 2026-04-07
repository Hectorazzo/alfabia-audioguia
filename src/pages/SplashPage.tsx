import { useEffect, useState } from 'react'
import { useNavigate } from 'react-router-dom'

export default function SplashPage() {
  const navigate = useNavigate()
  const [visible, setVisible] = useState(false)

  useEffect(() => {
    // Trigger fade-in on next frame
    const fadeTimer = requestAnimationFrame(() => setVisible(true))

    const redirectTimer = setTimeout(() => {
      navigate('/language', { replace: true })
    }, 2000)

    return () => {
      cancelAnimationFrame(fadeTimer)
      clearTimeout(redirectTimer)
    }
  }, [navigate])

  return (
    <div className="flex min-h-svh flex-col items-center justify-center bg-alfabia-green">
      <div
        style={{
          opacity: visible ? 1 : 0,
          transform: visible ? 'translateY(0)' : 'translateY(12px)',
          transition: 'opacity 0.8s ease, transform 0.8s ease',
        }}
        className="flex flex-col items-center gap-6"
      >
        {/* Logo placeholder — replace with real SVG asset when available */}
        <LogoMark />

        <div className="flex flex-col items-center gap-1 text-center">
          <p className="font-display text-3xl font-light tracking-widest text-alfabia-cream">
            Jardines de Alfabia
          </p>
          <p className="text-xs tracking-[0.3em] text-alfabia-cream/60 uppercase">
            Audioguía
          </p>
        </div>
      </div>
    </div>
  )
}

function LogoMark() {
  return (
    <svg
      width="80"
      height="80"
      viewBox="0 0 80 80"
      fill="none"
      xmlns="http://www.w3.org/2000/svg"
      aria-label="Jardines de Alfabia"
      role="img"
    >
      {/* Circular border */}
      <circle cx="40" cy="40" r="38" stroke="#F8F2E7" strokeWidth="1.5" strokeOpacity="0.4" />
      {/* Letter A */}
      <text
        x="40"
        y="56"
        textAnchor="middle"
        fontFamily="Georgia, serif"
        fontSize="42"
        fontWeight="300"
        fill="#F8F2E7"
      >
        A
      </text>
    </svg>
  )
}
