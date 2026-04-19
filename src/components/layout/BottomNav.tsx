import { NavLink } from 'react-router-dom'
import { Home, Map, Settings } from 'lucide-react'
import { useT } from '@/i18n/translations'

export default function BottomNav() {
  const t = useT()

  const navItems = [
    { to: '/home', icon: <Home size={24} />, label: t('home') },
    { to: '/map', icon: <Map size={24} />, label: t('map') },
    { to: '/settings', icon: <Settings size={24} />, label: t('settings') },
  ]

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
