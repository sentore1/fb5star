-- ============================================================================
-- VERIFY DATABASE SETUP
-- ============================================================================
-- Run this to check if all tables exist and have data
-- ============================================================================

-- Check if all required tables exist
SELECT 
  'products' as table_name,
  EXISTS (
    SELECT FROM information_schema.tables 
    WHERE table_schema = 'public' AND table_name = 'products'
  ) as exists
UNION ALL
SELECT 
  'categories',
  EXISTS (
    SELECT FROM information_schema.tables 
    WHERE table_schema = 'public' AND table_name = 'categories'
  )
UNION ALL
SELECT 
  'site_settings',
  EXISTS (
    SELECT FROM information_schema.tables 
    WHERE table_schema = 'public' AND table_name = 'site_settings'
  )
UNION ALL
SELECT 
  'hero_sections',
  EXISTS (
    SELECT FROM information_schema.tables 
    WHERE table_schema = 'public' AND table_name = 'hero_sections'
  )
UNION ALL
SELECT 
  'orders',
  EXISTS (
    SELECT FROM information_schema.tables 
    WHERE table_schema = 'public' AND table_name = 'orders'
  )
UNION ALL
SELECT 
  'order_items',
  EXISTS (
    SELECT FROM information_schema.tables 
    WHERE table_schema = 'public' AND table_name = 'order_items'
  );

-- Check row counts for each table
SELECT 'Products' as table_name, COUNT(*) as row_count FROM products
UNION ALL
SELECT 'Categories', COUNT(*) FROM categories
UNION ALL
SELECT 'Site Settings', COUNT(*) FROM site_settings
UNION ALL
SELECT 'Hero Sections', COUNT(*) FROM hero_sections
UNION ALL
SELECT 'Orders', COUNT(*) FROM orders;

-- Check RLS policies on products
SELECT 
  schemaname, 
  tablename, 
  policyname,
  cmd as operation
FROM pg_policies 
WHERE tablename IN ('products', 'categories', 'site_settings', 'hero_sections')
ORDER BY tablename, policyname;

-- Check if RLS is enabled
SELECT 
  schemaname, 
  tablename, 
  rowsecurity as rls_enabled
FROM pg_tables 
WHERE tablename IN ('products', 'categories', 'site_settings', 'hero_sections', 'orders')
ORDER BY tablename;

-- Test actual data access
SELECT 'Sample Products' as test, COUNT(*) as count FROM products WHERE category = 'curtains';
SELECT 'Sample Categories' as test, name FROM categories LIMIT 5;
SELECT 'Sample Settings' as test, site_name FROM site_settings LIMIT 1;

-- ============================================================================
-- INTERPRETATION GUIDE
-- ============================================================================
-- 
-- All tables should show "exists = true"
-- Row counts:
--   - products: Should have 26 (or your number of curtain products)
--   - categories: Should have 4+
--   - site_settings: Should have 1
--   - hero_sections: Should have 1+
--   - orders: May be 0 if no orders yet
--
-- RLS should be enabled (rls_enabled = true) for all tables
-- Each table should have at least 2 policies (read + write)
--
-- If anything shows false or 0, run fix-missing-tables.sql
-- ============================================================================
