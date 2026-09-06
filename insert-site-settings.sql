-- ============================================================================
-- INSERT DEFAULT SITE SETTINGS RECORD
-- ============================================================================
-- This creates the missing site_settings record that the Save button needs
-- ============================================================================

-- First, let's check if a record exists
SELECT 'Before insert:' as status, COUNT(*) as count FROM site_settings;

-- Delete any existing records (if any) to start fresh
-- UNCOMMENT the next line ONLY if you want to reset everything
-- DELETE FROM site_settings;

-- Insert the default site_settings record
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
  '',                         -- site_logo (empty for now)
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

-- Verify the record was created
SELECT 'After insert:' as status, COUNT(*) as count FROM site_settings;

-- Show the newly created record
SELECT 
  id,
  site_name,
  header_style,
  footer_style,
  homepage_product_limit,
  product_grid_columns,
  product_card_style,
  created_at
FROM site_settings;

-- ============================================================================
-- SUCCESS!
-- ============================================================================
-- You should now see:
-- - "After insert: count = 1"
-- - A record with your site settings
--
-- Now go back to your admin dashboard and try clicking
-- "Save Layout Settings" again - it should work!
-- ============================================================================
