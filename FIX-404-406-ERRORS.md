# 🔧 Fix 404 and 406 Errors

## 🚨 The Errors You're Seeing

```
❌ 404 - categories table not found
❌ 404 - hero_sections table not found  
❌ 406 - site_settings access denied (RLS policy issue)
```

---

## ✅ Quick Fix (3 Steps)

### Step 1: Run the Fix SQL

1. **Open Supabase Dashboard** → **SQL Editor**
2. **Open the file**: `fix-missing-tables.sql`
3. **Copy all content** (Ctrl+A, Ctrl+C)
4. **Paste into SQL Editor**
5. **Click "RUN"**
6. Wait for success message

### Step 2: Insert Products (if not done yet)

1. **Open**: `insert-curtain-products.sql`
2. **Copy all content**
3. **Paste into SQL Editor**
4. **Click "RUN"**

### Step 3: Restart & Refresh

```bash
# Stop dev server (Ctrl+C)
npm run dev

# Then refresh browser with: Ctrl+Shift+R
```

---

## 🔍 What the Fix Does

The `fix-missing-tables.sql` script will:

✅ **Create missing tables**:
- `categories` - Product categories
- `hero_sections` - Homepage hero banners (if missing)

✅ **Fix RLS policies** on:
- `site_settings` - Site configuration
- `categories` - Category list
- `hero_sections` - Hero banners

✅ **Insert default data**:
- Default categories (curtains, drapes, blinds, accessories)
- Default site settings
- Default hero section

✅ **Grant proper permissions**:
- Public can read (SELECT)
- Authenticated users can manage (ALL)

---

## 🎯 Verify the Fix

After running the SQL, verify everything worked:

1. **Run verification SQL**:
   - Open `verify-database-setup.sql`
   - Run it in Supabase SQL Editor
   - Check all tables show `exists = true`

2. **Check your website**:
   - Refresh browser (Ctrl+Shift+R)
   - Open Developer Tools (F12) → Console
   - Errors should be gone! ✅

3. **Check data counts**:
   ```sql
   SELECT 'Products' as table_name, COUNT(*) FROM products
   UNION ALL
   SELECT 'Categories', COUNT(*) FROM categories
   UNION ALL
   SELECT 'Settings', COUNT(*) FROM site_settings;
   ```

Expected results:
- Products: 26 (or your count)
- Categories: 4+
- Settings: 1

---

## 🆘 If Errors Persist

### Still seeing 404 errors?

**Check table exists:**
```sql
SELECT table_name 
FROM information_schema.tables 
WHERE table_schema = 'public' 
AND table_name IN ('categories', 'hero_sections', 'site_settings');
```

If any are missing, the table didn't create. Re-run `fix-missing-tables.sql`.

### Still seeing 406 errors?

**Check RLS policies:**
```sql
SELECT tablename, policyname 
FROM pg_policies 
WHERE tablename IN ('site_settings', 'categories');
```

Should show policies for both tables. If not:

```sql
-- Fix site_settings access
DROP POLICY IF EXISTS "Allow public read access" ON site_settings;
CREATE POLICY "Allow public read access" 
ON site_settings FOR SELECT 
USING (true);

-- Fix categories access
DROP POLICY IF EXISTS "Categories are viewable by everyone" ON categories;
CREATE POLICY "Categories are viewable by everyone" 
ON categories FOR SELECT 
USING (true);
```

### Still not working?

**Nuclear option - Run complete setup:**

1. **Open**: `complete-database-setup.sql`
2. **Run entire file** in Supabase SQL Editor
3. This recreates everything from scratch

---

## 📊 Error Code Reference

| Error | Meaning | Fix |
|-------|---------|-----|
| **404** | Table doesn't exist | Create the table |
| **406** | RLS blocking access | Fix RLS policies |
| **500** | Server error | Check SQL syntax/permissions |
| **401** | Not authenticated | Check Supabase credentials |

---

## 🎉 Success Checklist

After fix, you should see:

- ✅ No 404 errors in console
- ✅ No 406 errors in console  
- ✅ Categories showing in navbar
- ✅ Site settings loading
- ✅ Products visible on homepage
- ✅ Hero sections working

---

## 🔄 Quick Troubleshoot Flow

```
1. Run: fix-missing-tables.sql
2. Run: verify-database-setup.sql
3. Check: All tables exist? ✅
4. Check: All have policies? ✅
5. Check: Row counts > 0? ✅
6. Restart: npm run dev
7. Refresh: Ctrl+Shift+R
8. Test: Errors gone? ✅
```

---

## 📞 Common Issues

### "relation does not exist"
→ Table not created. Run `fix-missing-tables.sql` again.

### "permission denied"  
→ RLS policy too strict. Run policy fixes in the SQL script.

### "no rows returned"
→ Table empty. Run INSERT statements to add default data.

---

**Ready to fix?** Run `fix-missing-tables.sql` now! 🚀

After running, the errors should disappear and your site will work perfectly.
