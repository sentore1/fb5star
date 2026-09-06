/**
 * Diagnostic Script - Check Why Products Aren't Showing
 * 
 * Run: node diagnose-products.js
 */

require('dotenv').config({ path: '.env.local' });
const { createClient } = require('@supabase/supabase-js');

const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL;
const supabaseKey = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY;

console.log('\n🔍 DIAGNOSTIC TOOL - Products Not Showing\n');
console.log('='.repeat(60));

// Check 1: Environment Variables
console.log('\n✓ CHECK 1: Environment Variables');
console.log('-'.repeat(60));
if (!supabaseUrl) {
  console.log('❌ NEXT_PUBLIC_SUPABASE_URL is missing in .env.local');
  process.exit(1);
} else {
  console.log(`✅ NEXT_PUBLIC_SUPABASE_URL: ${supabaseUrl.substring(0, 30)}...`);
}

if (!supabaseKey) {
  console.log('❌ NEXT_PUBLIC_SUPABASE_ANON_KEY is missing in .env.local');
  process.exit(1);
} else {
  console.log(`✅ NEXT_PUBLIC_SUPABASE_ANON_KEY: ${supabaseKey.substring(0, 20)}...`);
}

// Initialize Supabase
const supabase = createClient(supabaseUrl, supabaseKey);

async function runDiagnostics() {
  // Check 2: Connection Test
  console.log('\n✓ CHECK 2: Supabase Connection');
  console.log('-'.repeat(60));
  try {
    const { data, error } = await supabase.from('products').select('count');
    if (error) {
      console.log('❌ Connection failed:', error.message);
      return;
    }
    console.log('✅ Connected to Supabase successfully');
  } catch (err) {
    console.log('❌ Connection error:', err.message);
    return;
  }

  // Check 3: Products Table
  console.log('\n✓ CHECK 3: Products Table');
  console.log('-'.repeat(60));
  try {
    const { data: products, error } = await supabase
      .from('products')
      .select('*')
      .limit(1);

    if (error) {
      console.log('❌ Error accessing products table:', error.message);
      console.log('💡 Suggestion: Run complete-database-setup.sql in Supabase');
      return;
    }
    console.log('✅ Products table exists and is accessible');
  } catch (err) {
    console.log('❌ Error:', err.message);
    return;
  }

  // Check 4: Total Products Count
  console.log('\n✓ CHECK 4: Total Products Count');
  console.log('-'.repeat(60));
  try {
    const { data: products, error } = await supabase
      .from('products')
      .select('*');

    if (error) {
      console.log('❌ Error counting products:', error.message);
      return;
    }

    console.log(`📊 Total products in database: ${products?.length || 0}`);

    if (!products || products.length === 0) {
      console.log('❌ No products found in database!');
      console.log('💡 Solution: Run insert-curtain-products.sql in Supabase SQL Editor');
      return;
    }
    console.log('✅ Products exist in database');
  } catch (err) {
    console.log('❌ Error:', err.message);
    return;
  }

  // Check 5: Curtain Products
  console.log('\n✓ CHECK 5: Curtain Products');
  console.log('-'.repeat(60));
  try {
    const { data: curtains, error } = await supabase
      .from('products')
      .select('*')
      .eq('category', 'curtains');

    if (error) {
      console.log('❌ Error fetching curtain products:', error.message);
      return;
    }

    console.log(`🎯 Curtain products found: ${curtains?.length || 0}`);

    if (!curtains || curtains.length === 0) {
      console.log('❌ No curtain products found!');
      console.log('💡 Solution: Run insert-curtain-products.sql');
      
      // Check what categories exist
      const { data: allProducts } = await supabase
        .from('products')
        .select('category');
      
      if (allProducts && allProducts.length > 0) {
        const categories = [...new Set(allProducts.map(p => p.category))];
        console.log(`📋 Existing categories: ${categories.join(', ')}`);
      }
      return;
    }

    console.log('✅ Curtain products exist!');
    console.log('\n📦 Sample curtain products:');
    curtains.slice(0, 5).forEach((product, index) => {
      console.log(`   ${index + 1}. ${product.name} - $${product.price}`);
    });
  } catch (err) {
    console.log('❌ Error:', err.message);
    return;
  }

  // Check 6: Image Paths
  console.log('\n✓ CHECK 6: Product Image Paths');
  console.log('-'.repeat(60));
  try {
    const { data: products, error } = await supabase
      .from('products')
      .select('name, image')
      .eq('category', 'curtains')
      .limit(3);

    if (products && products.length > 0) {
      products.forEach(product => {
        const imagePath = product.image || 'No image';
        let status = '❓';
        
        if (imagePath.startsWith('/products/')) {
          status = '✅ Local path (public/products)';
        } else if (imagePath.includes('supabase.co')) {
          status = '✅ Supabase Storage';
        } else if (imagePath.includes('unsplash.com')) {
          status = '✅ External URL';
        } else {
          status = '⚠️  Unknown path format';
        }
        
        console.log(`   ${product.name}`);
        console.log(`   ${status}`);
        console.log(`   Path: ${imagePath.substring(0, 60)}...`);
        console.log('');
      });
    }
  } catch (err) {
    console.log('⚠️  Could not check image paths:', err.message);
  }

  // Check 7: RLS Policies
  console.log('\n✓ CHECK 7: Row Level Security (RLS) Policies');
  console.log('-'.repeat(60));
  console.log('ℹ️  Testing if products are publicly accessible...');
  
  try {
    // Test with a fresh client (simulating anonymous access)
    const anonSupabase = createClient(supabaseUrl, supabaseKey);
    const { data, error } = await anonSupabase
      .from('products')
      .select('id')
      .limit(1);

    if (error) {
      console.log('❌ RLS might be blocking access:', error.message);
      console.log('💡 Solution: Run this SQL in Supabase:');
      console.log(`
      DROP POLICY IF EXISTS "Products are viewable by everyone" ON products;
      
      CREATE POLICY "Products are viewable by everyone" 
      ON products FOR SELECT 
      USING (true);
      `);
      return;
    }
    console.log('✅ Products are publicly accessible (RLS configured correctly)');
  } catch (err) {
    console.log('⚠️  Could not verify RLS:', err.message);
  }

  // Final Summary
  console.log('\n' + '='.repeat(60));
  console.log('📊 DIAGNOSTIC SUMMARY');
  console.log('='.repeat(60));
  console.log('✅ All checks passed!');
  console.log('');
  console.log('Your products are in the database and should be visible.');
  console.log('');
  console.log('If products still don\'t show on your website:');
  console.log('1. Restart your dev server: npm run dev');
  console.log('2. Clear browser cache (Ctrl+Shift+R)');
  console.log('3. Check browser console (F12) for errors');
  console.log('4. Visit: http://localhost:3000/api/products');
  console.log('');
  console.log('='.repeat(60));
}

// Run diagnostics
runDiagnostics().catch(err => {
  console.error('\n❌ FATAL ERROR:', err.message);
  process.exit(1);
});
