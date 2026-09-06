// add-more-products.js
// Copies images from E:\darfur\public\products\more into E:\fb5star\public\products
// then inserts the products into Supabase.
// Run with: node add-more-products.js

const { createClient } = require('@supabase/supabase-js')
const fs = require('fs')
const path = require('path')

const SUPABASE_URL = 'https://vrkzipbpgvybrpqhcvte.supabase.co'
const SUPABASE_SERVICE_ROLE_KEY = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InZya3ppcGJwZ3Z5YnJwcWhjdnRlIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc4ODcwMDY4OCwiZXhwIjoyMTA0Mjc2Njg4fQ.P9PXRg09D4x0yepWpsB2bbykQK_TMAGbxAR7m_SrpmU'

const supabase = createClient(SUPABASE_URL, SUPABASE_SERVICE_ROLE_KEY)

const SOURCE_DIR = 'E:\\darfur\\public\\products\\more'
const DEST_DIR   = 'E:\\fb5star\\public\\products'

// Map each filename to product data
const products = [
  {
    file: 'brender.png',
    name: 'Electric Hand Blender',
    price: 49,
    category: 'Kitchen Appliances',
    description: 'Compact electric hand blender for smoothies, soups, and sauces. Easy to clean and store.',
    stock: 30,
  },
  {
    file: 'industrial brenda.png',
    name: 'Industrial Blender',
    price: 189,
    category: 'Kitchen Appliances',
    description: 'Heavy-duty industrial blender for high-volume blending. Ideal for restaurants and cafes.',
    stock: 10,
  },
  {
    file: 'coffeemaker machine big.png',
    name: 'Coffee Maker Machine (Large)',
    price: 149,
    category: 'Kitchen Appliances',
    description: 'Large-capacity coffee maker with programmable settings and keep-warm function.',
    stock: 15,
  },
  {
    file: 'coffeemaker machine smaller.png',
    name: 'Coffee Maker Machine (Medium)',
    price: 99,
    category: 'Kitchen Appliances',
    description: 'Mid-size coffee maker perfect for offices and households. Brews up to 8 cups.',
    stock: 20,
  },
  {
    file: 'coffeemaker machine smallerst.png',
    name: 'Coffee Maker Machine (Compact)',
    price: 59,
    category: 'Kitchen Appliances',
    description: 'Compact single-serve coffee maker, ideal for small spaces and personal use.',
    stock: 25,
  },
  {
    file: 'frirdge.png',
    name: 'Full-Size Refrigerator',
    price: 699,
    category: 'Home Appliances',
    description: 'Full-size double-door refrigerator with large capacity, energy efficient with frost-free technology.',
    stock: 8,
  },
  {
    file: 'Smaller Fridge.png',
    name: 'Mini Refrigerator',
    price: 249,
    category: 'Home Appliances',
    description: 'Compact mini fridge ideal for dorm rooms, offices, or bedrooms. Quiet operation.',
    stock: 20,
  },
  {
    file: 'TV.png',
    name: 'Smart LED TV 55"',
    price: 599,
    category: 'Electronics',
    description: '55-inch 4K Smart LED TV with built-in Wi-Fi, HDR support, and multiple HDMI ports.',
    stock: 12,
  },
]

async function run() {
  // --- Step 1: Copy images ---
  console.log('Copying images...')
  for (const product of products) {
    const src  = path.join(SOURCE_DIR, product.file)
    const dest = path.join(DEST_DIR, product.file)
    if (!fs.existsSync(src)) {
      console.warn(`  ⚠ Source not found, skipping copy: ${product.file}`)
      continue
    }
    fs.copyFileSync(src, dest)
    console.log(`  ✓ Copied: ${product.file}`)
  }

  // --- Step 2: Insert into Supabase ---
  console.log('\nInserting products into Supabase...')

  const rows = products.map(p => ({
    name:        p.name,
    price:       p.price,
    image:       `/products/${p.file}`,
    description: p.description,
    category:    p.category,
    stock:       p.stock,
  }))

  const { data, error } = await supabase
    .from('products')
    .insert(rows)
    .select()

  if (error) {
    console.error('Error inserting products:', error.message)
    console.error('Details:', error.details)
    process.exit(1)
  }

  console.log(`\nSuccessfully inserted ${data.length} products:`)
  data.forEach(p => console.log(`  ✓ ${p.name} — $${p.price}`))
}

run()
