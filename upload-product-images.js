/**
 * Upload Product Images to Supabase Storage
 * 
 * This script uploads all curtain product images from the local /public/products folder
 * to Supabase Storage bucket.
 * 
 * Prerequisites:
 * 1. Make sure you have run the SQL script to create the storage bucket
 * 2. Update your .env.local with correct Supabase credentials
 * 3. Install required packages: npm install @supabase/supabase-js
 * 
 * Run: node upload-product-images.js
 */

require('dotenv').config({ path: '.env.local' });
const { createClient } = require('@supabase/supabase-js');
const fs = require('fs');
const path = require('path');

// Initialize Supabase client
const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL;
const supabaseServiceKey = process.env.SUPABASE_SERVICE_ROLE_KEY || process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY;

if (!supabaseUrl || !supabaseServiceKey) {
  console.error('❌ Missing Supabase credentials in .env.local');
  console.error('Required: NEXT_PUBLIC_SUPABASE_URL and SUPABASE_SERVICE_ROLE_KEY');
  process.exit(1);
}

const supabase = createClient(supabaseUrl, supabaseServiceKey);

// Configuration
const BUCKET_NAME = 'products';
const LOCAL_IMAGES_DIR = path.join(__dirname, 'public', 'products');

/**
 * Create storage bucket if it doesn't exist
 */
async function createBucket() {
  try {
    const { data: buckets, error: listError } = await supabase
      .storage
      .listBuckets();

    if (listError) {
      console.error('❌ Error listing buckets:', listError.message);
      return false;
    }

    const bucketExists = buckets.some(bucket => bucket.name === BUCKET_NAME);

    if (!bucketExists) {
      console.log(`📦 Creating bucket: ${BUCKET_NAME}...`);
      const { data, error } = await supabase
        .storage
        .createBucket(BUCKET_NAME, {
          public: true,
          fileSizeLimit: 5242880, // 5MB
          allowedMimeTypes: ['image/png', 'image/jpeg', 'image/jpg', 'image/webp']
        });

      if (error) {
        console.error('❌ Error creating bucket:', error.message);
        return false;
      }
      console.log('✅ Bucket created successfully');
    } else {
      console.log('✅ Bucket already exists');
    }
    return true;
  } catch (error) {
    console.error('❌ Error in createBucket:', error.message);
    return false;
  }
}

/**
 * Upload a single image file to Supabase Storage
 */
async function uploadImage(filename) {
  try {
    const filePath = path.join(LOCAL_IMAGES_DIR, filename);
    
    // Check if file exists
    if (!fs.existsSync(filePath)) {
      console.error(`❌ File not found: ${filename}`);
      return null;
    }

    // Read file
    const fileBuffer = fs.readFileSync(filePath);
    
    // Determine content type
    const ext = path.extname(filename).toLowerCase();
    let contentType = 'image/jpeg';
    if (ext === '.png') contentType = 'image/png';
    if (ext === '.webp') contentType = 'image/webp';
    if (ext === '.jpg' || ext === '.jpeg') contentType = 'image/jpeg';

    // Upload to Supabase Storage
    const { data, error } = await supabase
      .storage
      .from(BUCKET_NAME)
      .upload(filename, fileBuffer, {
        contentType,
        upsert: true, // Overwrite if exists
        cacheControl: '3600'
      });

    if (error) {
      console.error(`❌ Error uploading ${filename}:`, error.message);
      return null;
    }

    // Get public URL
    const { data: urlData } = supabase
      .storage
      .from(BUCKET_NAME)
      .getPublicUrl(filename);

    console.log(`✅ Uploaded: ${filename}`);
    return urlData.publicUrl;
  } catch (error) {
    console.error(`❌ Error uploading ${filename}:`, error.message);
    return null;
  }
}

/**
 * Upload all images from the products folder
 */
async function uploadAllImages() {
  try {
    // Check if directory exists
    if (!fs.existsSync(LOCAL_IMAGES_DIR)) {
      console.error(`❌ Directory not found: ${LOCAL_IMAGES_DIR}`);
      return;
    }

    // Get all image files
    const files = fs.readdirSync(LOCAL_IMAGES_DIR);
    const imageFiles = files.filter(file => {
      const ext = path.extname(file).toLowerCase();
      return ['.jpg', '.jpeg', '.png', '.webp'].includes(ext);
    });

    if (imageFiles.length === 0) {
      console.error('❌ No image files found in the products directory');
      return;
    }

    console.log(`\n📁 Found ${imageFiles.length} image files to upload\n`);

    const results = {
      success: [],
      failed: []
    };

    // Upload each image
    for (const filename of imageFiles) {
      const url = await uploadImage(filename);
      if (url) {
        results.success.push({ filename, url });
      } else {
        results.failed.push(filename);
      }
      
      // Small delay to avoid rate limiting
      await new Promise(resolve => setTimeout(resolve, 100));
    }

    // Print summary
    console.log('\n' + '='.repeat(60));
    console.log('📊 UPLOAD SUMMARY');
    console.log('='.repeat(60));
    console.log(`✅ Successfully uploaded: ${results.success.length}`);
    console.log(`❌ Failed: ${results.failed.length}`);
    
    if (results.failed.length > 0) {
      console.log('\n❌ Failed files:');
      results.failed.forEach(file => console.log(`   - ${file}`));
    }

    if (results.success.length > 0) {
      console.log('\n✅ Uploaded files:');
      results.success.slice(0, 5).forEach(({ filename, url }) => {
        console.log(`   - ${filename}`);
        console.log(`     ${url}`);
      });
      
      if (results.success.length > 5) {
        console.log(`   ... and ${results.success.length - 5} more`);
      }
    }

    console.log('\n' + '='.repeat(60));
    console.log('✅ UPLOAD COMPLETE!');
    console.log('='.repeat(60));
    console.log('\nNext steps:');
    console.log('1. Run the SQL script: insert-curtain-products.sql');
    console.log('2. Check your Supabase Storage dashboard');
    console.log('3. Verify images are accessible on your website\n');

  } catch (error) {
    console.error('❌ Error in uploadAllImages:', error.message);
  }
}

/**
 * Main execution
 */
async function main() {
  console.log('🚀 Starting image upload to Supabase Storage...\n');
  
  // Step 1: Create bucket
  const bucketCreated = await createBucket();
  if (!bucketCreated) {
    console.error('❌ Failed to create/verify bucket. Exiting...');
    process.exit(1);
  }

  // Step 2: Upload all images
  await uploadAllImages();
}

// Run the script
main().catch(error => {
  console.error('❌ Fatal error:', error);
  process.exit(1);
});
