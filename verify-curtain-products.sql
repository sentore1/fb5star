-- ============================================================================
-- VERIFY CURTAIN PRODUCTS IN DATABASE
-- ============================================================================
-- Run these queries to check if your curtain products are in the database
-- ============================================================================

-- Check total number of products
SELECT 
  COUNT(*) as total_products,
  COUNT(CASE WHEN category = 'curtains' THEN 1 END) as curtain_products
FROM products;

-- List all curtain products with details
SELECT 
  id,
  name,
  price,
  currency,
  category,
  stock,
  slug,
  LEFT(image, 50) as image_path,
  created_at
FROM products 
WHERE category = 'curtains'
ORDER BY created_at DESC;

-- Check if any products exist at all
SELECT COUNT(*) as total_products FROM products;

-- If no products found, check if table exists
SELECT 
  table_name 
FROM information_schema.tables 
WHERE table_schema = 'public' 
AND table_name = 'products';

-- Check product categories distribution
SELECT 
  category,
  COUNT(*) as count
FROM products
GROUP BY category
ORDER BY count DESC;

-- Show all products (not just curtains)
SELECT 
  name,
  category,
  price,
  LEFT(image, 40) as image_preview
FROM products
ORDER BY created_at DESC
LIMIT 10;
