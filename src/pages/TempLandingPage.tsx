const PDF_BASE = 'https://www.jardinesdealfabia.com/qr'

const languages = [
  { label: 'Español', slug: 'es' },
  { label: 'English', slug: 'en' },
  { label: 'Deutsch', slug: 'de' },
  { label: 'Français', slug: 'fr' },
  { label: 'Català', slug: 'ca' },
]

export default function TempLandingPage() {
  return (
    <div
      className="min-h-screen flex flex-col items-center justify-between px-6 py-12"
      style={{ backgroundColor: '#F8F2E7' }}
    >
      {/* Logo */}
      <div className="flex-1 flex flex-col items-center justify-center w-full max-w-sm md:max-w-xl gap-10">
        {/* Vertical logo — mobile only */}
        <img
          src="/Alfabia_Vertical_Positivo.png"
          alt="Jardines de Alfabia"
          className="block md:hidden w-40"
        />
        {/* Horizontal logo — desktop only */}
        <img
          src="/Alfabia_Horizontal_Positivo.png"
          alt="Jardines de Alfabia"
          className="hidden md:block w-72"
        />

        {/* Subtitle */}
        <p
          className="text-center text-lg tracking-widest uppercase"
          style={{
            fontFamily: '"Teodor", "Playfair Display", Georgia, serif',
            color: '#233B29',
            letterSpacing: '0.15em',
          }}
        >
          Guía del visitante · Visitor guide
        </p>

        {/* Language buttons */}
        <div className="flex flex-col gap-3 w-full">
          {languages.map(({ label, slug }) => (
            <a
              key={slug}
              href={`${PDF_BASE}/guia-del-visitante-${slug}.pdf`}
              target="_blank"
              rel="noopener noreferrer"
              className="group w-full text-center py-3 px-6 border transition-colors duration-200 text-sm tracking-widest uppercase"
              style={{
                fontFamily: '"Teodor", "Playfair Display", Georgia, serif',
                borderColor: '#233B29',
                color: '#233B29',
                backgroundColor: 'transparent',
              }}
              onMouseEnter={e => {
                const el = e.currentTarget
                el.style.backgroundColor = '#233B29'
                el.style.color = '#F8F2E7'
              }}
              onMouseLeave={e => {
                const el = e.currentTarget
                el.style.backgroundColor = 'transparent'
                el.style.color = '#233B29'
              }}
            >
              {label}
            </a>
          ))}
        </div>
      </div>

      {/* Footer */}
      <p
        className="mt-12 text-center text-xs"
        style={{
          color: '#6B7280',
          fontFamily: 'system-ui, sans-serif',
          letterSpacing: '0.02em',
          lineHeight: '1.6',
        }}
      >
        Próximamente: audioguía digital interactiva
        <br />
        Coming soon: interactive digital audioguide
      </p>
    </div>
  )
}
