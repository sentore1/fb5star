# 🎉 Rebranding Complete: Crapper Curtain

## What Was Changed

The entire application has been rebranded from "SIZA" to **"Crapper Curtain"**.

## Files Updated

### 1. **Database Setup**
- ✅ `complete-database-setup.sql` - All default values updated to "Crapper Curtain"

### 2. **Core Application Files**
- ✅ `app/layout.tsx` - Main metadata and SEO
- ✅ `app/page.tsx` - Homepage default settings
- ✅ `app/admin/page.tsx` - Admin panel defaults and placeholders
- ✅ `app/products/metadata.ts` - Products page SEO
- ✅ `app/robots.ts` - Sitemap URL
- ✅ `app/sitemap.ts` - Base URL

### 3. **Components**
- ✅ `components/Footer.tsx` - Default site name

### 4. **Library Files**
- ✅ `lib/seo.ts` - All SEO configurations, schema.org markup

### 5. **API Routes**
- ✅ `app/api/kpay/route.ts` - Payment reference IDs
- ✅ `app/api/kpay/webhook/route.ts` - Payment webhook parsing

## What This Affects

### Visible Changes:
- Site title in browser tab
- Meta descriptions for search engines
- Open Graph tags for social media sharing
- Footer branding
- Hero section default text
- Admin panel placeholders
- SEO-generated content

### Technical Changes:
- Payment transaction reference IDs now use "CRAPPERCURTAIN_" prefix
- Sitemap URL changed to Fb5Star.com
- Schema.org structured data updated
- Social media URLs updated

## Next Steps

### 1. **Run the Database Setup**
Run `complete-database-setup.sql` in your new Supabase instance to create all tables with the new branding.

### 2. **Update Environment Variables**
Make sure your `.env.local` has the new Supabase credentials:
```env
NEXT_PUBLIC_SUPABASE_URL=your_new_supabase_url
NEXT_PUBLIC_SUPABASE_ANON_KEY=your_new_supabase_anon_key
```

### 3. **Update Domain References** (Optional)
If you have a custom domain, you'll need to:
- Update `robots.ts` sitemap URL
- Update `sitemap.ts` baseUrl
- Update `lib/seo.ts` siteConfig.url

### 4. **Update Social Media Links**
In `lib/seo.ts`, update the social media URLs in `generateOrganizationJsonLd()`:
```typescript
sameAs: [
  'https://facebook.com/your_actual_page',
  'https://instagram.com/your_actual_page',
  'https://twitter.com/your_actual_page'
]
```

### 5. **Clear Browser Cache**
After deploying, clear your browser cache to see all the changes.

## Brand Assets to Update (Manual)

You may want to update these files manually:
- `/app/public/Logo dark.png` - Dark version of logo
- `/app/public/Logo White.png` - Light version of logo
- `/public/og-image.jpg` - Social media preview image
- `/public/hero-image.jpg` - Default hero image

## Testing Checklist

- [ ] Homepage displays "Crapper Curtain" branding
- [ ] Footer shows correct brand name
- [ ] Admin panel loads with new defaults
- [ ] Browser tab shows correct title
- [ ] Social media previews show correct branding
- [ ] Payment flow generates correct reference IDs
- [ ] SEO metadata is correct in page source

---

**All branding has been updated to "Crapper Curtain"!** 🎊
