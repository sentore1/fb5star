-- ============================================================================
-- INSERT NEW PRODUCTS (Electronics / Tech)
-- ============================================================================
-- Run this in your Supabase SQL Editor
-- Products are served from the /products folder (local public/products)
-- ============================================================================

-- Optional: clear old test/curtain products first
-- DELETE FROM products;

INSERT INTO products (
  name,
  description,
  price,
  currency,
  category,
  image,
  images,
  stock,
  slug,
  sizes,
  colors,
  seo_title,
  seo_description,
  seo_keywords
) VALUES

-- ─── LAPTOPS ──────────────────────────────────────────────────────────────────

(
  'ASUS ROG Strix G16',
  'High-performance gaming laptop with the latest GPU and a stunning 16-inch display. Built for gamers who demand the best.',
  1299.99,
  'USD',
  'laptops',
  '/products/ASUS-ROG-STRIX-G16-G614FR-G32X3D-3-600x600.png',
  '["/products/ASUS-ROG-STRIX-G16-G614FR-G32X3D-3-600x600.png"]',
  15,
  'asus-rog-strix-g16',
  NULL,
  '["Eclipse Gray"]',
  'ASUS ROG Strix G16 Gaming Laptop',
  'Buy the ASUS ROG Strix G16 gaming laptop. Top-tier performance for gaming and creative work.',
  'asus rog, gaming laptop, strix g16, high performance laptop'
),

(
  'ASUS TUF Gaming F16',
  'Durable and powerful gaming laptop with MIL-STD-810H military-grade toughness and immersive 16-inch display.',
  999.99,
  'USD',
  'laptops',
  '/products/ASUS-TUF-GAMING-F16-FX608JHR-RV010W-16.png',
  '["/products/ASUS-TUF-GAMING-F16-FX608JHR-RV010W-16.png"]',
  20,
  'asus-tuf-gaming-f16',
  NULL,
  '["Mecha Gray"]',
  'ASUS TUF Gaming F16 Laptop',
  'Shop the ASUS TUF Gaming F16. Military-grade durability with powerful gaming specs.',
  'asus tuf, gaming laptop, f16, durable laptop'
),

(
  'ASUS Vivobook S14 OLED',
  'Ultra-slim laptop with a breathtaking OLED display, perfect for creators and professionals on the go.',
  849.99,
  'USD',
  'laptops',
  '/products/ASUS-VIVOBOOK-S-14-OLED-S5406MA-OLEDU711WB-1.png',
  '["/products/ASUS-VIVOBOOK-S-14-OLED-S5406MA-OLEDU711WB-1.png"]',
  25,
  'asus-vivobook-s14-oled',
  NULL,
  '["Neutral Black", "Cool Silver"]',
  'ASUS Vivobook S14 OLED | Ultra-Slim Laptop',
  'Buy the ASUS Vivobook S14 OLED. Stunning OLED display in a slim, lightweight design.',
  'asus vivobook, oled laptop, slim laptop, s14'
),

(
  'ASUS ZenBook Laptop',
  'Premium thin-and-light laptop with elegant design and all-day battery life, ideal for business and travel.',
  949.99,
  'USD',
  'laptops',
  '/products/asus zen.jpg',
  '["/products/asus zen.jpg"]',
  18,
  'asus-zenbook',
  NULL,
  '["Pine Grey", "Aqua Celadon"]',
  'ASUS ZenBook Laptop | Premium Business Laptop',
  'Discover the ASUS ZenBook. Elegant design meets powerful performance for professionals.',
  'asus zenbook, business laptop, thin laptop, premium laptop'
),

(
  'Lenovo IdeaPad Slim 3',
  'Everyday laptop with reliable performance, long battery life, and a comfortable keyboard — great value for students and professionals.',
  649.99,
  'USD',
  'laptops',
  '/products/LENOVO-LAPTOP-IDEAPAD-SLIM-3-15IRH10-83K100DXPS-5.png',
  '["/products/LENOVO-LAPTOP-IDEAPAD-SLIM-3-15IRH10-83K100DXPS-5.png"]',
  30,
  'lenovo-ideapad-slim-3',
  NULL,
  '["Arctic Gray"]',
  'Lenovo IdeaPad Slim 3 | Everyday Laptop',
  'Shop the Lenovo IdeaPad Slim 3. Reliable everyday performance at an affordable price.',
  'lenovo ideapad, slim laptop, student laptop, everyday laptop'
),

(
  'Lenovo V15 G4',
  'Business-ready laptop with a durable design, fast performance, and affordable price for small businesses.',
  599.99,
  'USD',
  'laptops',
  '/products/LENOVO-LAP-V15-G4-IRU-2-600x600.png',
  '["/products/LENOVO-LAP-V15-G4-IRU-2-600x600.png"]',
  22,
  'lenovo-v15-g4',
  NULL,
  '["Business Black"]',
  'Lenovo V15 G4 | Business Laptop',
  'Buy the Lenovo V15 G4 business laptop. Affordable and reliable for daily work.',
  'lenovo v15, business laptop, affordable laptop'
),

(
  'Lenovo ThinkPad P14s Gen 5',
  'Professional-grade mobile workstation with ISV-certified performance and enterprise security features.',
  1399.99,
  'USD',
  'laptops',
  '/products/THINKPAD-P14S-GEN-5-3-1-600x600.png',
  '["/products/THINKPAD-P14S-GEN-5-3-1-600x600.png"]',
  10,
  'lenovo-thinkpad-p14s-gen5',
  NULL,
  '["Black"]',
  'Lenovo ThinkPad P14s Gen 5 | Mobile Workstation',
  'Buy the Lenovo ThinkPad P14s Gen 5. Professional workstation performance in a portable form.',
  'thinkpad, mobile workstation, lenovo p14s, professional laptop'
),

(
  'Dell Alienware M18 R2',
  'The ultimate gaming beast — 18-inch display, top-end GPU, extreme cooling, and uncompromising performance.',
  2499.99,
  'USD',
  'laptops',
  '/products/DELL-ALIENWARE-M18-R2-ALN-CTO1-BLK-1.png',
  '["/products/DELL-ALIENWARE-M18-R2-ALN-CTO1-BLK-1.png", "/products/DELL-ALIENWARE-M18-R2-ALN-CTO1-BLK-2-600x600.png", "/products/DELL-ALIENWARE-M18-R2-ALN-CTO1-BLK-6-600x600.png", "/products/DELL-ALIENWARE-M18-R2-ALN-CTO1-BLK-7.png"]',
  8,
  'dell-alienware-m18-r2',
  NULL,
  '["Dark Metallic Moon"]',
  'Dell Alienware M18 R2 | Ultimate Gaming Laptop',
  'Buy the Dell Alienware M18 R2. The most powerful gaming laptop available. No compromises.',
  'alienware m18, dell gaming, gaming laptop, alienware'
),

(
  'Gaming Laptop',
  'High-performance gaming laptop with powerful specs designed for smooth gameplay at high settings.',
  899.99,
  'USD',
  'laptops',
  '/products/gamming laptop.png',
  '["/products/gamming laptop.png"]',
  20,
  'gaming-laptop',
  NULL,
  '["Black"]',
  'Gaming Laptop | High Performance',
  'Powerful gaming laptop for smooth high-setting gameplay.',
  'gaming laptop, powerful laptop, gaming'
),

-- ─── DESKTOPS & SERVERS ───────────────────────────────────────────────────────

(
  'Dell PowerEdge R250 Rack Server',
  'Entry-level rack server ideal for small businesses needing reliable, scalable infrastructure.',
  1899.99,
  'USD',
  'desktops',
  '/products/Dell-PowerEdge-R250-Rack-Server-1.png',
  '["/products/Dell-PowerEdge-R250-Rack-Server-1.png"]',
  5,
  'dell-poweredge-r250-rack-server',
  NULL,
  '["Black"]',
  'Dell PowerEdge R250 Rack Server',
  'Buy the Dell PowerEdge R250 rack server. Reliable infrastructure for small and medium businesses.',
  'dell server, rack server, poweredge, server'
),

(
  'Gaming Desktop PC',
  'Pre-built gaming desktop with powerful processor, discrete GPU, and high-speed RAM for seamless gaming.',
  1199.99,
  'USD',
  'desktops',
  '/products/gamming desktop.png',
  '["/products/gamming desktop.png", "/products/gamming desktop2.png", "/products/gamming desktop (2).png"]',
  12,
  'gaming-desktop-pc',
  NULL,
  '["Black"]',
  'Gaming Desktop PC | Pre-Built Gaming Computer',
  'High-performance gaming desktop. Ready to game out of the box with powerful components.',
  'gaming desktop, gaming pc, desktop computer, gaming computer'
),

(
  'Gaming Computer Setup',
  'Complete gaming setup package including desktop tower, peripherals, and RGB lighting.',
  1499.99,
  'USD',
  'desktops',
  '/products/gamming computer.jpg',
  '["/products/gamming computer.jpg", "/products/gamming computer 2.jpg"]',
  8,
  'gaming-computer-setup',
  NULL,
  '["Black RGB"]',
  'Gaming Computer Setup | Complete Package',
  'Complete gaming computer setup with everything you need to start gaming today.',
  'gaming setup, gaming computer, complete setup, gaming pc'
),

(
  'High-Performance Gaming Machine',
  'Custom-built gaming machine with the latest components for maximum FPS and ultra graphics.',
  1799.99,
  'USD',
  'desktops',
  '/products/gamming machine.png',
  '["/products/gamming machine.png"]',
  6,
  'high-performance-gaming-machine',
  NULL,
  '["Black"]',
  'High Performance Gaming Machine | Custom Build',
  'Custom-built gaming machine for maximum performance. Ultra graphics, max FPS.',
  'custom gaming pc, gaming machine, high performance, custom build'
),

(
  'Gaming Computer Pro',
  'Professional gaming computer with top-tier specs built for competitive gaming and content creation.',
  1599.99,
  'USD',
  'desktops',
  '/products/gaming comptuer.webp',
  '["/products/gaming comptuer.webp"]',
  10,
  'gaming-computer-pro',
  NULL,
  '["Black"]',
  'Gaming Computer Pro | Professional Gaming PC',
  'Professional gaming computer for competitive gaming and content creation.',
  'professional gaming pc, gaming computer, competitive gaming'
),

-- ─── MONITORS ─────────────────────────────────────────────────────────────────

(
  'Dell 24" Video Conferencing Monitor C2423H',
  '24-inch FHD monitor with built-in camera, mic, and speaker — perfect for home office and video calls.',
  329.99,
  'USD',
  'monitors',
  '/products/C2423H-Dell-24-Inch-Video-Conferencing-Monitor-1.png',
  '["/products/C2423H-Dell-24-Inch-Video-Conferencing-Monitor-1.png", "/products/C2423H-Dell-24-Inch-Video-Conferencing-Monitor-6-600x600.png", "/products/C2423H-Dell-24-Inch-Video-Conferencing-Monitor-8-600x600.png"]',
  20,
  'dell-c2423h-video-conferencing-monitor',
  NULL,
  '["Black"]',
  'Dell C2423H 24-Inch Video Conferencing Monitor',
  'Buy the Dell C2423H monitor with built-in camera and speaker. Perfect for video conferencing.',
  'dell monitor, video conferencing, 24 inch monitor, webcam monitor'
),

(
  'ASUS TUF Gaming VG27VQ3B2 Monitor',
  '27-inch curved gaming monitor with fast refresh rate and adaptive sync for tear-free gaming.',
  299.99,
  'USD',
  'monitors',
  '/products/TufGamingVG27VQ3B2_1024x1024.webp',
  '["/products/TufGamingVG27VQ3B2_1024x1024.webp"]',
  18,
  'asus-tuf-gaming-vg27vq3b2',
  NULL,
  '["Black"]',
  'ASUS TUF Gaming VG27VQ3B2 | 27" Curved Gaming Monitor',
  'Shop the ASUS TUF Gaming VG27VQ3B2 curved monitor. Fast refresh rate for competitive gaming.',
  'asus monitor, gaming monitor, curved monitor, 27 inch monitor'
),

-- ─── PERIPHERALS & ACCESSORIES ────────────────────────────────────────────────

(
  'Gaming Keyboard',
  'Mechanical gaming keyboard with RGB backlight, anti-ghosting, and tactile switches for precise input.',
  79.99,
  'USD',
  'accessories',
  '/products/gamming keyboard.png',
  '["/products/gamming keyboard.png", "/products/gamming keyboard 2.png"]',
  35,
  'gaming-keyboard',
  NULL,
  '["Black RGB"]',
  'Gaming Keyboard | Mechanical RGB',
  'Mechanical gaming keyboard with RGB lighting and anti-ghosting for competitive play.',
  'gaming keyboard, mechanical keyboard, rgb keyboard, gaming peripherals'
),

(
  'Gaming Mouse',
  'High-DPI optical gaming mouse with customizable buttons and ergonomic design for long gaming sessions.',
  49.99,
  'USD',
  'accessories',
  '/products/gaming mouse.png',
  '["/products/gaming mouse.png"]',
  40,
  'gaming-mouse',
  NULL,
  '["Black"]',
  'Gaming Mouse | High DPI Optical Mouse',
  'High-DPI gaming mouse with customizable buttons. Ergonomic design for extended gaming sessions.',
  'gaming mouse, optical mouse, high dpi, gaming peripherals'
),

(
  'Gaming Setup Bundle',
  'Complete gaming peripheral bundle — keyboard, mouse, headset, and mousepad all in one package.',
  199.99,
  'USD',
  'accessories',
  '/products/gaminng setup up.png',
  '["/products/gaminng setup up.png", "/products/gamming too.png", "/products/gamming tool.png"]',
  12,
  'gaming-setup-bundle',
  NULL,
  '["Black RGB"]',
  'Gaming Setup Bundle | Complete Peripheral Package',
  'Complete gaming peripheral bundle. Get everything you need in one package.',
  'gaming bundle, gaming setup, peripherals bundle, gaming accessories'
),

(
  'Smart Watch',
  'Feature-packed smartwatch with health tracking, notifications, GPS, and multi-day battery life.',
  199.99,
  'USD',
  'accessories',
  '/products/smart watuch.png',
  '["/products/smart watuch.png", "/products/watch.png"]',
  30,
  'smart-watch',
  NULL,
  '["Black", "Silver", "Rose Gold"]',
  'Smart Watch | Health & Fitness Tracker',
  'Feature-rich smartwatch with health tracking, GPS, and long battery life.',
  'smartwatch, smart watch, fitness tracker, health watch, wearable'
),

(
  'Sony Wireless Headphones',
  'Premium wireless headphones with noise cancellation, rich bass, and up to 30 hours of playback.',
  149.99,
  'USD',
  'accessories',
  '/products/sony music.webp',
  '["/products/sony music.webp"]',
  25,
  'sony-wireless-headphones',
  NULL,
  '["Black", "White"]',
  'Sony Wireless Headphones | Noise Cancelling',
  'Premium Sony wireless headphones with noise cancellation and 30-hour battery.',
  'sony headphones, wireless headphones, noise cancelling, headphones'
),

(
  'USB Cable Pack',
  'Multi-pack of premium braided USB cables supporting fast charging and high-speed data transfer.',
  19.99,
  'USD',
  'accessories',
  '/products/USB cable.jpg',
  '["/products/USB cable.jpg", "/products/USB cable2.jpg"]',
  80,
  'usb-cable-pack',
  NULL,
  '["Black", "White"]',
  'USB Cable Pack | Fast Charging Cables',
  'Premium braided USB cables for fast charging and high-speed data transfer.',
  'usb cable, fast charging cable, data cable, usb accessories'
),

(
  'Gaming Controller',
  'Wireless gaming controller with ergonomic grip, responsive buttons, and low-latency connection.',
  59.99,
  'USD',
  'accessories',
  '/products/game.jpg',
  '["/products/game.jpg"]',
  28,
  'gaming-controller',
  NULL,
  '["Black", "White"]',
  'Gaming Controller | Wireless Gamepad',
  'Ergonomic wireless gaming controller with low-latency connection for all platforms.',
  'gaming controller, gamepad, wireless controller, gaming accessories'
),

(
  'PNG Wing Controller Bundle',
  'Special edition controller bundle with custom color schemes and extra accessories.',
  89.99,
  'USD',
  'accessories',
  '/products/pngwing.com.png',
  '["/products/pngwing.com.png", "/products/pngwing.com (44).png", "/products/pngwing.com (45).png", "/products/pngwing.com (46).png", "/products/pngwing.com (47).png", "/products/pngwing.com (48).png", "/products/pngwing.com (51).png"]',
  15,
  'controller-special-edition',
  NULL,
  '["Multi-Color"]',
  'Special Edition Controller Bundle | Custom Colors',
  'Special edition controller bundle with custom designs and extra accessories.',
  'controller bundle, special edition, gaming accessories'
),

(
  'Gaming Misc Bundle',
  'Bundle of essential gaming accessories including cable management tools and RGB accessories.',
  39.99,
  'USD',
  'accessories',
  '/products/pngwing.com__12_-removebg-preview.png',
  '["/products/pngwing.com__12_-removebg-preview.png", "/products/c0fbb3cc90872f22892a71c2f70d7b4a-md.jpg"]',
  20,
  'gaming-misc-bundle',
  NULL,
  '["Black"]',
  'Gaming Misc Bundle | Essential Accessories',
  'Essential gaming accessories bundle for cable management and RGB setup.',
  'gaming accessories, rgb accessories, cable management'
)

ON CONFLICT (slug) DO NOTHING;

-- ─── INSERT CATEGORIES ────────────────────────────────────────────────────────
INSERT INTO categories (name) VALUES
  ('laptops'),
  ('desktops'),
  ('monitors'),
  ('accessories')
ON CONFLICT (name) DO NOTHING;

-- ─── VERIFY ───────────────────────────────────────────────────────────────────
SELECT category, COUNT(*) as count FROM products GROUP BY category ORDER BY category;
SELECT COUNT(*) as total_products FROM products;
