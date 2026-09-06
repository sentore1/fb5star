# 🎯 Complete Guide: Upload Curtain Products to Supabase

This guide will help you upload all your curtain product images to Supabase Storage and add them to your database with different prices.

## 📋 What You Have

- **26 curtain product images** in `public/products/` folder
- **SQL script** to insert 26 curtain products with varying prices ($59.99 - $199.99)
- **JavaScript upload script** to upload images to Supabase Storage

---

## 🚀 Step-by-Step Instructions

### Step 1: Upload Images to Supabase Storage

#### Option A: Using the JavaScript Script (Recommended - Automated)

1. **Make sure your Supabase credentials are in `.env.local`**:
   ```env
   NEXT_PUBLIC_SUPABASE_URL=your-project-url
   NEXT_PUBLIC_SUPABASE_ANON_KEY=your-anon-key
   SUPABASE_SERVICE_ROLE_KEY=your-service-key (optional, for admin operations)
   ```

2. **Run the upload script**:
   ```bash
   node upload-product-images.js
   ```

3. **What it does**:
   - Creates a `products` storage bucket in Supabase (if it doesn't exist)
   - Uploads all 26 images from `public/products/` to the bucket
   - Makes the bucket publicly accessible
   - Shows you the public URLs for each image

#### Option B: Manual Upload via Supabase Dashboard

1. Go to your **Supabase Dashboard** → **Storage**
2. Click **"New bucket"** and create a bucket named `products`
3. Make it **public** (toggle the public option)
4. Click on the `products` bucket
5. Click **"Upload files"**
6. Select all images from `e:\crippers\public\products\`
7. Click **Upload**

---

### Step 2: Run the SQL Script

1. **Open Supabase SQL Editor**:
   - Go to your Supabase Dashboard
   - Click on **SQL Editor** in the left sidebar

2. **Copy and paste the SQL script**:
   - Open the file `insert-curtain-products.sql`
   - Copy the entire content
   - Paste it into the SQL Editor

3. **Run the script**:
   - Click **"Run"** button
   - Wait for completion

4. **Verify**:
   - The script will insert 26 curtain products
   - Each product has a unique name, description, and price
   - Products include SEO fields for better search engine visibility

---

### Step 3: Update Image Paths (If Needed)

If you uploaded images to Supabase Storage, you may need to update the image paths in your database:

```sql
-- Get your Supabase project URL
-- Example: https://abcdefghijklmnop.supabase.co

-- Update all curtain product images to use Supabase Storage URLs
UPDATE products 
SET 
  image = 'https://YOUR-PROJECT-ID.supabase.co/storage/v1/object/public/products/' || 
          REPLACE(image, '/products/', ''),
  images = REPLACE(
    images::text, 
    '/products/', 
    'https://YOUR-PROJECT-ID.supabase.co/storage/v1/object/public/products/'
  )::TEXT
WHERE category = 'curtains';
```

**Replace** `YOUR-PROJECT-ID` with your actual Supabase project ID.

---

## 📦 What Gets Created

### 26 Curtain Products with Different Prices:

| Product Name | Price | Category |
|-------------|-------|----------|
| Elegant Black & White Minimalist Curtain | $89.99 | curtains |
| Luxury Beige Textured Drapes | $119.99 | curtains |
| Modern Grey Blackout Curtains | $94.99 | curtains |
| Classic White Sheer Curtains | $69.99 | curtains |
| Contemporary Patterned Curtains | $99.99 | curtains |
| Rustic Linen Blend Curtains | $109.99 | curtains |
| Velvet Luxury Curtains - Navy Blue | $139.99 | curtains |
| Scandinavian Minimalist Curtains | $84.99 | curtains |
| Botanical Print Curtains | $79.99 | curtains |
| Industrial Loft Style Curtains | $92.99 | curtains |
| Thermal Insulated Energy Saving Curtains | $104.99 | curtains |
| Coastal Blue & White Stripe Curtains | $74.99 | curtains |
| Bohemian Tassel Curtains | $97.99 | curtains |
| Premium Silk Blend Drapes | $159.99 | curtains |
| Farmhouse Gingham Check Curtains | $64.99 | curtains |
| Art Deco Geometric Curtains | $114.99 | curtains |
| Japanese Inspired Minimalist Curtains | $87.99 | curtains |
| Moroccan Tile Pattern Curtains | $102.99 | curtains |
| Mid-Century Modern Curtains | $89.99 | curtains |
| Luxury Hotel Collection Curtains | $149.99 | curtains |
| Children's Room Playful Curtains | $59.99 | curtains |
| Ombre Gradient Curtains | $94.99 | curtains |
| Textured Waffle Weave Curtains | $82.99 | curtains |
| Classic Damask Elegant Curtains | $124.99 | curtains |
| Smart Home Motorized Curtains | $199.99 | curtains |
| Eco-Friendly Bamboo Curtains | $77.99 | curtains |

### Each Product Includes:

✅ **Name** - Descriptive product name  
✅ **Description** - Detailed product description  
✅ **Price** - Unique price ranging from $59.99 to $199.99  
✅ **Category** - Set to "curtains"  
✅ **Images** - Primary image and gallery images  
✅ **Stock** - Initial stock quantity  
✅ **Slug** - SEO-friendly URL slug  
✅ **Sizes** - Multiple size options  
✅ **Colors** - Color variations  
✅ **SEO Fields** - Title, description, and keywords for search engines  

---

## ✅ Verification Steps

### 1. Check Database

```sql
-- Count curtain products
SELECT COUNT(*) as total_curtains FROM products WHERE category = 'curtains';

-- View all curtain products
SELECT name, price, stock, image FROM products WHERE category = 'curtains' ORDER BY price;
```

### 2. Check Storage

- Go to **Supabase Dashboard** → **Storage** → **products** bucket
- You should see all 26 images

### 3. Check Frontend

- Visit your website homepage
- Products should appear in the product grid
- Click on a curtain product to see details
- Images should load correctly

---

## 🔧 Troubleshooting

### Images Not Loading?

1. **Check if images are in Supabase Storage**:
   - Dashboard → Storage → products bucket
   - Verify files are there

2. **Check if bucket is public**:
   - Click on bucket settings
   - Make sure "Public bucket" is enabled

3. **Check image paths in database**:
   ```sql
   SELECT name, image FROM products WHERE category = 'curtains' LIMIT 5;
   ```
   - Paths should start with `/products/` or full Supabase Storage URL

4. **Update paths if needed**:
   - Use the SQL query from Step 3 above

### SQL Script Errors?

- Make sure you've run `complete-database-setup.sql` first
- Check that the `products` table exists
- Verify you have proper permissions

### Upload Script Errors?

- Check `.env.local` has correct Supabase credentials
- Make sure you have `@supabase/supabase-js` installed:
  ```bash
  npm install @supabase/supabase-js
  ```
- Check that images exist in `public/products/` folder

---

## 🎉 Success!

Once complete, you'll have:

✅ 26 unique curtain products in your database  
✅ All images uploaded to Supabase Storage  
✅ Products with different prices ranging from $59.99 to $199.99  
✅ SEO-optimized product pages  
✅ Multiple size and color options for each product  

Your customers can now browse and purchase curtains from your store!

---

## 📞 Need Help?

If you encounter issues:

1. Check the browser console for errors
2. Check Supabase logs in the Dashboard
3. Verify all environment variables are set correctly
4. Make sure your database schema is up to date

---

## 🔄 Future Updates

To add more products later:

1. Add images to `public/products/` folder
2. Upload them using the script or manually
3. Create new SQL INSERT statements following the same pattern
4. Run the SQL in Supabase SQL Editor

---

**Happy selling! 🛍️**
