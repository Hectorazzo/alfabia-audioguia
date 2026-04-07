import { NavLink } from 'react-router-dom'
import { Home, Map, Settings } from 'lucide-react'

interface NavItem {
  to: string
  icon: React.ReactNode
  label: string
}

const navItems: NavItem[] = [
  { to: '/home', icon: <Home size={24} />, label: 'Inicio' },
  { to: '/map', icon: <Map size={24} />, label: 'Mapa' },
  { to: '/settings', icon: <Settings size={24} />, label: 'Ajustes' },
]

export default function BottomNav() {
  return (
    <nav className="fixed bottom-0 left-0 right-0 z-50 flex h-16 items-center justify-around border-t border-alfabia-border bg-alfabia-cream">
      {navItems.map(({ to, icon, label }) => (
        <NavLink
          key={to}
          to={to}
          className={({ isActive }) =>
            [
              'flex flex-col items-center gap-0.5 px-6 py-2 transition-colors',
              isActive
                ? 'text-alfabia-green'
                : 'text-alfabia-text-muted hover:text-alfabia-green',
            ].join(' ')
          }
          aria-label={label}
        >
          {icon}
          <span className="text-[10px] font-medium leading-none">{label}</span>
        </NavLink>
      ))}
    </nav>
  )
}
