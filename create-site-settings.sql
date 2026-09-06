-- ============================================================================
-- COMPLETE SITE_SETTINGS TABLE - ALL COLUMNS INCLUDED
-- ============================================================================
-- Run this ONLY ONCE to create the complete site_settings table
-- If table exists and has issues, use fix-site-settings-table-complete.sql instead
-- ============================================================================

-- Drop existing incomplete table (WARNING: This deletes all existing data!)
DROP TABLE IF EXISTS site_settings CASCADE;

-- Create complete site_settings table with ALL required columns
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

-- Insert default settings record
INSERT INTO site_settings (
  hero_type, hero_content, hero_title, hero_subtitle,
  header_style, footer_style, site_name, site_logo,
  show_hero, hero_border_radius, hero_overlay_enabled,
  hero_overlay_color, hero_overlay_opacity, hero_height,
  homepage_product_limit, product_grid_columns,
  product_card_style, price_badge_color,
  footer_text_size, footer_logo_size,
  footer_show_border, footer_show_logo,
  footer_title_size, footer_title_weight,
  footer_title_font, footer_title_line_height,
  footer_symbol, hero_button_text, hero_button_link,
  hero_title_font, hero_title_size,
  product_zoom_type, product_page_layout,
  add_to_cart_button_text, product_card_height,
  payment_paypal_enabled, payment_kpay_enabled
)
VALUES (
  'image', '/hero-image.jpg', 'Fb5Star',
  'Discover timeless pieces crafted for the modern minimalist',
  'minimal', 'simple', 'Fb5Star', '',
  false, 0, true, '#000000', 0.3, 400,
  8, 4, 'minimal', '#3b82f6',
  14, 32, false, true, 24, 600,
  'inherit', 1.2, '™', '', '',
  'inherit', 48, 'simple', 'default',
  'Add to Cart', 'square', true, true
);

-- Enable Row Level Security
ALTER TABLE site_settings ENABLE ROW LEVEL SECURITY;

-- Create RLS policies
CREATE POLICY "Allow public read access to site settings"
  ON site_settings FOR SELECT USING (true);

CREATE POLICY "Allow admin full access to site settings"
  ON site_settings FOR ALL USING (true);

-- Create auto-update timestamp function
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ language 'plpgsql';

-- Create trigger for auto-updating updated_at
CREATE TRIGGER update_site_settings_updated_at
  BEFORE UPDATE ON site_settings
  FOR EACH ROW
  EXECUTE FUNCTION update_updated_at_column();

-- Verify success
SELECT 'Site settings table created!' as status;
SELECT COUNT(*) as record_count FROM site_settings;
SELECT id, site_name, homepage_product_limit, product_grid_columns FROM site_settings;