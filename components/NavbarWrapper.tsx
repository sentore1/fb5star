'use client'

import { usePathname } from 'next/navigation'
import { useEffect, useState } from 'react'
import Navbar from './Navbar'
import { supabase } from '../lib/supabase'

export default function NavbarWrapper() {
  const pathname = usePathname()
  const [siteLogo, setSiteLogo] = useState('')
  const [siteName, setSiteName] = useState('Fb5Star')
  const [headerStyle, setHeaderStyle] = useState<'minimal' | 'classic' | 'modern' | 'fashion'>('minimal')
  const [logoSize, setLogoSize] = useState(40)

  useEffect(() => {
    const fetchSettings = async () => {
      try {
        const { data, error } = await supabase.from('site_settings').select('site_logo,site_name,header_style,footer_logo_size').single()
        if (data && !error) {
          let logo = data.site_logo || ''
          // site_logo may be stored as JSON alongside momo settings
          if (logo.startsWith('{')) {
            try { logo = JSON.parse(logo).logo || '' } catch {}
          }
          // Fall back to the dark logo from public folder if none set
          setSiteLogo(logo || '/Logo-dark.png')
          if (data.site_name) setSiteName(data.site_name)
          if (data.header_style) setHeaderStyle(data.header_style as any)
          if (data.footer_logo_size) setLogoSize(data.footer_logo_size)
        }
      } catch {}
    }
    fetchSettings()
  }, [])

  // Home page handles its own navbar
  if (pathname === '/') return null

  return (
    <Navbar
      siteLogo={siteLogo}
      siteName={siteName}
      headerStyle={headerStyle}
      logoSize={logoSize}
    />
  )
}
