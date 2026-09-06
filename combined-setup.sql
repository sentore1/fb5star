-- ============================================================================
-- COMBINED SQL SETUP FOR NEW SUPABASE INSTANCE
-- ============================================================================
-- This file combines all SQL migrations for setting up a fresh Supabase instance
-- Run this in your Supabase SQL Editor
-- ============================================================================

-- ============================================================================
-- SECTION 1: PRODUCTS TABLE MODIFICATIONS
-- ============================================================================

-- Add product slug column
ALTER TABLE products ADD COLUMN IF NOT EXISTS slug VARCHAR(255) UNIQUE;

-- Generate slugs from existing product names
UPDATE products 
SET slug = LOWER(REGEXP_REPLACE(REGEXP_REPLACE(name, '[^a-zA-Z0-9\s-]', '', 'g'), '\s+', '-', 'g'))
WHERE slug IS NULL;

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

-- Update existing products with SEO data
UPDATE products SET 
  seo_title = name || ' - Luxury Fashion | SIZA',
  seo_description = 'Shop ' || name || ' at SIZA. Premium quality ' || category || ' crafted for discerning fashion enthusiasts. Free shipping on luxury fashion.',
  seo_keywords = 'luxury ' || category || ', high-end fashion, designer ' || category || ', premium clothing, ' || name || ', SIZA fashion, luxury apparel, designer wear'
WHERE seo_title IS NULL;

-- ============================================================================
-- SECTION 2: ORDERS TABLE MODIFICATIONS
-- ============================================================================

-- Add customer contact and shipping address columns
ALTER TABLE orders ADD COLUMN IF NOT EXISTS customer_name VARCHAR(255);
ALTER TABLE orders ADD COLUMN IF NOT EXISTS customer_email VARCHAR(255);
ALTER TABLE orders ADD COLUMN IF NOT EXISTS customer_phone VARCHAR(50);
ALTER TABLE orders ADD COLUMN IF NOT EXISTS shipping_address TEXT;
ALTER TABLE orders ADD COLUMN IF NOT EXISTS shipping_city VARCHAR(100);
ALTER TABLE orders ADD COLUMN IF NOT EXISTS shipping_country VARCHAR(100);
ALTER TABLE orders ADD COLUMN IF NOT EXISTS shipping_postal_code VARCHAR(20);

-- Add indexes for better query performance
CREATE INDEX IF NOT EXISTS idx_orders_customer_email ON orders(customer_email);
CREATE INDEX IF NOT EXISTS idx_orders_customer_phone ON orders(customer_phone);
CREATE INDEX IF NOT EXISTS idx_orders_status ON orders(status);

-- ============================================================================
-- SECTION 3: ORDERS TABLE ROW LEVEL SECURITY (RLS) POLICIES
-- ============================================================================

-- Drop existing policies if they exist
DROP POLICY IF EXISTS "Admin can view all orders" ON orders;
DROP POLICY IF EXISTS "Admin can update orders" ON orders;

-- Allow ALL authenticated users to view orders
CREATE POLICY "Admin can view all orders"
ON orders
FOR SELECT
TO authenticated
USING (true);

-- Allow admin to update orders
CREATE POLICY "Admin can update orders"
ON orders
FOR UPDATE
TO authenticated
USING (true)
WITH CHECK (true);

-- ============================================================================
-- SECTION 4: SITE SETTINGS TABLE MODIFICATIONS
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

-- Update existing rows with default values for product page
UPDATE site_settings 
SET product_page_layout = 'default',
    add_to_cart_button_text = 'Add to Cart'
WHERE product_page_layout IS NULL;

-- Update existing rows with default value for card height
UPDATE site_settings 
SET product_card_height = 'square'
WHERE product_card_height IS NULL;

-- ============================================================================
-- SECTION 5: HERO SECTIONS TABLE MODIFICATIONS
-- ============================================================================

-- Add gallery images support
ALTER TABLE hero_sections 
ADD COLUMN IF NOT EXISTS hero_gallery_images TEXT DEFAULT '[]';

-- Add vertical position support
ALTER TABLE hero_sections 
ADD COLUMN IF NOT EXISTS vertical_position VARCHAR(20) DEFAULT 'top';

-- Update existing records
UPDATE hero_sections 
SET hero_gallery_images = '[]' 
WHERE hero_gallery_images IS NULL;

UPDATE hero_sections 
SET vertical_position = 'top' 
WHERE vertical_position IS NULL;

-- ============================================================================
-- SECTION 6: ANALYTICS TABLES (NEW TABLES)
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
-- SECTION 7: ANALYTICS ROW LEVEL SECURITY (RLS)
-- ============================================================================

-- Enable RLS on all analytics tables
ALTER TABLE page_views ENABLE ROW LEVEL SECURITY;
ALTER TABLE click_events ENABLE ROW LEVEL SECURITY;
ALTER TABLE user_sessions ENABLE ROW LEVEL SECURITY;
ALTER TABLE conversion_events ENABLE ROW LEVEL SECURITY;
ALTER TABLE cart_events ENABLE ROW LEVEL SECURITY;

-- Create policies for page_views
CREATE POLICY "Allow insert page_views" ON page_views FOR INSERT WITH CHECK (true);
CREATE POLICY "Allow select page_views" ON page_views FOR SELECT USING (true);

-- Create policies for click_events
CREATE POLICY "Allow insert click_events" ON click_events FOR INSERT WITH CHECK (true);
CREATE POLICY "Allow select click_events" ON click_events FOR SELECT USING (true);

-- Create policies for user_sessions
CREATE POLICY "Allow insert user_sessions" ON user_sessions FOR INSERT WITH CHECK (true);
CREATE POLICY "Allow select user_sessions" ON user_sessions FOR SELECT USING (true);
CREATE POLICY "Allow update user_sessions" ON user_sessions FOR UPDATE USING (true) WITH CHECK (true);

-- Create policies for conversion_events
CREATE POLICY "Allow insert conversion_events" ON conversion_events FOR INSERT WITH CHECK (true);
CREATE POLICY "Allow select conversion_events" ON conversion_events FOR SELECT USING (true);

-- Create policies for cart_events
CREATE POLICY "Allow insert cart_events" ON cart_events FOR INSERT WITH CHECK (true);
CREATE POLICY "Allow select cart_events" ON cart_events FOR SELECT USING (true);

-- ============================================================================
-- SECTION 8: ANALYTICS INDEXES FOR PERFORMANCE
-- ============================================================================

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
-- SECTION 9: VERIFICATION QUERIES (OPTIONAL - FOR CHECKING)
-- ============================================================================

-- Check orders table structure
-- SELECT column_name, data_type, is_nullable, column_default
-- FROM information_schema.columns 
-- WHERE table_name = 'orders'
-- ORDER BY ordinal_position;

-- Check site_settings columns
-- SELECT column_name, data_type, column_default
-- FROM information_schema.columns 
-- WHERE table_name = 'site_settings'
-- ORDER BY ordinal_position;

-- Check orders policies
-- SELECT policyname, roles, cmd, qual
-- FROM pg_policies
-- WHERE tablename = 'orders';

-- Check recent orders
-- SELECT * FROM orders ORDER BY created_at DESC LIMIT 10;

-- ============================================================================
-- END OF COMBINED SETUP
-- ============================================================================
-- All migrations have been applied successfully!
-- Your Supabase instance is now ready to use.
-- ============================================================================
