-- ============================================================================
-- COMPLETE DATABASE SETUP FOR NEW SUPABASE INSTANCE
-- ============================================================================
-- This script creates all tables from scratch and applies all migrations
-- Run this in your Supabase SQL Editor
-- ============================================================================

-- ============================================================================
-- SECTION 1: CREATE BASE TABLES
-- ============================================================================

-- 1.1: Products Table
CREATE TABLE IF NOT EXISTS products (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  description TEXT,
  price DECIMAL(10,2) NOT NULL,
  currency VARCHAR(3) DEFAULT 'USD',
  category VARCHAR(100) NOT NULL,
  image VARCHAR(500),
  images TEXT,
  stock INTEGER DEFAULT 0,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 1.2: Orders Table
CREATE TABLE IF NOT EXISTS orders (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES auth.users(id),
  customer_email VARCHAR(255) NOT NULL,
  customer_name VARCHAR(255),
  customer_phone VARCHAR(50),
  total NUMERIC NOT NULL,
  total_amount DECIMAL(10,2),
  payment_method TEXT NOT NULL,
  payment_reference VARCHAR(255),
  transaction_id TEXT,
  payment_transaction_id VARCHAR(255),
  payment_account VARCHAR(255),
  items JSONB NOT NULL,
  status VARCHAR(50) DEFAULT 'pending',
  shipping_address TEXT,
  shipping_city VARCHAR(100),
  shipping_country VARCHAR(100),
  shipping_postal_code VARCHAR(20),
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 1.3: Order Items Table
CREATE TABLE IF NOT EXISTS order_items (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  order_id UUID REFERENCES orders(id) ON DELETE CASCADE,
  product_id UUID REFERENCES products(id) ON DELETE CASCADE,
  quantity INTEGER NOT NULL,
  price DECIMAL(10,2) NOT NULL,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 1.4: Site Settings Table
CREATE TABLE IF NOT EXISTS site_settings (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  hero_type TEXT DEFAULT 'image',
  hero_content TEXT DEFAULT '/hero-image.jpg',
  hero_title TEXT DEFAULT 'Fb5Star',
  hero_subtitle TEXT DEFAULT 'Discover timeless pieces crafted for the modern minimalist',
  header_style TEXT DEFAULT 'minimal',
  footer_style TEXT DEFAULT 'simple',
  site_name TEXT DEFAULT 'Fb5Star',
  site_logo TEXT DEFAULT '',
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 1.5: Hero Sections Table
CREATE TABLE IF NOT EXISTS hero_sections (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  position INTEGER NOT NULL DEFAULT 0,
  vertical_position VARCHAR(20) DEFAULT 'top',
  enabled BOOLEAN DEFAULT true,
  hero_type VARCHAR(20) DEFAULT 'image',
  hero_content TEXT,
  hero_title TEXT,
  hero_subtitle TEXT,
  hero_height INTEGER DEFAULT 400,
  hero_border_radius INTEGER DEFAULT 0,
  hero_overlay_enabled BOOLEAN DEFAULT true,
  hero_overlay_color VARCHAR(20) DEFAULT '#000000',
  hero_overlay_opacity DECIMAL(3,2) DEFAULT 0.3,
  hero_button_text VARCHAR(100),
  hero_button_link TEXT,
  hero_title_font VARCHAR(100) DEFAULT 'inherit',
  hero_title_size INTEGER DEFAULT 48,
  hero_gallery_images TEXT DEFAULT '[]',
  created_at TIMESTAMP DEFAULT NOW()
);

-- ============================================================================
-- SECTION 2: PRODUCTS TABLE ENHANCEMENTS
-- ============================================================================

-- Add product slug column
ALTER TABLE products ADD COLUMN IF NOT EXISTS slug VARCHAR(255) UNIQUE;

-- Add CRO (Conversion Rate Optimization) fields
ALTER TABLE products ADD COLUMN IF NOT EXISTS sizes TEXT;
ALTER TABLE products ADD COLUMN IF NOT EXISTS colors TEXT;
ALTER TABLE products ADD COLUMN IF NOT EXISTS sale_end_date TIMESTAMP WITH TIME ZONE;
ALTER TABLE products ADD COLUMN IF NOT EXISTS viewers_count INTEGER DEFAULT 0;

-- Add SEO fields
ALTER TABLE products 
ADD COLUMN IF NOT EXISTS seo_title VARCHAR(255),
ADD COLUMN IF NOT EXISTS seo_description TEXT,
ADD COLUMN IF NOT EXISTS seo_keywords TEXT,
ADD COLUMN IF NOT EXISTS meta_tags TEXT;

-- ============================================================================
-- SECTION 3: SITE SETTINGS ENHANCEMENTS
-- ============================================================================

-- Homepage settings
ALTER TABLE site_settings
ADD COLUMN IF NOT EXISTS homepage_product_limit INTEGER DEFAULT 8;

-- Hero section settings
ALTER TABLE site_settings ADD COLUMN IF NOT EXISTS show_hero BOOLEAN DEFAULT false;
ALTER TABLE site_settings ADD COLUMN IF NOT EXISTS hero_border_radius INTEGER DEFAULT 0;
ALTER TABLE site_settings ADD COLUMN IF NOT EXISTS hero_overlay_enabled BOOLEAN DEFAULT true;
ALTER TABLE site_settings ADD COLUMN IF NOT EXISTS hero_overlay_color VARCHAR(7) DEFAULT '#000000';
ALTER TABLE site_settings ADD COLUMN IF NOT EXISTS hero_overlay_opacity DECIMAL(3,2) DEFAULT 0.3;
ALTER TABLE site_settings ADD COLUMN IF NOT EXISTS hero_height INTEGER DEFAULT 400;
ALTER TABLE site_settings ADD COLUMN IF NOT EXISTS hero_button_text VARCHAR(100) DEFAULT '';
ALTER TABLE site_settings ADD COLUMN IF NOT EXISTS hero_button_link VARCHAR(255) DEFAULT '';
ALTER TABLE site_settings ADD COLUMN IF NOT EXISTS hero_title_font VARCHAR(50) DEFAULT 'inherit';
ALTER TABLE site_settings ADD COLUMN IF NOT EXISTS hero_title_size INTEGER DEFAULT 48;

-- Product display settings
ALTER TABLE site_settings ADD COLUMN IF NOT EXISTS product_grid_columns INTEGER DEFAULT 4;
ALTER TABLE site_settings ADD COLUMN IF NOT EXISTS product_card_style VARCHAR(20) DEFAULT 'minimal';
ALTER TABLE site_settings ADD COLUMN IF NOT EXISTS product_card_height VARCHAR(50) DEFAULT 'square';
ALTER TABLE site_settings ADD COLUMN IF NOT EXISTS price_badge_color VARCHAR(7) DEFAULT '#3b82f6';
ALTER TABLE site_settings ADD COLUMN IF NOT EXISTS product_zoom_type VARCHAR(20) DEFAULT 'simple';

-- Product page settings
ALTER TABLE site_settings 
ADD COLUMN IF NOT EXISTS product_page_layout VARCHAR(50) DEFAULT 'default',
ADD COLUMN IF NOT EXISTS add_to_cart_button_text VARCHAR(100) DEFAULT 'Add to Cart';

-- Footer settings
ALTER TABLE site_settings ADD COLUMN IF NOT EXISTS footer_text_size INTEGER DEFAULT 14;
ALTER TABLE site_settings ADD COLUMN IF NOT EXISTS footer_logo_size INTEGER DEFAULT 32;
ALTER TABLE site_settings ADD COLUMN IF NOT EXISTS footer_show_border BOOLEAN DEFAULT false;
ALTER TABLE site_settings ADD COLUMN IF NOT EXISTS footer_show_logo BOOLEAN DEFAULT true;
ALTER TABLE site_settings ADD COLUMN IF NOT EXISTS footer_title_size INTEGER DEFAULT 24;
ALTER TABLE site_settings ADD COLUMN IF NOT EXISTS footer_title_weight INTEGER DEFAULT 600;
ALTER TABLE site_settings ADD COLUMN IF NOT EXISTS footer_title_font VARCHAR(50) DEFAULT 'inherit';
ALTER TABLE site_settings ADD COLUMN IF NOT EXISTS footer_title_line_height DECIMAL(3,1) DEFAULT 1.2;
ALTER TABLE site_settings ADD COLUMN IF NOT EXISTS footer_symbol VARCHAR(5) DEFAULT '™';

-- Payment settings
ALTER TABLE site_settings
ADD COLUMN IF NOT EXISTS payment_paypal_enabled BOOLEAN DEFAULT true,
ADD COLUMN IF NOT EXISTS payment_kpay_enabled BOOLEAN DEFAULT true,
ADD COLUMN IF NOT EXISTS payment_momo_enabled BOOLEAN DEFAULT false,
ADD COLUMN IF NOT EXISTS momo_number TEXT DEFAULT '',
ADD COLUMN IF NOT EXISTS momo_name TEXT DEFAULT '',
ADD COLUMN IF NOT EXISTS momo_instructions TEXT DEFAULT 'Scan the QR code or tap to dial, then enter your transaction ID.',
ADD COLUMN IF NOT EXISTS momo_dial_code TEXT DEFAULT '*182*8*1*{number}*{amount}#';

-- ============================================================================
-- SECTION 4: CREATE ANALYTICS TABLES
-- ============================================================================

-- Page Views Table
CREATE TABLE IF NOT EXISTS page_views (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  session_id TEXT,
  page_path TEXT NOT NULL,
  page_title TEXT,
  referrer TEXT,
  user_agent TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Click Events Table
CREATE TABLE IF NOT EXISTS click_events (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  session_id TEXT,
  element_type TEXT NOT NULL,
  element_text TEXT,
  page_path TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- User Sessions Table
CREATE TABLE IF NOT EXISTS user_sessions (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  session_id TEXT UNIQUE NOT NULL,
  first_seen TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  last_seen TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  page_views INTEGER DEFAULT 0,
  user_agent TEXT,
  referrer TEXT
);

-- Conversion Events Table
CREATE TABLE IF NOT EXISTS conversion_events (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  session_id TEXT,
  event_type TEXT NOT NULL,
  product_id TEXT,
  product_name TEXT,
  amount DECIMAL(10,2),
  currency TEXT,
  order_id TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Cart Events Table
CREATE TABLE IF NOT EXISTS cart_events (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  session_id TEXT,
  event_type TEXT NOT NULL,
  product_id TEXT,
  product_name TEXT,
  quantity INTEGER,
  price DECIMAL(10,2),
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- ============================================================================
-- SECTION 5: ENABLE ROW LEVEL SECURITY (RLS)
-- ============================================================================

-- Enable RLS on base tables
ALTER TABLE products ENABLE ROW LEVEL SECURITY;
ALTER TABLE orders ENABLE ROW LEVEL SECURITY;
ALTER TABLE order_items ENABLE ROW LEVEL SECURITY;
ALTER TABLE site_settings ENABLE ROW LEVEL SECURITY;
ALTER TABLE hero_sections ENABLE ROW LEVEL SECURITY;

-- Enable RLS on analytics tables
ALTER TABLE page_views ENABLE ROW LEVEL SECURITY;
ALTER TABLE click_events ENABLE ROW LEVEL SECURITY;
ALTER TABLE user_sessions ENABLE ROW LEVEL SECURITY;
ALTER TABLE conversion_events ENABLE ROW LEVEL SECURITY;
ALTER TABLE cart_events ENABLE ROW LEVEL SECURITY;

-- ============================================================================
-- SECTION 6: CREATE RLS POLICIES - PRODUCTS
-- ============================================================================

-- Drop existing policies if they exist
DROP POLICY IF EXISTS "Products are viewable by everyone" ON products;
DROP POLICY IF EXISTS "Admin can manage products" ON products;

-- Create policies
CREATE POLICY "Products are viewable by everyone" 
ON products FOR SELECT 
USING (true);

CREATE POLICY "Admin can manage products" 
ON products FOR ALL 
USING (true);

-- ============================================================================
-- SECTION 7: CREATE RLS POLICIES - ORDERS
-- ============================================================================

-- Drop existing policies if they exist
DROP POLICY IF EXISTS "Users can view their own orders" ON orders;
DROP POLICY IF EXISTS "Users can create orders" ON orders;
DROP POLICY IF EXISTS "System can update orders" ON orders;
DROP POLICY IF EXISTS "Service role can insert orders" ON orders;
DROP POLICY IF EXISTS "Admin can view all orders" ON orders;
DROP POLICY IF EXISTS "Admin can update orders" ON orders;

-- Create policies
CREATE POLICY "Users can view their own orders"
ON orders FOR SELECT
TO authenticated
USING (auth.uid() = user_id);

CREATE POLICY "Users can create orders" 
ON orders FOR INSERT 
WITH CHECK (true);

CREATE POLICY "Service role can insert orders"
ON orders FOR INSERT
TO service_role
WITH CHECK (true);

CREATE POLICY "System can update orders" 
ON orders FOR UPDATE 
USING (true);

CREATE POLICY "Admin can view all orders"
ON orders FOR SELECT
TO authenticated
USING (true);

CREATE POLICY "Admin can update orders"
ON orders FOR UPDATE
TO authenticated
USING (true)
WITH CHECK (true);

-- ============================================================================
-- SECTION 8: CREATE RLS POLICIES - ORDER ITEMS
-- ============================================================================

DROP POLICY IF EXISTS "Order items are viewable by everyone" ON order_items;
DROP POLICY IF EXISTS "Order items can be created" ON order_items;

CREATE POLICY "Order items are viewable by everyone" 
ON order_items FOR SELECT 
USING (true);

CREATE POLICY "Order items can be created" 
ON order_items FOR INSERT 
WITH CHECK (true);

-- ============================================================================
-- SECTION 9: CREATE RLS POLICIES - SITE SETTINGS & HERO SECTIONS
-- ============================================================================

DROP POLICY IF EXISTS "Allow public read access" ON site_settings;
DROP POLICY IF EXISTS "Allow admin write access" ON site_settings;

CREATE POLICY "Allow public read access" 
ON site_settings FOR SELECT 
USING (true);

CREATE POLICY "Allow admin write access" 
ON site_settings FOR ALL 
USING (true);

-- Hero sections policies
DROP POLICY IF EXISTS "Hero sections are viewable by everyone" ON hero_sections;
DROP POLICY IF EXISTS "Admin can manage hero sections" ON hero_sections;

CREATE POLICY "Hero sections are viewable by everyone" 
ON hero_sections FOR SELECT 
USING (true);

CREATE POLICY "Admin can manage hero sections" 
ON hero_sections FOR ALL 
USING (true);

-- ============================================================================
-- SECTION 10: CREATE RLS POLICIES - ANALYTICS TABLES
-- ============================================================================

-- Page views
DROP POLICY IF EXISTS "Allow insert page_views" ON page_views;
DROP POLICY IF EXISTS "Allow select page_views" ON page_views;

CREATE POLICY "Allow insert page_views" ON page_views FOR INSERT WITH CHECK (true);
CREATE POLICY "Allow select page_views" ON page_views FOR SELECT USING (true);

-- Click events
DROP POLICY IF EXISTS "Allow insert click_events" ON click_events;
DROP POLICY IF EXISTS "Allow select click_events" ON click_events;

CREATE POLICY "Allow insert click_events" ON click_events FOR INSERT WITH CHECK (true);
CREATE POLICY "Allow select click_events" ON click_events FOR SELECT USING (true);

-- User sessions
DROP POLICY IF EXISTS "Allow insert user_sessions" ON user_sessions;
DROP POLICY IF EXISTS "Allow select user_sessions" ON user_sessions;
DROP POLICY IF EXISTS "Allow update user_sessions" ON user_sessions;

CREATE POLICY "Allow insert user_sessions" ON user_sessions FOR INSERT WITH CHECK (true);
CREATE POLICY "Allow select user_sessions" ON user_sessions FOR SELECT USING (true);
CREATE POLICY "Allow update user_sessions" ON user_sessions FOR UPDATE USING (true) WITH CHECK (true);

-- Conversion events
DROP POLICY IF EXISTS "Allow insert conversion_events" ON conversion_events;
DROP POLICY IF EXISTS "Allow select conversion_events" ON conversion_events;

CREATE POLICY "Allow insert conversion_events" ON conversion_events FOR INSERT WITH CHECK (true);
CREATE POLICY "Allow select conversion_events" ON conversion_events FOR SELECT USING (true);

-- Cart events
DROP POLICY IF EXISTS "Allow insert cart_events" ON cart_events;
DROP POLICY IF EXISTS "Allow select cart_events" ON cart_events;

CREATE POLICY "Allow insert cart_events" ON cart_events FOR INSERT WITH CHECK (true);
CREATE POLICY "Allow select cart_events" ON cart_events FOR SELECT USING (true);

-- ============================================================================
-- SECTION 11: CREATE INDEXES FOR PERFORMANCE
-- ============================================================================

-- Orders indexes
CREATE INDEX IF NOT EXISTS idx_orders_customer_email ON orders(customer_email);
CREATE INDEX IF NOT EXISTS idx_orders_customer_phone ON orders(customer_phone);
CREATE INDEX IF NOT EXISTS idx_orders_status ON orders(status);
CREATE INDEX IF NOT EXISTS idx_orders_created_at ON orders(created_at DESC);

-- Page views indexes
CREATE INDEX IF NOT EXISTS idx_page_views_created_at ON page_views(created_at DESC);
CREATE INDEX IF NOT EXISTS idx_page_views_session_id ON page_views(session_id);
CREATE INDEX IF NOT EXISTS idx_page_views_page_path ON page_views(page_path);

-- Click events indexes
CREATE INDEX IF NOT EXISTS idx_click_events_created_at ON click_events(created_at DESC);
CREATE INDEX IF NOT EXISTS idx_click_events_session_id ON click_events(session_id);

-- User sessions indexes
CREATE INDEX IF NOT EXISTS idx_user_sessions_session_id ON user_sessions(session_id);
CREATE INDEX IF NOT EXISTS idx_user_sessions_first_seen ON user_sessions(first_seen DESC);

-- Conversion events indexes
CREATE INDEX IF NOT EXISTS idx_conversion_events_created_at ON conversion_events(created_at DESC);
CREATE INDEX IF NOT EXISTS idx_conversion_events_event_type ON conversion_events(event_type);

-- Cart events indexes
CREATE INDEX IF NOT EXISTS idx_cart_events_created_at ON cart_events(created_at DESC);

-- ============================================================================
-- SECTION 12: INSERT DEFAULT DATA
-- ============================================================================

-- Insert default site settings
INSERT INTO site_settings (
  hero_type, hero_content, hero_title, hero_subtitle, 
  header_style, footer_style, site_name,
  homepage_product_limit, show_hero, product_grid_columns,
  product_card_style, product_card_height, product_page_layout,
  add_to_cart_button_text
)
VALUES (
  'image', '/hero-image.jpg', 'Fb5Star', 
  'Discover timeless pieces crafted for the modern minimalist',
  'minimal', 'simple', 'Fb5Star',
  8, false, 4,
  'minimal', 'square', 'default',
  'Add to Cart'
)
ON CONFLICT DO NOTHING;

-- Insert default hero section
INSERT INTO hero_sections (
  position, vertical_position, enabled, hero_type, hero_content, 
  hero_title, hero_subtitle, hero_gallery_images
)
VALUES (
  0, 'top', true, 'image', 
  'https://images.unsplash.com/photo-1441986300917-64674bd600d8?w=1200&h=600&fit=crop',
  'Fb5Star', 'Discover timeless pieces crafted for the modern minimalist',
  '[]'
)
ON CONFLICT DO NOTHING;

-- ============================================================================
-- SECTION 13: OPTIONAL SAMPLE PRODUCTS (COMMENT OUT IF NOT NEEDED)
-- ============================================================================

-- Uncomment below to insert sample products

/*
INSERT INTO products (name, description, price, currency, category, image, stock) VALUES
('Essential White Tee', 'Minimalist white cotton t-shirt with perfect fit', 19.99, 'USD', 'tops', 'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?w=500', 50),
('Black Minimal Dress', 'Elegant black dress for any occasion', 89.99, 'USD', 'dresses', 'https://images.unsplash.com/photo-1515372039744-b8f02a3ae446?w=500', 30),
('Classic Denim', 'High-quality denim jeans with modern cut', 69.99, 'USD', 'bottoms', 'https://images.unsplash.com/photo-1542272604-787c3835535d?w=500', 40),
('Leather Handbag', 'Premium leather handbag in minimalist design', 149.99, 'USD', 'accessories', 'https://images.unsplash.com/photo-1553062407-98eeb64c6a62?w=500', 20),
('Silk Blouse', 'Luxurious silk blouse in neutral tone', 79.99, 'USD', 'tops', 'https://images.unsplash.com/photo-1564257577-0a8c8b0b8b0b?w=500', 25),
('Wide Leg Trousers', 'Comfortable wide leg trousers for modern look', 59.99, 'USD', 'bottoms', 'https://images.unsplash.com/photo-1594633312681-425c7b97ccd1?w=500', 35)
ON CONFLICT DO NOTHING;

-- Generate slugs for sample products
UPDATE products 
SET slug = LOWER(REGEXP_REPLACE(REGEXP_REPLACE(name, '[^a-zA-Z0-9\s-]', '', 'g'), '\s+', '-', 'g'))
WHERE slug IS NULL;

-- Add SEO data to sample products
UPDATE products SET 
  seo_title = name || ' - Luxury Fashion | Fb5Star',
  seo_description = 'Shop ' || name || ' at Fb5Star. Premium quality ' || category || ' crafted for discerning fashion enthusiasts. Free shipping on luxury fashion.',
  seo_keywords = 'luxury ' || category || ', high-end fashion, designer ' || category || ', premium clothing, ' || name || ', Fb5Star fashion, luxury apparel, designer wear'
WHERE seo_title IS NULL;
*/

-- ============================================================================
-- END OF COMPLETE DATABASE SETUP
-- ============================================================================
-- All tables, policies, indexes, and default data have been created!
-- Your Supabase instance is now ready to use.
-- 
-- Next steps:
-- 1. Update your .env.local file with new Supabase credentials
-- 2. Add your products through the admin panel
-- 3. Test the checkout flow
-- ============================================================================
