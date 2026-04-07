import { Outlet, useLocation } from 'react-router-dom'
import BottomNav from './BottomNav'

const ROUTES_WITHOUT_NAV = new Set(['/', '/language'])

export default function AppShell() {
  const { pathname } = useLocation()
  const showNav = !ROUTES_WITHOUT_NAV.has(pathname)

  return (
    <div className="flex min-h-svh flex-col bg-alfabia-cream">
      <main className={showNav ? 'flex-1 pb-16' : 'flex-1'}>
        <Outlet />
      </main>
      {showNav && <BottomNav />}
    </div>
  )
}
