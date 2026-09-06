# 🔍 Troubleshooting: Products Not Showing on Landing Page

## Step 1: Verify Products Are in Database

Run this SQL in **Supabase SQL Editor**:

```sql
-- Check if curtain products exist
SELECT COUNT(*) as curtain_count 
FROM products 
WHERE category = 'curtains';
```

### ✅ If you get a number > 0:
Products are in the database. Go to **Step 2**.

### ❌ If you get 0 or an error:
Products weren't inserted. **Solution:**
1. Open `insert-curtain-products.sql`
2. Copy the entire content
3. Paste into Supabase SQL Editor
4. Click "Run"
5. Check for any error messages

---

## Step 2: Check Supabase Connection

1. **Open your `.env.local` file** and verify:
   ```env
   NEXT_PUBLIC_SUPABASE_URL=https://your-project.supabase.co
   NEXT_PUBLIC_SUPABASE_ANON_KEY=your-anon-key-here
   ```

2. **Test the connection** - Create this test file:

**`test-supabase.js`**:
```javascript
require('dotenv').config({ path: '.env.local' });
const { createClient } = require('@supabase/supabase-js');

const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL;
const supabaseKey = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY;

console.log('URL:', supabaseUrl ? '✅ Found' : '❌ Missing');
console.log('Key:', supabaseKey ? '✅ Found' : '❌ Missing');

if (supabaseUrl && supabaseKey) {
  const supabase = createClient(supabaseUrl, supabaseKey);
  
  supabase.from('products').select('count').single()
    .then(({ data, error }) => {
      if (error) {
        console.log('❌ Connection error:', error.message);
      } else {
        console.log('✅ Connected successfully!');
      }
    });
}
```

Run: `node test-supabase.js`

---

## Step 3: Check API Endpoint

1. **Start your dev server**:
   ```bash
   npm run dev
   ```

2. **Test the API directly** - Open your browser and go to:
   ```
   http://localhost:3000/api/products
   ```

### Expected result:
You should see a JSON array with your products.

### ❌ If you see an empty array `[]`:
- Products are not being fetched from Supabase
- Check Supabase RLS policies (Row Level Security)

### ❌ If you see an error:
- Check your `.env.local` file
- Restart your dev server after changing `.env.local`

---

## Step 4: Check Row Level Security (RLS) Policies

Products might be blocked by RLS policies. Run this SQL:

```sql
-- Check if RLS is enabled
SELECT 
  schemaname, 
  tablename, 
  rowsecurity 
FROM pg_tables 
WHERE tablename = 'products';

-- View existing policies
SELECT * FROM pg_policies WHERE tablename = 'products';

-- FIX: Ensure public read access
DROP POLICY IF EXISTS "Products are viewable by everyone" ON products;

CREATE POLICY "Products are viewable by everyone" 
ON products FOR SELECT 
USING (true);

-- Verify products are now accessible
SELECT COUNT(*) FROM products;
```

---

## Step 5: Clear Cache and Restart

1. **Stop your dev server** (Ctrl+C)

2. **Clear Next.js cache**:
   ```bash
   Remove-Item -Recurse -Force .next
   ```

3. **Restart dev server**:
   ```bash
   npm run dev
   ```

4. **Hard refresh browser**:
   - Windows: `Ctrl + Shift + R`
   - Open DevTools (F12) → Network tab → Check "Disable cache"

---

## Step 6: Check Browser Console

1. Open your website
2. Press **F12** to open Developer Tools
3. Go to **Console** tab
4. Look for any red error messages

Common errors and fixes:

### Error: "Failed to fetch"
- Dev server not running
- Wrong URL in `.env.local`

### Error: "Network error"
- Supabase URL incorrect
- Firewall blocking connection

### Error: "Invalid API key"
- Wrong `NEXT_PUBLIC_SUPABASE_ANON_KEY`
- Check Supabase dashboard → Settings → API

---

## Step 7: Check Network Requests

1. Open **Developer Tools** (F12)
2. Go to **Network** tab
3. Reload the page
4. Look for a request to `/api/products`

### Click on the request and check:
- **Status**: Should be `200 OK`
- **Response**: Should show your products JSON
- **Preview**: Should show array of products

### ❌ If Status is 500:
- Server error
- Check terminal for error logs

### ❌ If products array is empty:
- Go back to Step 4 (RLS policies)

---

## Step 8: Manual Database Check

Run this comprehensive check in Supabase SQL Editor:

```sql
-- 1. Check if table exists
SELECT EXISTS (
  SELECT FROM information_schema.tables 
  WHERE table_schema = 'public' 
  AND table_name = 'products'
);

-- 2. Check total products
SELECT COUNT(*) as total FROM products;

-- 3. Check curtain products specifically
SELECT 
  id,
  name,
  category,
  price,
  image
FROM products 
WHERE category = 'curtains'
LIMIT 5;

-- 4. Check if images paths are correct
SELECT 
  name,
  image,
  CASE 
    WHEN image LIKE '/products/%' THEN '✅ Local path'
    WHEN image LIKE '%supabase.co%' THEN '✅ Supabase Storage'
    ELSE '❌ Invalid path'
  END as image_status
FROM products
WHERE category = 'curtains'
LIMIT 5;
```

---

## Step 9: Force Reload Products

Create a test page to force load products:

**`test-products.html`** (put in `public/` folder):
```html
<!DOCTYPE html>
<html>
<head>
  <title>Test Products</title>
</head>
<body>
  <h1>Product Test</h1>
  <div id="result"></div>
  <script>
    fetch('/api/products')
      .then(res => res.json())
      .then(data => {
        document.getElementById('result').innerHTML = 
          '<pre>' + JSON.stringify(data, null, 2) + '</pre>';
        console.log('Products:', data);
      })
      .catch(err => {
        document.getElementById('result').innerHTML = 
          '<p style="color:red">Error: ' + err.message + '</p>';
      });
  </script>
</body>
</html>
```

Visit: `http://localhost:3000/test-products.html`

---

## Quick Fix Checklist

Run through this checklist:

- [ ] Products are in Supabase (run verification SQL)
- [ ] `.env.local` has correct Supabase credentials
- [ ] Dev server is running (`npm run dev`)
- [ ] No errors in terminal
- [ ] No errors in browser console (F12)
- [ ] `/api/products` returns data
- [ ] RLS policies allow public read access
- [ ] Cleared `.next` cache
- [ ] Hard refreshed browser (Ctrl+Shift+R)
- [ ] Images exist in `public/products/` or Supabase Storage

---

## Still Not Working?

### Option 1: Check if ANY products show
Try adding a test product manually:

```sql
INSERT INTO products (name, description, price, category, image, stock)
VALUES (
  'Test Curtain',
  'This is a test product',
  99.99,
  'curtains',
  'https://images.unsplash.com/photo-1616628188859-7a11abb6fcc9?w=500',
  10
);
```

Refresh your page. If this shows up but your others don't, the SQL insert might have failed.

### Option 2: Re-run the complete setup

1. Backup existing data (if any)
2. Run `complete-database-setup.sql` again
3. Run `insert-curtain-products.sql` again
4. Verify with `verify-curtain-products.sql`

### Option 3: Check Supabase Dashboard

1. Go to Supabase Dashboard
2. Click **Table Editor**
3. Select **products** table
4. Manually verify products are there
5. Check the data looks correct

---

## 🆘 Emergency Fix

If nothing works, here's a minimal test:

1. **Delete all products**:
   ```sql
   DELETE FROM products WHERE category = 'curtains';
   ```

2. **Insert ONE test product**:
   ```sql
   INSERT INTO products (name, price, category, image, stock, slug)
   VALUES (
     'Test Curtain',
     99.99,
     'curtains',
     'https://images.unsplash.com/photo-1616628188859-7a11abb6fcc9?w=500',
     10,
     'test-curtain'
   );
   ```

3. **Verify it's there**:
   ```sql
   SELECT * FROM products WHERE slug = 'test-curtain';
   ```

4. **Restart dev server** and check if it shows

If this ONE product shows, then the issue was with the bulk insert. Try inserting products in smaller batches.

---

## 📞 Common Solutions Summary

| Problem | Solution |
|---------|----------|
| Empty page | Check if dev server is running |
| No products showing | Verify products in database + check RLS |
| Images not loading | Check image paths, verify files exist |
| API returns [] | Fix RLS policies |
| "Failed to fetch" | Check .env.local credentials |
| Old data showing | Clear cache + hard refresh |

---

**Next:** Once you identify the issue, follow the specific fix above! 🚀
