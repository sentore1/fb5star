# 👤 Admin User Information

## Admin Email
**Email:** `gwaysoftware@gmail.com`

This is the **only email** that has admin access to the dashboard.

---

## 🔐 How to Access Admin Dashboard

### Option 1: If Admin Account Already Exists

1. **Go to Login Page**: http://localhost:3000/login
2. **Enter credentials**:
   - Email: `sizafurniture@gmail.com`
   - Password: `[Your Password]`
3. **Click "SIGN IN"**
4. You'll be redirected to: http://localhost:3000/admin

---

### Option 2: If Admin Account Doesn't Exist Yet

You need to create the admin account in Supabase:

#### Method A: Using Supabase Dashboard (Easiest)

1. **Go to Supabase Dashboard** → https://supabase.com/dashboard
2. **Select your project**
3. **Click "Authentication"** in the left sidebar
4. **Click "Users"** tab
5. **Click "Add user"** button
6. **Fill in the form**:
   - Email: `gwaysoftware@gmail.com`
   - Password: Create a strong password (save it!)
   - Auto Confirm User: ✅ **Check this box** (important!)
7. **Click "Create user"**
8. **Done!** You can now log in

#### Method B: Using SQL (Alternative)

Run this SQL in **Supabase SQL Editor**:

```sql
-- Create admin user directly in auth.users
-- Replace 'YOUR_SECURE_PASSWORD' with a strong password

-- Note: You'll need the service_role key for this
-- Or use Method A (Supabase Dashboard) which is easier
```

Actually, **use Method A (Dashboard)** - it's much easier and safer!

#### Method C: Through the App (Self-Registration)

1. **Go to**: http://localhost:3000/login
2. **Click**: "Don't have an account? Create one"
3. **Enter**:
   - Email: `gwaysoftware@gmail.com`
   - Password: `[Create a strong password]`
4. **Click "CREATE ACCOUNT"**
5. **Check email** for verification link
6. **Click verification link**
7. **Go back to login** and sign in

---

## 🎯 What Admin Can Do

Once logged in as admin (`sizafurniture@gmail.com`), you can:

✅ **Products Tab**
- View all products
- Add new products
- Edit existing products
- Delete products
- Upload product images
- Manage product SEO

✅ **Orders Tab**
- View all customer orders
- Update order status
- See order details
- Track payments

✅ **Analytics Tab**
- View website traffic
- See conversion rates
- Track product views
- Monitor sales

✅ **Categories Tab**
- Add new categories
- Edit category names
- Remove categories

✅ **SEO Tab**
- Edit product SEO titles
- Update meta descriptions
- Add keywords for each product

✅ **Site Settings Tab**
- Change site name
- Update site logo
- Configure payment methods (PayPal, KPay, MoMo)
- Manage general settings

✅ **Hero Sections Tab**
- Create hero banners
- Add image sliders
- Configure gallery sections

✅ **Layout Tab**
- Customize product grid
- Adjust card styles
- Configure page layouts

---

## 🔒 Security Notes

### Admin Authentication

The admin check is hardcoded in the app:

**File**: `app/admin/page.tsx`
```typescript
if (!user || user.email !== 'gwaysoftware@gmail.com') {
  router.push('/login')
}
```

Only the email `gwaysoftware@gmail.com` can access the admin dashboard.

### Regular Users

Any other email will be:
- ✅ Able to create an account
- ✅ Able to log in
- ✅ Able to view their orders
- ❌ **Cannot** access admin dashboard
- Redirected to: `/account` (customer account page)

---

## 🔄 Change Admin Email (Optional)

If you want to use a different email as admin:

1. **Open**: `e:\crippers\app\admin\page.tsx`
2. **Find** (around line 152):
   ```typescript
   if (!user || user.email !== 'gwaysoftware@gmail.com') {
   ```
3. **Replace** `gwaysoftware@gmail.com` with your email
4. **Open**: `e:\crippers\app\login\page.tsx`
5. **Find** (around line 55):
   ```typescript
   if (email === 'gwaysoftware@gmail.com') {
   ```
6. **Replace** `gwaysoftware@gmail.com` with your email
7. **Save both files**
8. **Restart dev server**: `npm run dev`

---

## 🆘 Troubleshooting

### Can't Log In?

**Error: "Invalid login credentials"**
- ✅ Check your password is correct
- ✅ Verify email is exactly: `gwaysoftware@gmail.com`
- ✅ Make sure user exists in Supabase → Authentication → Users

**Redirected to login immediately**
- ✅ Make sure you're using the correct admin email
- ✅ Clear browser cache
- ✅ Try incognito/private window

**"Check your email to verify"**
- ✅ Check spam folder
- ✅ Or use Supabase Dashboard to manually confirm user

### Forgot Password?

1. **Go to**: http://localhost:3000/login
2. **Click** "Forgot password?" (if implemented)
3. **Or manually reset in Supabase Dashboard**:
   - Dashboard → Authentication → Users
   - Find your user
   - Click "..." → Reset password
   - Enter new password

---

## 📝 Quick Reference

| Item | Value |
|------|-------|
| Admin Email | `gwaysoftware@gmail.com` |
| Login URL | http://localhost:3000/login |
| Admin Dashboard | http://localhost:3000/admin |
| Account Page (Regular Users) | http://localhost:3000/account |

---

## ✅ Next Steps

1. **Create admin account** using one of the methods above
2. **Log in** at http://localhost:3000/login
3. **Access admin dashboard** at http://localhost:3000/admin
4. **Insert products** (run `insert-curtain-products.sql` in Supabase)
5. **Start managing your store!** 🎉

---

**Remember:** Keep your admin password secure! 🔐
