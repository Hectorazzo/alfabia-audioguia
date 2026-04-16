import { BrowserRouter, Route, Routes, Navigate } from 'react-router-dom'
import { lazy, Suspense, type ReactNode } from 'react'
import AppShell from '@/components/layout/AppShell'
import WelcomePage from '@/pages/WelcomePage'
import HomePage from '@/pages/HomePage'
import POIDetailPage from '@/pages/POIDetailPage'
import ClosingPage from '@/pages/ClosingPage'
import SettingsPage from '@/pages/SettingsPage'
import { LanguageProvider, useLanguage } from '@/contexts/LanguageContext'

// Lazy-load MapPage — Leaflet is heavy
const MapPage = lazy(() => import('@/pages/MapPage'))

/** Index route: show WelcomePage if no language chosen, otherwise redirect to /home */
function RootRoute() {
  const { language } = useLanguage()
  if (language !== null) return <Navigate to="/home" replace />
  return <WelcomePage />
}

/** Guard: redirect to / if no language has been selected yet */
function RequireLanguage({ children }: { children: ReactNode }) {
  const { language } = useLanguage()
  if (language === null) return <Navigate to="/" replace />
  return <>{children}</>
}

export default function App() {
  return (
    <BrowserRouter>
      <LanguageProvider>
        <Routes>
          <Route element={<AppShell />}>
            <Route index element={<RootRoute />} />
            <Route
              path="/home"
              element={<RequireLanguage><HomePage /></RequireLanguage>}
            />
            <Route
              path="/poi/:id"
              element={<RequireLanguage><POIDetailPage /></RequireLanguage>}
            />
            <Route
              path="/map"
              element={
                <RequireLanguage>
                  <Suspense fallback={
                    <div className="flex flex-1 items-center justify-center text-alfabia-text-muted">
                      Cargando mapa…
                    </div>
                  }>
                    <MapPage />
                  </Suspense>
                </RequireLanguage>
              }
            />
            <Route
              path="/closing"
              element={<RequireLanguage><ClosingPage /></RequireLanguage>}
            />
            <Route
              path="/settings"
              element={<RequireLanguage><SettingsPage /></RequireLanguage>}
            />
            <Route path="*" element={<Navigate to="/" replace />} />
          </Route>
        </Routes>
      </LanguageProvider>
    </BrowserRouter>
  )
}
