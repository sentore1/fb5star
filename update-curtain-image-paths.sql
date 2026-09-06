-- ============================================================================
-- UPDATE CURTAIN PRODUCT IMAGE PATHS
-- ============================================================================
-- Use this script AFTER uploading images to Supabase Storage
-- to update the image paths in your database
-- ============================================================================

-- ============================================================================
-- STEP 1: Check your current Supabase project URL
-- ============================================================================
-- Your Supabase Storage URL format is:
-- https://YOUR-PROJECT-ID.supabase.co/storage/v1/object/public/products/filename.jpg
--
-- Find your project ID in: Supabase Dashboard → Project Settings → API
-- Example: https://abcdefghijklmnop.supabase.co
-- ============================================================================

-- ============================================================================
-- STEP 2: View current image paths
-- ============================================================================

SELECT 
  name, 
  image,
  images
FROM products 
WHERE category = 'curtains'
LIMIT 5;

-- ============================================================================
-- STEP 3: Update image paths to use Supabase Storage URLs
-- ============================================================================

-- IMPORTANT: Replace 'YOUR-PROJECT-ID' with your actual Supabase project ID

-- Update main image path
UPDATE products 
SET image = REPLACE(
  image, 
  '/products/', 
  'https://YOUR-PROJECT-ID.supabase.co/storage/v1/object/public/products/'
)
WHERE category = 'curtains' 
AND image LIKE '/products/%';

-- Update gallery images (images column)
UPDATE products 
SET images = REPLACE(
  images::text, 
  '/products/', 
  'https://YOUR-PROJECT-ID.supabase.co/storage/v1/object/public/products/'
)::TEXT
WHERE category = 'curtains' 
AND images LIKE '%/products/%';

-- ============================================================================
-- STEP 4: Verify the updates
-- ============================================================================

SELECT 
  name, 
  image as main_image,
  LEFT(images, 100) as gallery_images_preview
FROM products 
WHERE category = 'curtains'
ORDER BY price ASC
LIMIT 10;

-- Count updated products
SELECT 
  COUNT(*) as total_updated,
  COUNT(CASE WHEN image LIKE '%supabase.co%' THEN 1 END) as with_supabase_urls
FROM products 
WHERE category = 'curtains';

-- ============================================================================
-- ALTERNATIVE: Keep local paths (if images are in public/products folder)
-- ============================================================================

-- If you want to keep images in your Next.js public folder instead of 
-- Supabase Storage, the current paths (/products/filename.jpg) are already
-- correct and no update is needed. Next.js will serve them automatically.

-- ============================================================================
-- OPTION: Mix of local and Supabase Storage
-- ============================================================================

-- You can also use a mix:
-- - Store small/frequently accessed images locally
-- - Store large/less frequent images in Supabase Storage

-- Update only specific products to use Supabase Storage:
/*
UPDATE products 
SET image = 'https://YOUR-PROJECT-ID.supabase.co/storage/v1/object/public/products/filename.jpg'
WHERE id = 'specific-product-uuid';
*/

-- ============================================================================
-- TROUBLESHOOTING
-- ============================================================================

-- Check if any products have broken image paths:
SELECT name, image 
FROM products 
WHERE category = 'curtains' 
AND (image IS NULL OR image = '');

-- Find products with local paths:
SELECT COUNT(*) 
FROM products 
WHERE category = 'curtains' 
AND image LIKE '/products/%';

-- Find products with Supabase Storage paths:
SELECT COUNT(*) 
FROM products 
WHERE category = 'curtains' 
AND image LIKE '%supabase.co%';

-- ============================================================================
-- ROLLBACK: Restore local paths if needed
-- ============================================================================

-- If you want to revert back to local paths:
/*
UPDATE products 
SET image = REPLACE(
  image, 
  'https://YOUR-PROJECT-ID.supabase.co/storage/v1/object/public/products/', 
  '/products/'
)
WHERE category = 'curtains' 
AND image LIKE '%supabase.co%';

UPDATE products 
SET images = REPLACE(
  images::text, 
  'https://YOUR-PROJECT-ID.supabase.co/storage/v1/object/public/products/', 
  '/products/'
)::TEXT
WHERE category = 'curtains' 
AND images LIKE '%supabase.co%';
*/

-- ============================================================================
-- DONE!
-- ============================================================================
-- Your image paths have been updated.
-- Test by visiting your website and checking if images load correctly.
-- ============================================================================
