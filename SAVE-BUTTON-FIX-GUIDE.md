# Save Layout Settings Button - Fix & Test Guide

## What Was Fixed

The "Save Layout Settings" button in the Admin Dashboard was failing silently. I've added:

1. **Better error logging** - Errors now appear in browser console
2. **Improved error messages** - You'll see exactly what went wrong
3. **Fallback handling** - Clear message if database record is missing

## Testing Steps

### Step 1: Check Your Development Server

Your dev server should already be running. Check these URLs:
- http://localhost:3000/admin (or port 3001 if 3000 is busy)

If not running, start it:
```powershell
npm run dev
```

### Step 2: Check Database Settings Record

1. Open Supabase Dashboard: https://app.supabase.com
2. Go to SQL Editor
3. Run this script: `check-and-fix-site-settings.sql`
4. Verify the output shows `count = 1`

### Step 3: Test the Button

1. Open browser and navigate to: http://localhost:3000/admin
2. Log in with admin credentials
3. Click on the **"Layout"** tab
4. Make a small change (e.g., change "Homepage Product Limit")
5. Click **"Save Layout Settings"** button
6. Open Browser Console (Press F12, then click "Console" tab)
7. Look for any error messages

### Expected Results

✅ **Success**: You should see an alert saying "Settings saved successfully!"

❌ **If there's an error**, the console will show:
- `Save error: [specific database error]` - Database permission or column issue
- `Exception: [error details]` - JavaScript or connection error
- `No settings record found` - Need to run the SQL script above

## Common Issues & Solutions

### Issue 1: "No settings record found"
**Solution**: Run `check-and-fix-site-settings.sql` in Supabase SQL Editor

### Issue 2: Database permission error
**Solution**: Check RLS policies in Supabase
```sql
-- Run this in Supabase SQL Editor
SELECT * FROM pg_policies WHERE tablename = 'site_settings';
```

You should see policies allowing the admin to UPDATE.

### Issue 3: "site_logo" column error
**Solution**: The site_logo field is being used to store both logo URL and MoMo settings as JSON. If you get column type errors, check:

```sql
-- Check site_logo column type
SELECT column_name, data_type, character_maximum_length
FROM information_schema.columns
WHERE table_name = 'site_settings' AND column_name = 'site_logo';
```

It should be TEXT or VARCHAR with sufficient length.

### Issue 4: Button does nothing at all
**Solution**: 
1. Check browser console for JavaScript errors
2. Verify you're logged in as admin (gwaysoftware@gmail.com)
3. Check Network tab (F12 → Network) to see if API request is being made

## Debug Mode

To see detailed logs:
1. Open Browser Console (F12)
2. Click "Save Layout Settings"
3. Look for these console messages:
   - `Save error: [message]` - Database error
   - `Exception: [message]` - JavaScript error
   - The alert popup will also show the error

## File Changes Made

- **`app/admin/page.tsx`**: Updated `saveSiteSettings` function with better error handling

## Need More Help?

If the button still doesn't work after these steps:
1. Copy the exact error message from the console
2. Check which settings you were trying to save
3. Verify your Supabase connection is working (other admin features work)

## Alternative: Direct API Test

You can test the save function directly in browser console:

```javascript
// Open browser console (F12) on the admin page
// Then paste this to test the save function manually
console.log('Testing save function...');
document.querySelector('button[onclick*="saveSiteSettings"]')?.click();
```
