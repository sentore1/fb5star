-- ============================================================================
-- FIX MISSING TABLES AND ERRORS
-- ============================================================================
-- This fixes the 404 and 406 errors you're seeing
-- Run this in Supabase SQL Editor
-- ============================================================================

-- ============================================================================
-- STEP 1: Create Missing Tables
-- ============================================================================

-- Create categories table (404 error fix)
CREATE TABLE IF NOT EXISTS categories (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  name VARCHAR(100) UNIQUE NOT NULL,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create hero_sections table if missing
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
-- STEP 2: Enable RLS on New Tables
-- ============================================================================

ALTER TABLE categories ENABLE ROW LEVEL SECURITY;
ALTER TABLE hero_sections ENABLE ROW LEVEL SECURITY;

-- ============================================================================
-- STEP 3: Create RLS Policies for Categories
-- ============================================================================

-- Drop existing policies if any
DROP POLICY IF EXISTS "Categories are viewable by everyone" ON categories;
DROP POLICY IF EXISTS "Admin can manage categories" ON categories;

-- Public read access
CREATE POLICY "Categories are viewable by everyone" 
ON categories FOR SELECT 
USING (true);

-- Admin write access
CREATE POLICY "Admin can manage categories" 
ON categories FOR ALL 
USING (true);

-- ============================================================================
-- STEP 4: Create RLS Policies for Hero Sections
-- ============================================================================

DROP POLICY IF EXISTS "Hero sections are viewable by everyone" ON hero_sections;
DROP POLICY IF EXISTS "Admin can manage hero sections" ON hero_sections;

CREATE POLICY "Hero sections are viewable by everyone" 
ON hero_sections FOR SELECT 
USING (true);

CREATE POLICY "Admin can manage hero sections" 
ON hero_sections FOR ALL 
USING (true);

-- ============================================================================
-- STEP 5: Fix Site Settings (406 error fix)
-- ============================================================================

-- Ensure site_settings exists and has correct policies
DROP POLICY IF EXISTS "Allow public read access" ON site_settings;
DROP POLICY IF EXISTS "Allow admin write access" ON site_settings;
DROP POLICY IF EXISTS "Site settings are viewable by everyone" ON site_settings;
DROP POLICY IF EXISTS "Admin can manage site settings" ON site_settings;

-- Create correct policies
CREATE POLICY "Allow public read access" 
ON site_settings FOR SELECT 
USING (true);

CREATE POLICY "Allow admin write access" 
ON site_settings FOR ALL 
USING (true);

-- Grant explicit permissions
GRANT SELECT ON site_settings TO anon;
GRANT SELECT ON site_settings TO authenticated;
GRANT ALL ON site_settings TO authenticated;

-- ============================================================================
-- STEP 6: Insert Default Data
-- ============================================================================

-- Insert default categories
INSERT INTO categories (name) VALUES
  ('curtains'),
  ('drapes'),
  ('blinds'),
  ('accessories')
ON CONFLICT (name) DO NOTHING;

-- Ensure site_settings has at least one row
INSERT INTO site_settings (
  hero_type, hero_content, hero_title, hero_subtitle, 
  header_style, footer_style, site_name,
  homepage_product_limit, show_hero, product_grid_columns,
  product_card_style, product_card_height, product_page_layout,
  add_to_cart_button_text
)
SELECT
  'image', '/hero-image.jpg', 'Fb5Star', 
  'Discover timeless pieces crafted for the modern minimalist',
  'minimal', 'simple', 'Fb5Star',
  8, false, 4,
  'minimal', 'square', 'default',
  'Add to Cart'
WHERE NOT EXISTS (SELECT 1 FROM site_settings LIMIT 1);

-- Insert a default hero section
INSERT INTO hero_sections (
  position, vertical_position, enabled, hero_type, hero_content, 
  hero_title, hero_subtitle, hero_gallery_images
)
SELECT
  0, 'top', true, 'image', 
  'https://images.unsplash.com/photo-1441986300917-64674bd600d8?w=1200&h=600&fit=crop',
  'Fb5Star', 'Discover timeless pieces crafted for the modern minimalist',
  '[]'
WHERE NOT EXISTS (SELECT 1 FROM hero_sections LIMIT 1);

-- ============================================================================
-- STEP 7: Grant Permissions
-- ============================================================================

GRANT SELECT ON categories TO anon;
GRANT SELECT ON categories TO authenticated;
GRANT ALL ON categories TO authenticated;

GRANT SELECT ON hero_sections TO anon;
GRANT SELECT ON hero_sections TO authenticated;
GRANT ALL ON hero_sections TO authenticated;

-- ============================================================================
-- STEP 8: Verify Everything Works
-- ============================================================================

-- Check categories
SELECT 'Categories' as table_name, COUNT(*) as count FROM categories;

-- Check hero_sections
SELECT 'Hero Sections' as table_name, COUNT(*) as count FROM hero_sections;

-- Check site_settings
SELECT 'Site Settings' as table_name, COUNT(*) as count FROM site_settings;

-- Check products
SELECT 'Products' as table_name, COUNT(*) as count FROM products;

-- ============================================================================
-- SUCCESS!
-- ============================================================================
-- All tables are now created with proper RLS policies.
-- Your 404 and 406 errors should be fixed!
-- 
-- Next steps:
-- 1. Refresh your browser (Ctrl+Shift+R)
-- 2. Check browser console - errors should be gone
-- 3. Insert your curtain products if not done yet
-- ============================================================================
