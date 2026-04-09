import { BrowserRouter, Route, Routes, Navigate } from 'react-router-dom'
import { lazy, Suspense } from 'react'
import AppShell from '@/components/layout/AppShell'
// import SplashPage from '@/pages/SplashPage'  // TODO: restore when audioguide goes live
import TempLandingPage from '@/pages/TempLandingPage'
import LanguagePage from '@/pages/LanguagePage'
import HomePage from '@/pages/HomePage'
import POIDetailPage from '@/pages/POIDetailPage'
import ClosingPage from '@/pages/ClosingPage'
import SettingsPage from '@/pages/SettingsPage'

// Lazy-load MapPage — Leaflet is heavy
const MapPage = lazy(() => import('@/pages/MapPage'))

export default function App() {
  return (
    <BrowserRouter>
      <Routes>
        <Route element={<AppShell />}>
          {/* <Route index element={<SplashPage />} /> */}
          <Route index element={<TempLandingPage />} />
          <Route path="/language" element={<LanguagePage />} />
          <Route path="/home" element={<HomePage />} />
          <Route path="/poi/:id" element={<POIDetailPage />} />
          <Route
            path="/map"
            element={
              <Suspense fallback={
                <div className="flex flex-1 items-center justify-center text-alfabia-text-muted">
                  Cargando mapa…
                </div>
              }>
                <MapPage />
              </Suspense>
            }
          />
          <Route path="/closing" element={<ClosingPage />} />
          <Route path="/settings" element={<SettingsPage />} />
          <Route path="*" element={<Navigate to="/" replace />} />
        </Route>
      </Routes>
    </BrowserRouter>
  )
}
