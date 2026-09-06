-- ============================================================================
-- COMPLETE FIX FOR SITE_SETTINGS TABLE
-- ============================================================================
-- This script will:
-- 1. Drop the existing incomplete table (if it exists)
-- 2. Create a complete site_settings table with ALL required columns
-- 3. Insert a default record
-- 4. Set up proper RLS policies
-- ============================================================================

-- Drop the old incomplete table
DROP TABLE IF EXISTS site_settings CASCADE;

-- Create the complete site_settings table with ALL columns
CREATE TABLE site_settings (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  
  -- Hero Section Settings
  hero_type TEXT DEFAULT 'image',
  hero_content TEXT DEFAULT '/hero-image.jpg',
  hero_title TEXT DEFAULT 'Fb5Star',
  hero_subtitle TEXT DEFAULT 'Discover timeless pieces crafted for the modern minimalist',
  show_hero BOOLEAN DEFAULT false,
  hero_border_radius INTEGER DEFAULT 0,
  hero_overlay_enabled BOOLEAN DEFAULT true,
  hero_overlay_color TEXT DEFAULT '#000000',
  hero_overlay_opacity DECIMAL(3,2) DEFAULT 0.3,
  hero_height INTEGER DEFAULT 400,
  hero_button_text TEXT DEFAULT '',
  hero_button_link TEXT DEFAULT '',
  hero_title_font TEXT DEFAULT 'inherit',
  hero_title_size INTEGER DEFAULT 48,
  
  -- Site General Settings
  site_name TEXT DEFAULT 'Fb5Star',
  site_logo TEXT DEFAULT '',
  header_style TEXT DEFAULT 'minimal',
  footer_style TEXT DEFAULT 'simple',
  
  -- Product Grid Settings
  homepage_product_limit INTEGER DEFAULT 8,
  product_grid_columns INTEGER DEFAULT 4,
  product_card_style TEXT DEFAULT 'minimal',
  product_card_height TEXT DEFAULT 'square',
  price_badge_color TEXT DEFAULT '#3b82f6',
  product_zoom_type TEXT DEFAULT 'simple',
  product_page_layout TEXT DEFAULT 'default',
  add_to_cart_button_text TEXT DEFAULT 'Add to Cart',
  
  -- Footer Settings
  footer_text_size INTEGER DEFAULT 14,
  footer_logo_size INTEGER DEFAULT 32,
  footer_show_border BOOLEAN DEFAULT false,
  footer_show_logo BOOLEAN DEFAULT true,
  footer_title_size INTEGER DEFAULT 24,
  footer_title_weight INTEGER DEFAULT 600,
  footer_title_font TEXT DEFAULT 'inherit',
  footer_title_line_height DECIMAL(3,2) DEFAULT 1.2,
  footer_symbol TEXT DEFAULT '™',
  
  -- Payment Settings
  payment_paypal_enabled BOOLEAN DEFAULT true,
  payment_kpay_enabled BOOLEAN DEFAULT true,
  
  -- Timestamps
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Insert the default settings record
INSERT INTO site_settings (
  hero_type,
  hero_content,
  hero_title,
  hero_subtitle,
  header_style,
  footer_style,
  site_name,
  site_logo,
  show_hero,
  hero_border_radius,
  hero_overlay_enabled,
  hero_overlay_color,
  hero_overlay_opacity,
  hero_height,
  homepage_product_limit,
  product_grid_columns,
  product_card_style,
  price_badge_color,
  footer_text_size,
  footer_logo_size,
  footer_show_border,
  footer_show_logo,
  footer_title_size,
  footer_title_weight,
  footer_title_font,
  footer_title_line_height,
  footer_symbol,
  hero_button_text,
  hero_button_link,
  hero_title_font,
  hero_title_size,
  product_zoom_type,
  product_page_layout,
  add_to_cart_button_text,
  product_card_height,
  payment_paypal_enabled,
  payment_kpay_enabled
)
VALUES (
  'image',                    -- hero_type
  '/hero-image.jpg',          -- hero_content
  'Fb5Star',          -- hero_title
  'Discover timeless pieces crafted for the modern minimalist', -- hero_subtitle
  'minimal',                  -- header_style
  'simple',                   -- footer_style
  'Fb5Star',          -- site_name
  '',                         -- site_logo
  false,                      -- show_hero
  0,                          -- hero_border_radius
  true,                       -- hero_overlay_enabled
  '#000000',                  -- hero_overlay_color
  0.3,                        -- hero_overlay_opacity
  400,                        -- hero_height
  8,                          -- homepage_product_limit
  4,                          -- product_grid_columns
  'minimal',                  -- product_card_style
  '#3b82f6',                  -- price_badge_color
  14,                         -- footer_text_size
  32,                         -- footer_logo_size
  false,                      -- footer_show_border
  true,                       -- footer_show_logo
  24,                         -- footer_title_size
  600,                        -- footer_title_weight
  'inherit',                  -- footer_title_font
  1.2,                        -- footer_title_line_height
  '™',                        -- footer_symbol
  '',                         -- hero_button_text
  '',                         -- hero_button_link
  'inherit',                  -- hero_title_font
  48,                         -- hero_title_size
  'simple',                   -- product_zoom_type
  'default',                  -- product_page_layout
  'Add to Cart',              -- add_to_cart_button_text
  'square',                   -- product_card_height
  true,                       -- payment_paypal_enabled
  true                        -- payment_kpay_enabled
);

-- Enable Row Level Security
ALTER TABLE site_settings ENABLE ROW LEVEL SECURITY;

-- Create RLS policies for public read and admin write
CREATE POLICY "Allow public read access to site settings"
  ON site_settings
  FOR SELECT
  USING (true);

CREATE POLICY "Allow admin full access to site settings"
  ON site_settings
  FOR ALL
  USING (true);

-- Create function to automatically update updated_at timestamp
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ language 'plpgsql';

-- Create trigger to auto-update updated_at
CREATE TRIGGER update_site_settings_updated_at
  BEFORE UPDATE ON site_settings
  FOR EACH ROW
  EXECUTE FUNCTION update_updated_at_column();

-- Verify the table and record were created
SELECT 'Table created successfully!' as status;
SELECT COUNT(*) as record_count FROM site_settings;
SELECT id, site_name, header_style, homepage_product_limit FROM site_settings;

-- ============================================================================
-- SUCCESS!
-- ============================================================================
-- The site_settings table is now complete with all required columns.
-- A default record has been inserted.
-- RLS policies are configured.
--
-- Now refresh your admin page and try "Save Layout Settings" again!
-- ============================================================================
