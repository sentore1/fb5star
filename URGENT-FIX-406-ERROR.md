# 🚨 URGENT FIX: 406 Error - Table Missing or Incomplete

## The Error You're Seeing
```
GET https://xnocjoyrviokrorwlxdc.supabase.co/rest/v1/site_settings?select=id 406 (Not Acceptable)
```

## What This Means
The `site_settings` table either:
1. Doesn't exist at all, OR
2. Exists but is missing required columns

## The Solution (3 Minutes)

### Step 1: Open Supabase SQL Editor
1. Go to: https://app.supabase.com/project/xnocjoyrviokrorwlxdc
2. Click **"SQL Editor"** in left sidebar
3. Click **"New Query"**

### Step 2: Run the Complete Fix Script

**Option A: Use the file already open in your editor**
- The file `create-site-settings.sql` is already open
- Copy ALL the content
- Paste into Supabase SQL Editor
- Click **"Run"** (or Ctrl+Enter)

**Option B: Use the dedicated fix file**
- Open: `fix-site-settings-table-complete.sql`
- Copy everything
- Paste into Supabase SQL Editor
- Click **"Run"**

### Step 3: Verify It Worked
After running the script, you should see:
```
status: "Site settings table created!"
record_count: 1
```

And a table showing:
- id: [some UUID]
- site_name: Crapper Curtain
- homepage_product_limit: 8
- product_grid_columns: 4

### Step 4: Test the Admin Page
1. Go back to: http://localhost:3000/admin
2. **Refresh the page** (Ctrl+R or F5) - IMPORTANT!
3. Click "Layout" tab
4. Change any setting
5. Click "Save Layout Settings"
6. You should see: **"Settings saved successfully!"** ✅

---

## What the Script Does

1. ✅ Drops any incomplete/old site_settings table
2. ✅ Creates a new complete table with ALL 38 required columns
3. ✅ Inserts a default settings record
4. ✅ Sets up Row Level Security (RLS) policies
5. ✅ Creates auto-update triggers for timestamps

---

## If You Get Errors

### Error: "relation does not exist"
**This is normal!** It means the old table didn't exist. The script will create it fresh.

### Error: "policy already exists"
If you see policy errors:
1. The script tried to create policies that already exist
2. This is usually fine - the table is still created
3. Just verify the final SELECT shows your record

### Error: "permission denied"
You might not have the right permissions. Try:
1. Make sure you're the project owner in Supabase
2. Or run this simpler version (without RLS policies):
   - Use: `fix-site-settings-table-complete.sql` but remove the RLS policy lines
   - Contact me for help

---

## After Running the Script

### ✅ Things That Should Now Work:
- Save Layout Settings button
- Save Site Settings button
- Save Hero Settings button
- All admin settings tabs

### 🔍 How to Verify:
```sql
-- Run this in Supabase SQL Editor to check:
SELECT * FROM site_settings;
```

You should see exactly 1 row with all your default settings.

---

## Need to Reset Everything?

If you want to start completely fresh:
```sql
DROP TABLE IF EXISTS site_settings CASCADE;
```

Then run `create-site-settings.sql` again.

---

## Files Available:
1. ✅ **create-site-settings.sql** (updated, ready to use)
2. ✅ **fix-site-settings-table-complete.sql** (alternative version)
3. ✅ **This guide** (URGENT-FIX-406-ERROR.md)

---

## Quick Reference: What Changed

Your original table only had 11 columns:
- id, hero_type, hero_content, hero_title, hero_subtitle, header_style, footer_style, site_name, site_logo, created_at, updated_at

The new complete table has **38 columns** including:
- All hero settings (border radius, overlay, height, etc.)
- Product grid settings (columns, card style, card height, etc.)
- Footer customization (text size, logo size, font, line height, etc.)
- Payment settings (PayPal, KPay)
- And more...

This matches exactly what your admin panel expects!
