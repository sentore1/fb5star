-- ============================================================================
-- QUICK FIX: Make Products Visible
-- ============================================================================
-- Run this if products exist but aren't showing on your website
-- This fixes the most common issues: RLS policies
-- ============================================================================

-- STEP 1: Fix Row Level Security (RLS) Policies
-- This is the #1 reason products don't show

-- Drop old policies
DROP POLICY IF EXISTS "Products are viewable by everyone" ON products;
DROP POLICY IF EXISTS "Enable read access for all users" ON products;
DROP POLICY IF EXISTS "Allow public read" ON products;

-- Create correct policy for public viewing
CREATE POLICY "Products are viewable by everyone" 
ON products FOR SELECT 
USING (true);

-- Verify products are now accessible
SELECT 
  COUNT(*) as total_products,
  COUNT(CASE WHEN category = 'curtains' THEN 1 END) as curtain_products
FROM products;

-- STEP 2: Check if products exist
-- If this returns 0, you need to run insert-curtain-products.sql
SELECT 
  category,
  COUNT(*) as count,
  MIN(price) as min_price,
  MAX(price) as max_price
FROM products
GROUP BY category
ORDER BY count DESC;

-- STEP 3: View sample curtain products
SELECT 
  name,
  price,
  category,
  stock,
  LEFT(image, 50) as image_path
FROM products 
WHERE category = 'curtains'
ORDER BY created_at DESC
LIMIT 5;

-- ============================================================================
-- ADDITIONAL FIXES (if needed)
-- ============================================================================

-- Fix 1: Ensure RLS is enabled but not blocking
ALTER TABLE products ENABLE ROW LEVEL SECURITY;

-- Fix 2: Grant permissions
GRANT SELECT ON products TO anon;
GRANT SELECT ON products TO authenticated;

-- Fix 3: If you have site_settings issues
DROP POLICY IF EXISTS "Allow public read access" ON site_settings;
CREATE POLICY "Allow public read access" 
ON site_settings FOR SELECT 
USING (true);

-- ============================================================================
-- VERIFICATION
-- ============================================================================

-- This should return your products without errors
SELECT 
  id,
  name,
  price,
  currency,
  category
FROM products
WHERE category = 'curtains'
ORDER BY price ASC;

-- ============================================================================
-- SUCCESS MESSAGE
-- ============================================================================
-- If the above query returned products, your database is working correctly!
-- 
-- Next steps:
-- 1. Restart your dev server: npm run dev
-- 2. Clear browser cache (Ctrl+Shift+R)
-- 3. Check http://localhost:3000/api/products
-- 4. Products should now appear on your homepage
-- ============================================================================
