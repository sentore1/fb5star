// seed-products.js
// Run with: node seed-products.js

const { createClient } = require('@supabase/supabase-js')

const SUPABASE_URL = 'https://vrkzipbpgvybrpqhcvte.supabase.co'
const SUPABASE_SERVICE_ROLE_KEY = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InZya3ppcGJwZ3Z5YnJwcWhjdnRlIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc4ODcwMDY4OCwiZXhwIjoyMTA0Mjc2Njg4fQ.P9PXRg09D4x0yepWpsB2bbykQK_TMAGbxAR7m_SrpmU'

const supabase = createClient(SUPABASE_URL, SUPABASE_SERVICE_ROLE_KEY)

const products = [
  // Laptops
  {
    name: 'ASUS ZenBook 14',
    price: 899000,
    image: '/products/asus zen.jpg',
    description: 'ASUS ZenBook 14 – Ultra-slim laptop with powerful performance for everyday use.',
    category: 'Laptops',
    stock: 10,
  },
  {
    name: 'ASUS ROG Strix G16 G614FR',
    price: 2199000,
    image: '/products/ASUS-ROG-STRIX-G16-G614FR-G32X3D-3-600x600.png',
    description: 'ASUS ROG Strix G16 – High-performance gaming laptop with RTX graphics and 165Hz display.',
    category: 'Gaming Laptops',
    stock: 8,
  },
  {
    name: 'ASUS TUF Gaming F16 FX608JHR',
    price: 1399000,
    image: '/products/ASUS-TUF-GAMING-F16-FX608JHR-RV010W-16.png',
    description: 'ASUS TUF Gaming F16 – Durable gaming laptop with military-grade toughness and smooth gaming.',
    category: 'Gaming Laptops',
    stock: 12,
  },
  {
    name: 'ASUS VivoBook S14 OLED',
    price: 1099000,
    image: '/products/ASUS-VIVOBOOK-S-14-OLED-S5406MA-OLEDU711WB-1.png',
    description: 'ASUS VivoBook S14 OLED – Stunning OLED display with lightweight design for creators.',
    category: 'Laptops',
    stock: 10,
  },
  {
    name: 'Lenovo V15 G4 IRU',
    price: 749000,
    image: '/products/LENOVO-LAP-V15-G4-IRU-2-600x600.png',
    description: 'Lenovo V15 G4 – Business laptop with reliable performance and all-day battery life.',
    category: 'Laptops',
    stock: 15,
  },
  {
    name: 'Lenovo IdeaPad Slim 3 15IRH10',
    price: 699000,
    image: '/products/LENOVO-LAPTOP-IDEAPAD-SLIM-3-15IRH10-83K100DXPS-5.png',
    description: 'Lenovo IdeaPad Slim 3 – Affordable slim laptop ideal for students and everyday tasks.',
    category: 'Laptops',
    stock: 20,
  },
  {
    name: 'Lenovo ThinkPad P14s Gen 5',
    price: 1899000,
    image: '/products/THINKPAD-P14S-GEN-5-3-1-600x600.png',
    description: 'Lenovo ThinkPad P14s Gen 5 – Professional workstation laptop with ISV-certified performance.',
    category: 'Laptops',
    stock: 6,
  },
  {
    name: 'Gaming Laptop',
    price: 1299000,
    image: '/products/gamming laptop.png',
    description: 'High-performance gaming laptop with dedicated GPU and fast refresh rate display.',
    category: 'Gaming Laptops',
    stock: 10,
  },

  // Desktops & Gaming PCs
  {
    name: 'Dell Alienware M18 R2',
    price: 3499000,
    image: '/products/DELL-ALIENWARE-M18-R2-ALN-CTO1-BLK-1.png',
    description: 'Dell Alienware M18 R2 – The ultimate gaming beast with RTX 4090 and 18-inch QHD display.',
    category: 'Gaming Laptops',
    stock: 5,
  },
  {
    name: 'Gaming Desktop PC',
    price: 1599000,
    image: '/products/gamming computer.jpg',
    description: 'Custom gaming desktop with RGB lighting, fast SSD, and high-end GPU for immersive gaming.',
    category: 'Gaming Desktops',
    stock: 8,
  },
  {
    name: 'Gaming Desktop Pro',
    price: 1899000,
    image: '/products/gamming computer 2.jpg',
    description: 'Pro-level gaming desktop built for high FPS gaming and content creation.',
    category: 'Gaming Desktops',
    stock: 6,
  },
  {
    name: 'Gaming Desktop Tower',
    price: 1499000,
    image: '/products/gamming desktop.png',
    description: 'Mid-tower gaming desktop with tempered glass side panel and RGB cooling.',
    category: 'Gaming Desktops',
    stock: 10,
  },
  {
    name: 'Gaming Desktop Tower 2',
    price: 1699000,
    image: '/products/gamming desktop2.png',
    description: 'Powerful gaming desktop tower with latest-gen CPU and GPU combo.',
    category: 'Gaming Desktops',
    stock: 7,
  },
  {
    name: 'Gaming Desktop (Compact)',
    price: 1399000,
    image: '/products/gamming desktop (2).png',
    description: 'Compact gaming desktop with powerful internals in a small form factor.',
    category: 'Gaming Desktops',
    stock: 9,
  },
  {
    name: 'Gaming Machine RGB',
    price: 1799000,
    image: '/products/gamming machine.png',
    description: 'Full RGB gaming machine with liquid cooling and high-performance components.',
    category: 'Gaming Desktops',
    stock: 5,
  },
  {
    name: 'Gaming Computer Setup',
    price: 2499000,
    image: '/products/gaming comptuer.webp',
    description: 'Complete gaming computer setup ready for competitive and casual gaming.',
    category: 'Gaming Desktops',
    stock: 4,
  },
  {
    name: 'Gaming Setup Complete',
    price: 2999000,
    image: '/products/gaminng setup up.png',
    description: 'Full gaming setup bundle including PC, monitor, keyboard, and mouse.',
    category: 'Gaming Setups',
    stock: 3,
  },

  // Monitors
  {
    name: 'Dell 24" Video Conferencing Monitor C2423H',
    price: 499000,
    image: '/products/C2423H-Dell-24-Inch-Video-Conferencing-Monitor-1.png',
    description: 'Dell C2423H – 24" FHD monitor with built-in webcam and speaker for video conferencing.',
    category: 'Monitors',
    stock: 12,
  },
  {
    name: 'ASUS TUF Gaming VG27VQ3B 27"',
    price: 449000,
    image: '/products/TufGamingVG27VQ3B2_1024x1024.webp',
    description: 'ASUS TUF Gaming VG27VQ3B – 27" curved gaming monitor with 165Hz and 1ms response time.',
    category: 'Monitors',
    stock: 10,
  },

  // Servers
  {
    name: 'Dell PowerEdge R250 Rack Server',
    price: 4999000,
    image: '/products/Dell-PowerEdge-R250-Rack-Server-1.png',
    description: 'Dell PowerEdge R250 – 1U rack server for small businesses needing reliable data management.',
    category: 'Servers',
    stock: 3,
  },

  // Peripherals – Keyboards
  {
    name: 'Gaming Keyboard RGB',
    price: 89000,
    image: '/products/gamming keyboard.png',
    description: 'Mechanical gaming keyboard with RGB backlighting and tactile switches.',
    category: 'Keyboards',
    stock: 25,
  },
  {
    name: 'Gaming Keyboard Pro',
    price: 129000,
    image: '/products/gamming keyboard 2.png',
    description: 'Pro gaming keyboard with anti-ghosting, N-key rollover, and customizable RGB zones.',
    category: 'Keyboards',
    stock: 20,
  },

  // Peripherals – Mice
  {
    name: 'Gaming Mouse',
    price: 59000,
    image: '/products/gaming mouse.png',
    description: 'Precision gaming mouse with adjustable DPI up to 12000, RGB and ergonomic design.',
    category: 'Mice',
    stock: 30,
  },

  // Accessories
  {
    name: 'USB Cable (Type-A to Type-C)',
    price: 9000,
    image: '/products/USB cable.jpg',
    description: 'High-speed USB-A to USB-C cable, 1m, supports fast charging and data transfer.',
    category: 'Accessories',
    stock: 100,
  },
  {
    name: 'USB Cable Braided',
    price: 12000,
    image: '/products/USB cable2.jpg',
    description: 'Durable braided USB cable for long-lasting use with fast charging support.',
    category: 'Accessories',
    stock: 100,
  },

  // Wearables
  {
    name: 'Smart Watch',
    price: 199000,
    image: '/products/smart watuch.png',
    description: 'Smart watch with health tracking, notifications, and long battery life.',
    category: 'Wearables',
    stock: 15,
  },
  {
    name: 'Digital Watch',
    price: 149000,
    image: '/products/watch.png',
    description: 'Stylish digital watch with fitness tracking and water resistance.',
    category: 'Wearables',
    stock: 20,
  },

  // Audio
  {
    name: 'Sony Wireless Speaker',
    price: 179000,
    image: '/products/sony music.webp',
    description: 'Sony wireless Bluetooth speaker with deep bass and 12-hour battery life.',
    category: 'Audio',
    stock: 18,
  },

  // Gaming Tools / Accessories
  {
    name: 'Gaming Tool Set',
    price: 45000,
    image: '/products/gamming too.png',
    description: 'Essential gaming accessory set for the complete gaming experience.',
    category: 'Accessories',
    stock: 25,
  },
  {
    name: 'Gaming Tool Kit',
    price: 55000,
    image: '/products/gamming tool.png',
    description: 'Premium gaming toolkit with multiple accessories for PC gamers.',
    category: 'Accessories',
    stock: 20,
  },

  // Game
  {
    name: 'PC Game Bundle',
    price: 29000,
    image: '/products/game.jpg',
    description: 'PC game bundle – top titles for action and adventure gaming.',
    category: 'Games',
    stock: 50,
  },
]

async function seedProducts() {
  console.log(`Seeding ${products.length} products into Supabase...`)

  const { data, error } = await supabase
    .from('products')
    .insert(products)
    .select()

  if (error) {
    console.error('Error inserting products:', error.message)
    console.error('Details:', error.details)
    process.exit(1)
  }

  console.log(`Successfully inserted ${data.length} products!`)
  data.forEach(p => console.log(`  ✓ ${p.name} — ${p.price.toLocaleString()} MMK`))
}

seedProducts()
