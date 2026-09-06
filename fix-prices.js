// fix-prices.js
// Divides all product prices by 1000 to remove the extra zeros
// Run with: node fix-prices.js

const { createClient } = require('@supabase/supabase-js')

const SUPABASE_URL = 'https://vrkzipbpgvybrpqhcvte.supabase.co'
const SUPABASE_SERVICE_ROLE_KEY = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InZya3ppcGJwZ3Z5YnJwcWhjdnRlIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc4ODcwMDY4OCwiZXhwIjoyMTA0Mjc2Njg4fQ.P9PXRg09D4x0yepWpsB2bbykQK_TMAGbxAR7m_SrpmU'

const supabase = createClient(SUPABASE_URL, SUPABASE_SERVICE_ROLE_KEY)

// Correct prices (name -> correct price)
const correctPrices = {
  'Gaming Laptop': 1299,
  'Dell Alienware M18 R2': 3499,
  'Gaming Desktop PC': 1599,
  'ASUS ZenBook 14': 899,
  'ASUS ROG Strix G16 G614FR': 2199,
  'ASUS TUF Gaming F16 FX608JHR': 1399,
  'ASUS VivoBook S14 OLED': 1099,
  'Lenovo V15 G4 IRU': 749,
  'Lenovo IdeaPad Slim 3 15IRH10': 699,
  'Lenovo ThinkPad P14s Gen 5': 1899,
  'Gaming Desktop Pro': 1899,
  'Gaming Desktop Tower': 1499,
  'Gaming Desktop Tower 2': 1699,
  'Gaming Desktop (Compact)': 1399,
  'Gaming Machine RGB': 1799,
  'Gaming Computer Setup': 2499,
  'Gaming Setup Complete': 2999,
  'Dell 24" Video Conferencing Monitor C2423H': 499,
  'ASUS TUF Gaming VG27VQ3B 27"': 449,
  'Dell PowerEdge R250 Rack Server': 4999,
  'Gaming Keyboard RGB': 89,
  'Gaming Keyboard Pro': 129,
  'Gaming Mouse': 59,
  'USB Cable (Type-A to Type-C)': 9,
  'USB Cable Braided': 12,
  'Smart Watch': 199,
  'Digital Watch': 149,
  'Sony Wireless Speaker': 179,
  'Gaming Tool Set': 45,
  'Gaming Tool Kit': 55,
  'PC Game Bundle': 29,
}

async function fixPrices() {
  console.log('Fixing prices for all products...\n')

  let successCount = 0
  let errorCount = 0

  for (const [name, price] of Object.entries(correctPrices)) {
    const { data, error } = await supabase
      .from('products')
      .update({ price })
      .eq('name', name)
      .select('name, price')
      .single()

    if (error) {
      console.error(`  ✗ ${name}: ${error.message}`)
      errorCount++
    } else {
      console.log(`  ✓ ${data.name} → $${data.price}`)
      successCount++
    }
  }

  console.log(`\nDone. ${successCount} updated, ${errorCount} errors.`)
}

fixPrices()
