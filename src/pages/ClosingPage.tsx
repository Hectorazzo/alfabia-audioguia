import { useEffect } from 'react'
import { useNavigate } from 'react-router-dom'
import { Star, CalendarDays, MapPin, Phone, Globe, Home, Leaf } from 'lucide-react'
import { useAppStore } from '@/stores/useAppStore'
import { trackSessionEnd } from '@/services/analyticsService'
import type { Language } from '@/lib/types'

// ─── UI copy ─────────────────────────────────────────────────────────────────

const COPY = {
  es: {
    farewell:       'Hasta pronto',
    farewellSub:    'Gracias por visitar los Jardines de Alfabia.',
    farewellBody:   'Esperamos que este paseo os haya regalado un poco de la historia, la belleza y la tranquilidad que hacen de Alfabia un lugar único en Mallorca. Os esperamos de nuevo.',
    reviewTitle:    'Compartid vuestra experiencia',
    reviewBody:     'Vuestras valoraciones ayudan a otros viajeros a descubrir este rincón de la isla y nos permiten seguir cuidando este patrimonio.',
    reviewButton:   'Valorar en Google',
    eventsTitle:    'Alfabia para vuestros eventos',
    eventsBody:     'Los jardines y las dependencias de la finca están disponibles para celebraciones privadas: bodas, comuniones, reuniones de empresa y actos culturales. A lo largo del año organizamos también conciertos al atardecer y visitas guiadas temáticas.',
    eventsContact:  'Consultar disponibilidad',
    contactTitle:   'Cómo llegar',
    addressLine:    'Ctra. de Sóller, km 17 · Bunyola, Mallorca',
    hoursLine:      'Abierto todos los días · Consultar horarios en web',
    backButton:     'Volver al inicio',
  },
  en: {
    farewell:       'Until next time',
    farewellSub:    'Thank you for visiting Jardines de Alfabia.',
    farewellBody:   'We hope this walk has given you a glimpse of the history, beauty and tranquillity that make Alfabia a unique place in Mallorca. We look forward to welcoming you again.',
    reviewTitle:    'Share your experience',
    reviewBody:     'Your reviews help other travellers discover this corner of the island and allow us to continue caring for this heritage.',
    reviewButton:   'Review on Google',
    eventsTitle:    'Alfabia for your events',
    eventsBody:     'The gardens and estate buildings are available for private celebrations: weddings, corporate events, and cultural gatherings. Throughout the year we also host sunset concerts and themed guided tours.',
    eventsContact:  'Check availability',
    contactTitle:   'How to get here',
    addressLine:    'Ctra. de Sóller, km 17 · Bunyola, Mallorca',
    hoursLine:      'Open every day · Check hours on our website',
    backButton:     'Back to home',
  },
  de: {
    farewell:       'Bis zum nächsten Mal',
    farewellSub:    'Vielen Dank für Ihren Besuch in den Jardines de Alfabia.',
    farewellBody:   'Wir hoffen, dass dieser Spaziergang Ihnen einen Einblick in die Geschichte, Schönheit und Ruhe gegeben hat, die Alfabia zu einem einzigartigen Ort auf Mallorca machen. Wir freuen uns auf Ihren nächsten Besuch.',
    reviewTitle:    'Teilen Sie Ihre Erfahrung',
    reviewBody:     'Ihre Bewertungen helfen anderen Reisenden, diesen Ort zu entdecken, und ermöglichen es uns, dieses Kulturerbe zu pflegen.',
    reviewButton:   'Auf Google bewerten',
    eventsTitle:    'Alfabia für Ihre Veranstaltungen',
    eventsBody:     'Die Gärten und Gebäude stehen für private Feiern zur Verfügung: Hochzeiten, Firmenevents und Kulturveranstaltungen. Im Laufe des Jahres veranstalten wir auch Abendkonzerte und thematische Führungen.',
    eventsContact:  'Verfügbarkeit prüfen',
    contactTitle:   'Anfahrt',
    addressLine:    'Ctra. de Sóller, km 17 · Bunyola, Mallorca',
    hoursLine:      'Täglich geöffnet · Öffnungszeiten auf der Website',
    backButton:     'Zurück zur Startseite',
  },
  ca: {
    farewell:       'Fins aviat',
    farewellSub:    'Gràcies per visitar els Jardins de Alfabia.',
    farewellBody:   'Esperem que aquest passeig us hagi regalat una mica de la història, la bellesa i la tranquil·litat que fan d\'Alfabia un lloc únic a Mallorca. Us esperem de nou.',
    reviewTitle:    'Compartiu la vostra experiència',
    reviewBody:     'Les vostres valoracions ajuden altres viatgers a descobrir aquest racó de l\'illa i ens permeten continuar cuidant aquest patrimoni.',
    reviewButton:   'Valorar a Google',
    eventsTitle:    'Alfabia per als vostres esdeveniments',
    eventsBody:     'Els jardins i les dependències de la finca estan disponibles per a celebracions privades: casaments, comunions, reunions d\'empresa i actes culturals. Al llarg de l\'any organitzem concerts al capvespre i visites guiades temàtiques.',
    eventsContact:  'Consultar disponibilitat',
    contactTitle:   'Com arribar-hi',
    addressLine:    'Ctra. de Sóller, km 17 · Bunyola, Mallorca',
    hoursLine:      'Obert tots els dies · Consultar horaris al web',
    backButton:     'Tornar a l\'inici',
  },
  fr: {
    farewell:       'À bientôt',
    farewellSub:    'Merci d\'avoir visité les Jardins de Alfabia.',
    farewellBody:   'Nous espérons que cette promenade vous a offert un aperçu de l\'histoire, de la beauté et de la tranquillité qui font d\'Alfabia un lieu unique à Majorque. Nous espérons vous accueillir à nouveau.',
    reviewTitle:    'Partagez votre expérience',
    reviewBody:     'Vos avis aident d\'autres voyageurs à découvrir ce lieu et nous permettent de continuer à préserver ce patrimoine.',
    reviewButton:   'Laisser un avis sur Google',
    eventsTitle:    'Alfabia pour vos événements',
    eventsBody:     'Les jardins et les bâtiments sont disponibles pour des célébrations privées : mariages, événements d\'entreprise et manifestations culturelles. Tout au long de l\'année, nous organisons également des concerts au coucher du soleil et des visites guidées thématiques.',
    eventsContact:  'Vérifier les disponibilités',
    contactTitle:   'Comment s\'y rendre',
    addressLine:    'Ctra. de Sóller, km 17 · Bunyola, Mallorca',
    hoursLine:      'Ouvert tous les jours · Consulter les horaires sur le site',
    backButton:     'Retour à l\'accueil',
  },
} satisfies Record<Language, Record<string, string>>

// Google Reviews URL — replace PLACEHOLDER with the real Google Place ID
// Found in Google Maps: share → copy link → extract the CID or use Place ID from Places API
const GOOGLE_REVIEW_URL = 'https://g.page/r/PLACEHOLDER_REPLACE_WITH_REAL_PLACE_ID/review'
const WEBSITE_URL       = 'https://www.jardinesdealfabia.com'

// ─── Section card ─────────────────────────────────────────────────────────────

function Section({
  icon,
  title,
  children,
}: {
  icon: React.ReactNode
  title: string
  children: React.ReactNode
}) {
  return (
    <div className="bg-white rounded-2xl border border-alfabia-border px-5 py-4 space-y-3">
      <div className="flex items-center gap-2.5">
        <span className="text-alfabia-green">{icon}</span>
        <h2 className="font-display text-base text-alfabia-green-dark">{title}</h2>
      </div>
      {children}
    </div>
  )
}

// ─── ClosingPage ─────────────────────────────────────────────────────────────

export default function ClosingPage() {
  const navigate = useNavigate()
  const language = useAppStore((s) => s.language)
  const c = COPY[language]

  useEffect(() => { trackSessionEnd() }, [])

  return (
    <div className="flex flex-col min-h-full pb-6">

      {/* ── Hero farewell ──────────────────────────────────────────────────── */}
      <div
        className="flex flex-col items-center justify-center gap-4 px-6 py-14 text-center"
        style={{
          background: 'linear-gradient(160deg, #1A2C1F 0%, #233B29 60%, #2E4D36 100%)',
        }}
      >
        <div className="w-16 h-16 rounded-full bg-white/10 flex items-center justify-center">
          <Leaf className="w-8 h-8 text-alfabia-cream" />
        </div>
        <div className="space-y-2">
          <h1 className="font-display text-3xl text-alfabia-cream">{c.farewell}</h1>
          <p className="text-sm font-medium text-alfabia-cream/80">{c.farewellSub}</p>
        </div>
        <p className="text-sm text-alfabia-cream/65 leading-relaxed max-w-xs">
          {c.farewellBody}
        </p>
      </div>

      {/* ── Content cards ──────────────────────────────────────────────────── */}
      <div className="flex flex-col gap-4 px-4 pt-5">

        {/* Google Reviews */}
        <Section icon={<Star className="w-5 h-5" />} title={c.reviewTitle}>
          <p className="text-sm text-alfabia-text-muted leading-relaxed">
            {c.reviewBody}
          </p>
          <a
            href={GOOGLE_REVIEW_URL}
            target="_blank"
            rel="noopener noreferrer"
            className="flex items-center justify-center gap-2 w-full py-2.5 px-4 rounded-xl border-2 border-alfabia-green text-alfabia-green text-sm font-semibold transition-colors active:bg-alfabia-green active:text-alfabia-cream focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-alfabia-green"
          >
            <Star className="w-4 h-4 fill-current" />
            {c.reviewButton}
          </a>
        </Section>

        {/* Events */}
        <Section icon={<CalendarDays className="w-5 h-5" />} title={c.eventsTitle}>
          <p className="text-sm text-alfabia-text-muted leading-relaxed">
            {c.eventsBody}
          </p>
          <a
            href={`mailto:info@jardinesdealfabia.com?subject=${encodeURIComponent(c.eventsContact)}`}
            className="flex items-center justify-center gap-2 w-full py-2.5 px-4 rounded-xl bg-alfabia-green text-alfabia-cream text-sm font-semibold transition-colors active:bg-alfabia-green-dark focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-alfabia-green"
          >
            <CalendarDays className="w-4 h-4" />
            {c.eventsContact}
          </a>
        </Section>

        {/* Contact / how to get here */}
        <Section icon={<MapPin className="w-5 h-5" />} title={c.contactTitle}>
          <div className="space-y-2.5">
            <div className="flex items-start gap-3">
              <MapPin className="w-4 h-4 text-alfabia-text-muted shrink-0 mt-0.5" />
              <span className="text-sm text-alfabia-text-muted">{c.addressLine}</span>
            </div>
            <div className="flex items-start gap-3">
              <Phone className="w-4 h-4 text-alfabia-text-muted shrink-0 mt-0.5" />
              <a
                href="tel:+34971613123"
                className="text-sm text-alfabia-green underline underline-offset-2"
              >
                +34 971 613 123
              </a>
            </div>
            <div className="flex items-start gap-3">
              <Globe className="w-4 h-4 text-alfabia-text-muted shrink-0 mt-0.5" />
              <a
                href={WEBSITE_URL}
                target="_blank"
                rel="noopener noreferrer"
                className="text-sm text-alfabia-green underline underline-offset-2"
              >
                jardinesdealfabia.com
              </a>
            </div>
            <div className="flex items-start gap-3">
              <span className="w-4 h-4 shrink-0 mt-0.5 text-xs text-center text-alfabia-text-muted">✉</span>
              <a
                href="mailto:info@jardinesdealfabia.com"
                className="text-sm text-alfabia-green underline underline-offset-2 break-all"
              >
                info@jardinesdealfabia.com
              </a>
            </div>
            <p className="text-xs text-alfabia-text-muted pt-0.5">{c.hoursLine}</p>
          </div>
        </Section>

        {/* Back to home */}
        <button
          type="button"
          onClick={() => navigate('/home')}
          className="flex items-center justify-center gap-2 w-full py-3 px-6 bg-alfabia-cream border border-alfabia-border rounded-xl text-sm font-medium text-alfabia-text transition-colors active:bg-white focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-alfabia-green"
        >
          <Home className="w-4 h-4" />
          {c.backButton}
        </button>

      </div>
    </div>
  )
}
