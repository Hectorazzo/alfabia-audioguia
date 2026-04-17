import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'
import tailwindcss from '@tailwindcss/vite'
import { VitePWA } from 'vite-plugin-pwa'
import { resolve } from 'path'

// https://vite.dev/config/
export default defineConfig({
  plugins: [
    react(),
    tailwindcss(),
    VitePWA({
      // Use our hand-written SW with Workbox manifest injection
      strategies: 'injectManifest',
      srcDir: 'src',
      filename: 'sw.ts',

      // Auto-update: new SW activates as soon as all tabs are closed
      registerType: 'autoUpdate',

      // Precache every asset Vite emits (HTML, CSS, JS chunks, fonts, images)
      injectManifest: {
        // Only precache assets from the Vite build output
        globPatterns: ['**/*.{js,css,html,ico,svg,woff,woff2,webp,png}'],
        // Exclude Leaflet CSS from precache (loaded by the lazy MiniMap chunk)
        globIgnores: ['**/leaflet*.css'],
      },

      // PWA Web Manifest
      manifest: {
        name: 'Jardines de Alfabia — Audioguía',
        short_name: 'Alfabia',
        description:
          'Audioguía digital de los Jardines de Alfabia, Mallorca. 18 puntos de interés en 5 idiomas.',
        theme_color: '#233B29',
        background_color: '#F8F2E7',
        display: 'standalone',
        orientation: 'portrait-primary',
        start_url: '/',
        scope: '/',
        lang: 'es',
        icons: [
          {
            src: '/pwa-192x192.svg',
            sizes: '192x192',
            type: 'image/svg+xml',
            purpose: 'any',
          },
          {
            src: '/pwa-512x512.svg',
            sizes: '512x512',
            type: 'image/svg+xml',
            purpose: 'maskable',
          },
        ],
        // Deep-link shortcuts for quick access
        shortcuts: [
          {
            name: 'Ver todos los puntos',
            url: '/home',
            icons: [{ src: '/pwa-192x192.svg', sizes: '192x192' }],
          },
          {
            name: 'Abrir mapa',
            url: '/map',
            icons: [{ src: '/pwa-192x192.svg', sizes: '192x192' }],
          },
        ],
      },

      // Enable in dev so the SW can be tested without a production build
      devOptions: {
        enabled: true,
        type: 'module',
      },
    }),
  ],

  resolve: {
    alias: {
      '@': resolve(__dirname, 'src'),
    },
  },

  build: {
    rollupOptions: {
      output: {
        manualChunks(id) {
          if (!id.includes('node_modules')) return undefined
          if (id.includes('react-dom') || id.includes('react/') || id.includes('scheduler'))
            return 'vendor-react'
          if (id.includes('react-router'))
            return 'vendor-router'
          if (id.includes('supabase') || id.includes('postgrest') || id.includes('realtime'))
            return 'vendor-supabase'
          if (id.includes('leaflet') || id.includes('react-leaflet'))
            return 'vendor-leaflet'
return 'vendor-misc'
        },
      },
    },
  },
})
