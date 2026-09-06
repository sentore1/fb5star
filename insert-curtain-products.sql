-- ============================================================================
-- INSERT CURTAIN PRODUCTS WITH IMAGES
-- ============================================================================
-- This script inserts curtain products with images from the /public/products folder
-- 
-- BEFORE RUNNING THIS SCRIPT:
-- 1. Upload all images from e:\crippers\public\products to Supabase Storage
-- 2. Create a storage bucket called 'products' if it doesn't exist
-- 3. Make the bucket public or set appropriate policies
-- 4. Update the image URLs below if your storage path differs
--
-- TO UPLOAD IMAGES TO SUPABASE STORAGE:
-- Option 1: Use Supabase Dashboard
--   - Go to Storage in your Supabase Dashboard
--   - Create bucket named 'products' (make it public)
--   - Upload all images from public/products folder
--
-- Option 2: Use Supabase CLI or API (automated)
-- ============================================================================

-- ============================================================================
-- STEP 1: INSERT CURTAIN PRODUCTS
-- ============================================================================

-- Clear existing products if needed (OPTIONAL - comment out if you want to keep existing products)
-- DELETE FROM products WHERE category = 'curtains';

-- Insert curtain products with different prices and descriptions
INSERT INTO products (
  name, 
  description, 
  price, 
  currency, 
  category, 
  image, 
  images,
  stock,
  slug,
  sizes,
  colors,
  seo_title,
  seo_description,
  seo_keywords
) VALUES

-- Product 1
(
  'Elegant Black & White Minimalist Curtain',
  'Transform your space with our sophisticated black and white minimalist curtains. Perfect for modern interiors, these curtains offer both style and functionality with their timeless geometric patterns.',
  89.99,
  'USD',
  'curtains',
  '/products/Black_and_White_Minimalist_Fashion_Logo-removebg-preview.png',
  '["/products/Black_and_White_Minimalist_Fashion_Logo-removebg-preview.png", "/products/Black and White Minimalist Fashion Logo.png"]',
  45,
  'elegant-black-white-minimalist-curtain',
  '["Small (120x180cm)", "Medium (150x240cm)", "Large (200x270cm)", "Extra Large (250x300cm)"]',
  '["Black & White", "Charcoal & Cream"]',
  'Elegant Black & White Minimalist Curtain | Premium Quality Curtains',
  'Shop our elegant black and white minimalist curtains. Perfect for modern homes, these premium curtains add sophistication to any room. Free shipping on orders over $100.',
  'black white curtains, minimalist curtains, modern curtains, geometric curtains, home decor, window treatments, elegant curtains'
),

-- Product 2
(
  'Luxury Beige Textured Drapes',
  'Experience ultimate comfort with our luxury beige textured drapes. Made from premium materials, these curtains provide excellent light control while adding warmth to your living space.',
  119.99,
  'USD',
  'curtains',
  '/products/0216975ec79f7c8cd397626c3005e6b1.jpg',
  '["/products/0216975ec79f7c8cd397626c3005e6b1.jpg"]',
  30,
  'luxury-beige-textured-drapes',
  '["Standard (140x220cm)", "Large (180x260cm)", "Custom Size"]',
  '["Beige", "Cream", "Light Taupe"]',
  'Luxury Beige Textured Drapes | High-End Window Treatments',
  'Discover our luxury beige textured drapes. Premium quality curtains that combine elegance with functionality. Perfect for bedrooms and living rooms.',
  'beige curtains, luxury drapes, textured curtains, window drapes, bedroom curtains, living room curtains'
),

-- Product 3
(
  'Modern Grey Blackout Curtains',
  'Block out light and noise with our modern grey blackout curtains. Ideal for bedrooms, these curtains ensure a peaceful sleep environment while maintaining a sleek, contemporary look.',
  94.99,
  'USD',
  'curtains',
  '/products/0be35cd3c012a28e9bd0ffc9deda8085.jpg',
  '["/products/0be35cd3c012a28e9bd0ffc9deda8085.jpg"]',
  52,
  'modern-grey-blackout-curtains',
  '["Twin Set (100x200cm)", "Standard (140x220cm)", "King Size (200x270cm)"]',
  '["Charcoal Grey", "Light Grey", "Dark Grey"]',
  'Modern Grey Blackout Curtains | Sleep Better with Premium Quality',
  'Shop modern grey blackout curtains perfect for bedrooms. 100% light blocking, thermal insulation, and noise reduction. Premium quality guaranteed.',
  'grey blackout curtains, bedroom curtains, sleep curtains, noise blocking curtains, thermal curtains'
),

-- Product 4
(
  'Classic White Sheer Curtains',
  'Brighten your space with our classic white sheer curtains. These elegant curtains allow natural light to filter through while providing privacy and a soft, airy ambiance.',
  69.99,
  'USD',
  'curtains',
  '/products/1553ea8e5b0f704412db26b35649fde4.jpg',
  '["/products/1553ea8e5b0f704412db26b35649fde4.jpg"]',
  60,
  'classic-white-sheer-curtains',
  '["Standard (130x210cm)", "Large (160x250cm)"]',
  '["Pure White", "Off-White", "Ivory"]',
  'Classic White Sheer Curtains | Light & Airy Window Treatments',
  'Beautiful white sheer curtains that add elegance to any room. Let natural light in while maintaining privacy. Perfect for living rooms and dining areas.',
  'white sheer curtains, sheer drapes, light curtains, airy curtains, living room curtains'
),

-- Product 5
(
  'Contemporary Patterned Curtains',
  'Make a statement with our contemporary patterned curtains. Featuring unique designs, these curtains add personality and visual interest to any room while maintaining functionality.',
  99.99,
  'USD',
  'curtains',
  '/products/19e3c2ca6fac9237006796f5c3d1db25.jpg',
  '["/products/19e3c2ca6fac9237006796f5c3d1db25.jpg"]',
  38,
  'contemporary-patterned-curtains',
  '["Standard (145x230cm)", "Large (180x270cm)"]',
  '["Multi-Color", "Blue Pattern", "Green Pattern"]',
  'Contemporary Patterned Curtains | Designer Window Treatments',
  'Add personality to your space with our contemporary patterned curtains. Unique designs that blend style with functionality. Premium quality fabrics.',
  'patterned curtains, designer curtains, contemporary curtains, decorative curtains, statement curtains'
),

-- Product 6
(
  'Rustic Linen Blend Curtains',
  'Embrace natural beauty with our rustic linen blend curtains. These eco-friendly curtains offer a relaxed, organic look while providing durability and easy maintenance.',
  109.99,
  'USD',
  'curtains',
  '/products/1e3c9eb60ca37ba05bf56211904c1993.jpg',
  '["/products/1e3c9eb60ca37ba05bf56211904c1993.jpg"]',
  42,
  'rustic-linen-blend-curtains',
  '["Standard (140x220cm)", "Large (170x260cm)", "Custom"]',
  '["Natural Linen", "Beige Linen", "Grey Linen"]',
  'Rustic Linen Blend Curtains | Eco-Friendly Natural Curtains',
  'Discover our rustic linen blend curtains made from natural materials. Sustainable, stylish, and durable window treatments for modern homes.',
  'linen curtains, rustic curtains, natural curtains, eco-friendly curtains, sustainable curtains'
),

-- Product 7
(
  'Velvet Luxury Curtains - Navy Blue',
  'Indulge in luxury with our navy blue velvet curtains. These premium curtains add richness and sophistication while providing excellent insulation and light control.',
  139.99,
  'USD',
  'curtains',
  '/products/21a0f4b2a7ad0826bf6277d508e9cdf9.jpg',
  '["/products/21a0f4b2a7ad0826bf6277d508e9cdf9.jpg"]',
  25,
  'velvet-luxury-curtains-navy-blue',
  '["Standard (150x240cm)", "Large (200x280cm)"]',
  '["Navy Blue", "Royal Blue", "Midnight Blue"]',
  'Navy Blue Velvet Luxury Curtains | Premium Window Drapes',
  'Luxurious navy blue velvet curtains that add elegance and sophistication. Perfect for formal living rooms and master bedrooms. Premium quality velvet.',
  'velvet curtains, navy curtains, luxury curtains, blue curtains, formal curtains, premium drapes'
),

-- Product 8
(
  'Scandinavian Minimalist Curtains',
  'Achieve Nordic simplicity with our Scandinavian minimalist curtains. Clean lines and neutral tones create a calm, uncluttered atmosphere perfect for modern living.',
  84.99,
  'USD',
  'curtains',
  '/products/2bf23e69fff1bf4369981854139e4c2a.jpg',
  '["/products/2bf23e69fff1bf4369981854139e4c2a.jpg", "/products/2bf23e69fff1bf4369981854139e4c2a (1).jpg"]',
  48,
  'scandinavian-minimalist-curtains',
  '["Small (120x200cm)", "Medium (150x230cm)", "Large (180x260cm)"]',
  '["White", "Light Grey", "Soft Beige"]',
  'Scandinavian Minimalist Curtains | Nordic Style Window Treatments',
  'Embrace Nordic design with our Scandinavian minimalist curtains. Clean, simple, and elegant window treatments for modern homes.',
  'scandinavian curtains, nordic curtains, minimalist curtains, simple curtains, modern curtains'
),

-- Product 9
(
  'Botanical Print Curtains',
  'Bring nature indoors with our botanical print curtains. Featuring beautiful leaf and floral patterns, these curtains add a fresh, organic touch to any space.',
  79.99,
  'USD',
  'curtains',
  '/products/3de1262a5714d8058ba13c3803ec20c0.jpg',
  '["/products/3de1262a5714d8058ba13c3803ec20c0.jpg"]',
  55,
  'botanical-print-curtains',
  '["Standard (140x220cm)", "Large (170x250cm)"]',
  '["Green Botanical", "Multi-Color Floral", "Neutral Leaves"]',
  'Botanical Print Curtains | Nature-Inspired Window Treatments',
  'Add a touch of nature with our botanical print curtains. Beautiful leaf and floral patterns perfect for living rooms and bedrooms.',
  'botanical curtains, floral curtains, leaf pattern curtains, nature curtains, plant curtains'
),

-- Product 10
(
  'Industrial Loft Style Curtains',
  'Perfect for urban spaces, our industrial loft style curtains feature raw, contemporary designs that complement exposed brick and modern architecture.',
  92.99,
  'USD',
  'curtains',
  '/products/4431cb021eba80c6b12158ddd94e91a3.jpg',
  '["/products/4431cb021eba80c6b12158ddd94e91a3.jpg"]',
  35,
  'industrial-loft-style-curtains',
  '["Standard (150x240cm)", "Extra Large (220x300cm)"]',
  '["Charcoal", "Industrial Grey", "Dark Brown"]',
  'Industrial Loft Style Curtains | Urban Modern Window Treatments',
  'Complete your loft aesthetic with our industrial style curtains. Perfect for urban apartments and modern industrial spaces.',
  'industrial curtains, loft curtains, urban curtains, modern industrial curtains'
),

-- Product 11
(
  'Thermal Insulated Energy Saving Curtains',
  'Save on energy costs with our thermal insulated curtains. These curtains keep your home warm in winter and cool in summer while reducing noise.',
  104.99,
  'USD',
  'curtains',
  '/products/4d612481181f3c24089517ea4771487e.jpg',
  '["/products/4d612481181f3c24089517ea4771487e.jpg"]',
  40,
  'thermal-insulated-energy-saving-curtains',
  '["Standard (140x220cm)", "Large (180x260cm)", "Extra Large (220x280cm)"]',
  '["Cream", "Light Grey", "Taupe"]',
  'Thermal Insulated Curtains | Energy Efficient Window Treatments',
  'Reduce energy costs with our thermal insulated curtains. Keep your home comfortable year-round with these energy-efficient window treatments.',
  'thermal curtains, insulated curtains, energy saving curtains, efficient curtains'
),

-- Product 12
(
  'Coastal Blue & White Stripe Curtains',
  'Create a beach-house vibe with our coastal blue and white stripe curtains. Fresh and airy, these curtains bring seaside charm to your home.',
  74.99,
  'USD',
  'curtains',
  '/products/4d9e20b40542ace285052e3d784d71d6.jpg',
  '["/products/4d9e20b40542ace285052e3d784d71d6.jpg"]',
  50,
  'coastal-blue-white-stripe-curtains',
  '["Standard (135x215cm)", "Large (165x250cm)"]',
  '["Blue & White", "Navy & White", "Aqua & White"]',
  'Coastal Blue & White Stripe Curtains | Beach Style Drapes',
  'Bring coastal charm to your home with our blue and white stripe curtains. Perfect for creating a relaxed, beach-house atmosphere.',
  'coastal curtains, striped curtains, beach curtains, blue white curtains, nautical curtains'
),

-- Product 13
(
  'Bohemian Tassel Curtains',
  'Express your free spirit with our bohemian tassel curtains. Featuring unique textures and playful details, these curtains add character and warmth.',
  97.99,
  'USD',
  'curtains',
  '/products/6346bc6353b16b7bd384f7a7032ceae8.jpg',
  '["/products/6346bc6353b16b7bd384f7a7032ceae8.jpg"]',
  33,
  'bohemian-tassel-curtains',
  '["Standard (145x230cm)", "Large (180x270cm)"]',
  '["Cream Tassel", "Multi-Color", "Earth Tones"]',
  'Bohemian Tassel Curtains | Boho Chic Window Treatments',
  'Add bohemian flair with our unique tassel curtains. Perfect for eclectic and boho-style homes. Handcrafted details.',
  'bohemian curtains, boho curtains, tassel curtains, eclectic curtains, hippie curtains'
),

-- Product 14
(
  'Premium Silk Blend Drapes',
  'Experience ultimate luxury with our premium silk blend drapes. These elegant curtains have a beautiful sheen and drape beautifully for a sophisticated look.',
  159.99,
  'USD',
  'curtains',
  '/products/68a657e54a6a4bffe21c520f6e7c126a.jpg',
  '["/products/68a657e54a6a4bffe21c520f6e7c126a.jpg"]',
  20,
  'premium-silk-blend-drapes',
  '["Standard (150x240cm)", "Large (200x280cm)", "Custom"]',
  '["Champagne", "Pearl Grey", "Soft Gold"]',
  'Premium Silk Blend Drapes | Luxury Window Curtains',
  'Indulge in luxury with our premium silk blend drapes. Elegant, sophisticated curtains perfect for formal spaces. Made with finest materials.',
  'silk curtains, luxury drapes, premium curtains, elegant curtains, silk blend curtains'
),

-- Product 15
(
  'Farmhouse Gingham Check Curtains',
  'Embrace countryside charm with our farmhouse gingham check curtains. Classic patterns that add a cozy, homey feel to kitchens and dining areas.',
  64.99,
  'USD',
  'curtains',
  '/products/a4fa08b1d51f90cd7ab78d5755cac72d.jpg',
  '["/products/a4fa08b1d51f90cd7ab78d5755cac72d.jpg"]',
  45,
  'farmhouse-gingham-check-curtains',
  '["Small (100x180cm)", "Standard (130x210cm)"]',
  '["Red Check", "Blue Check", "Grey Check"]',
  'Farmhouse Gingham Check Curtains | Country Style Window Treatments',
  'Classic gingham check curtains perfect for farmhouse and country-style kitchens. Charming and timeless design.',
  'gingham curtains, farmhouse curtains, country curtains, check curtains, kitchen curtains'
),

-- Product 16
(
  'Art Deco Geometric Curtains',
  'Make a bold statement with our Art Deco geometric curtains. Inspired by the glamorous 1920s, these curtains feature striking patterns and metallic accents.',
  114.99,
  'USD',
  'curtains',
  '/products/a65c108f0b3382b7413efdef281ef135.jpg',
  '["/products/a65c108f0b3382b7413efdef281ef135.jpg"]',
  28,
  'art-deco-geometric-curtains',
  '["Standard (145x230cm)", "Large (180x270cm)"]',
  '["Black & Gold", "Navy & Silver", "Emerald & Bronze"]',
  'Art Deco Geometric Curtains | 1920s Glamour Window Treatments',
  'Stunning Art Deco geometric curtains with metallic accents. Add vintage glamour to your modern space.',
  'art deco curtains, geometric curtains, glamorous curtains, 1920s curtains, vintage curtains'
),

-- Product 17
(
  'Japanese Inspired Minimalist Curtains',
  'Find zen with our Japanese inspired minimalist curtains. Clean, simple designs that promote tranquility and balance in your living space.',
  87.99,
  'USD',
  'curtains',
  '/products/ae1b2d3d65ab37a90ba5be970904f495.jpg',
  '["/products/ae1b2d3d65ab37a90ba5be970904f495.jpg"]',
  42,
  'japanese-inspired-minimalist-curtains',
  '["Standard (140x220cm)", "Large (170x250cm)"]',
  '["Natural", "White", "Charcoal"]',
  'Japanese Inspired Minimalist Curtains | Zen Window Treatments',
  'Create a peaceful space with our Japanese inspired minimalist curtains. Perfect for meditation rooms and zen interiors.',
  'japanese curtains, zen curtains, minimalist curtains, asian inspired curtains'
),

-- Product 18
(
  'Moroccan Tile Pattern Curtains',
  'Add exotic flair with our Moroccan tile pattern curtains. Intricate designs inspired by traditional Moroccan architecture bring worldly sophistication.',
  102.99,
  'USD',
  'curtains',
  '/products/bfd3dbeafd4beabe5e59ae8eef85202e.jpg',
  '["/products/bfd3dbeafd4beabe5e59ae8eef85202e.jpg"]',
  32,
  'moroccan-tile-pattern-curtains',
  '["Standard (145x230cm)", "Large (180x270cm)"]',
  '["Blue Moroccan", "Terracotta", "Emerald Green"]',
  'Moroccan Tile Pattern Curtains | Exotic Window Treatments',
  'Bring Moroccan elegance to your home with our beautiful tile pattern curtains. Exotic designs for sophisticated spaces.',
  'moroccan curtains, tile pattern curtains, exotic curtains, mediterranean curtains'
),

-- Product 19
(
  'Mid-Century Modern Curtains',
  'Channel retro vibes with our mid-century modern curtains. Featuring period-appropriate colors and patterns, these curtains complement vintage and contemporary decor alike.',
  89.99,
  'USD',
  'curtains',
  '/products/ca3d4714f25443f29280215e3e62624f.jpg',
  '["/products/ca3d4714f25443f29280215e3e62624f.jpg"]',
  38,
  'mid-century-modern-curtains',
  '["Standard (140x220cm)", "Large (180x260cm)"]',
  '["Mustard Yellow", "Teal", "Burnt Orange"]',
  'Mid-Century Modern Curtains | Retro Window Treatments',
  'Authentic mid-century modern curtains with period-appropriate designs. Perfect for vintage and retro-inspired interiors.',
  'mid-century curtains, retro curtains, vintage curtains, 1960s curtains'
),

-- Product 20
(
  'Luxury Hotel Collection Curtains',
  'Bring five-star luxury home with our hotel collection curtains. Designed to the same specifications as luxury hotels, these curtains offer unparalleled quality.',
  149.99,
  'USD',
  'curtains',
  '/products/d3ad0b67bea849b9b2d020dec2a6cb2a.jpg',
  '["/products/d3ad0b67bea849b9b2d020dec2a6cb2a.jpg"]',
  22,
  'luxury-hotel-collection-curtains',
  '["Standard (150x240cm)", "Large (200x280cm)", "Suite Size (250x300cm)"]',
  '["Crisp White", "Platinum Grey", "Champagne"]',
  'Luxury Hotel Collection Curtains | Five-Star Window Treatments',
  'Experience hotel luxury at home with our premium hotel collection curtains. Same quality as 5-star hotels.',
  'hotel curtains, luxury curtains, five star curtains, premium curtains'
),

-- Product 21
(
  'Children''s Room Playful Curtains',
  'Delight your little ones with our children''s room playful curtains. Fun patterns and bright colors create a cheerful atmosphere for kids'' spaces.',
  59.99,
  'USD',
  'curtains',
  '/products/d4f250c7232b1a154ba72e3615392b96.jpg',
  '["/products/d4f250c7232b1a154ba72e3615392b96.jpg"]',
  65,
  'childrens-room-playful-curtains',
  '["Small (100x180cm)", "Standard (130x210cm)"]',
  '["Rainbow", "Stars & Moon", "Animal Print"]',
  'Children''s Room Playful Curtains | Kids Window Treatments',
  'Fun and colorful curtains perfect for children''s rooms. Safe, durable, and easy to clean. Your kids will love them!',
  'kids curtains, children curtains, playful curtains, nursery curtains, colorful curtains'
),

-- Product 22
(
  'Ombre Gradient Curtains',
  'Create visual interest with our ombre gradient curtains. Beautiful color transitions add depth and dimension to your windows.',
  94.99,
  'USD',
  'curtains',
  '/products/dae0cd6d5a117f2c1faa5f1bdde6b434.jpg',
  '["/products/dae0cd6d5a117f2c1faa5f1bdde6b434.jpg"]',
  40,
  'ombre-gradient-curtains',
  '["Standard (140x220cm)", "Large (180x260cm)"]',
  '["Blue Ombre", "Pink Ombre", "Grey Ombre"]',
  'Ombre Gradient Curtains | Modern Color Fade Window Treatments',
  'Beautiful ombre gradient curtains with smooth color transitions. Add modern artistic flair to any room.',
  'ombre curtains, gradient curtains, color fade curtains, modern curtains'
),

-- Product 23
(
  'Textured Waffle Weave Curtains',
  'Add tactile interest with our textured waffle weave curtains. The unique texture provides visual depth while offering privacy and light control.',
  82.99,
  'USD',
  'curtains',
  '/products/e16b8b7ee10364a20e1d6fa7b30c453e.jpg',
  '["/products/e16b8b7ee10364a20e1d6fa7b30c453e.jpg"]',
  47,
  'textured-waffle-weave-curtains',
  '["Standard (140x220cm)", "Large (170x250cm)"]',
  '["White Waffle", "Grey Waffle", "Natural Waffle"]',
  'Textured Waffle Weave Curtains | Unique Pattern Window Treatments',
  'Distinctive waffle weave texture curtains that add dimension and style. Perfect for modern and contemporary homes.',
  'waffle weave curtains, textured curtains, patterned curtains, dimensional curtains'
),

-- Product 24
(
  'Classic Damask Elegant Curtains',
  'Embrace traditional elegance with our classic damask curtains. Timeless patterns that add sophisticated charm to formal rooms.',
  124.99,
  'USD',
  'curtains',
  '/products/ed3fe28370b092b6c6e8f64c8644a829.jpg',
  '["/products/ed3fe28370b092b6c6e8f64c8644a829.jpg"]',
  26,
  'classic-damask-elegant-curtains',
  '["Standard (150x240cm)", "Large (200x280cm)"]',
  '["Ivory Damask", "Gold Damask", "Silver Damask"]',
  'Classic Damask Elegant Curtains | Traditional Window Treatments',
  'Timeless damask pattern curtains perfect for formal living rooms and dining rooms. Classic elegance never goes out of style.',
  'damask curtains, elegant curtains, traditional curtains, formal curtains'
),

-- Product 25
(
  'Smart Home Motorized Curtains',
  'Step into the future with our smart home motorized curtains. Control with voice commands or smartphone app for ultimate convenience.',
  199.99,
  'USD',
  'curtains',
  '/products/f244f8ebec61ab3d515dadecb21ef9c5.jpg',
  '["/products/f244f8ebec61ab3d515dadecb21ef9c5.jpg"]',
  15,
  'smart-home-motorized-curtains',
  '["Standard (150x240cm)", "Large (200x280cm)", "Custom Installation"]',
  '["Modern Grey", "Pure White", "Charcoal"]',
  'Smart Home Motorized Curtains | Automated Window Treatments',
  'Revolutionary motorized curtains with smart home integration. Control via voice, app, or schedule. The future of window treatments.',
  'smart curtains, motorized curtains, automated curtains, tech curtains, smart home curtains'
),

-- Product 26
(
  'Eco-Friendly Bamboo Curtains',
  'Go green with our eco-friendly bamboo curtains. Sustainable materials and natural beauty combine for an environmentally conscious choice.',
  77.99,
  'USD',
  'curtains',
  '/products/ff4ed1ea1ef4a5cbd67b160f37a969b9.jpg',
  '["/products/ff4ed1ea1ef4a5cbd67b160f37a969b9.jpg"]',
  50,
  'eco-friendly-bamboo-curtains',
  '["Standard (140x220cm)", "Large (180x260cm)"]',
  '["Natural Bamboo", "Light Brown", "Honey Tone"]',
  'Eco-Friendly Bamboo Curtains | Sustainable Window Treatments',
  'Sustainable bamboo curtains that are good for you and the planet. Natural, renewable materials with beautiful organic texture.',
  'bamboo curtains, eco curtains, sustainable curtains, green curtains, natural curtains'
)

ON CONFLICT (slug) DO NOTHING;

-- ============================================================================
-- STEP 2: VERIFY INSERTION
-- ============================================================================

-- Check how many curtain products were inserted
SELECT COUNT(*) as total_curtain_products FROM products WHERE category = 'curtains';

-- View all curtain products
SELECT 
  name, 
  price, 
  currency,
  stock,
  slug,
  LEFT(description, 50) as description_preview
FROM products 
WHERE category = 'curtains'
ORDER BY price ASC;

-- ============================================================================
-- STEP 3: CREATE STORAGE BUCKET (Run in Supabase SQL Editor)
-- ============================================================================

-- Note: Storage buckets are typically created through the Supabase Dashboard
-- If you want to create via SQL, you need storage permissions

-- Insert storage bucket (if not exists)
INSERT INTO storage.buckets (id, name, public)
VALUES ('products', 'products', true)
ON CONFLICT (id) DO NOTHING;

-- ============================================================================
-- STEP 4: SET UP STORAGE POLICIES
-- ============================================================================

-- Allow public access to view product images
CREATE POLICY "Public Access for Product Images"
ON storage.objects FOR SELECT
USING (bucket_id = 'products');

-- Allow authenticated users to upload product images
CREATE POLICY "Authenticated users can upload product images"
ON storage.objects FOR INSERT
TO authenticated
WITH CHECK (bucket_id = 'products');

-- Allow authenticated users to update product images
CREATE POLICY "Authenticated users can update product images"
ON storage.objects FOR UPDATE
TO authenticated
USING (bucket_id = 'products');

-- Allow authenticated users to delete product images
CREATE POLICY "Authenticated users can delete product images"
ON storage.objects FOR DELETE
TO authenticated
USING (bucket_id = 'products');

-- ============================================================================
-- DONE!
-- ============================================================================
-- Your curtain products have been inserted into the database.
-- 
-- NEXT STEPS:
-- 1. Upload images from e:\crippers\public\products to Supabase Storage bucket 'products'
-- 2. If image paths differ, update the products table accordingly
-- 3. Test your products on the frontend
-- 
-- To update image paths if needed:
-- UPDATE products 
-- SET image = 'https://your-project.supabase.co/storage/v1/object/public/products/' || image
-- WHERE category = 'curtains' AND image LIKE '/products/%';
-- ============================================================================
