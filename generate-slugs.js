// generate-slugs.js
// Generates URL-friendly slugs for all products that have null slug
// Run with: node generate-slugs.js

const { createClient } = require('@supabase/supabase-js')

const SUPABASE_URL = 'https://vrkzipbpgvybrpqhcvte.supabase.co'
const SUPABASE_SERVICE_ROLE_KEY = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InZya3ppcGJwZ3Z5YnJwcWhjdnRlIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc4ODcwMDY4OCwiZXhwIjoyMTA0Mjc2Njg4fQ.P9PXRg09D4x0yepWpsB2bbykQK_TMAGbxAR7m_SrpmU'

const supabase = createClient(SUPABASE_URL, SUPABASE_SERVICE_ROLE_KEY)

function toSlug(name) {
  return name
    .toLowerCase()
    .replace(/[^a-z0-9\s-]/g, '')   // remove special chars
    .replace(/\s+/g, '-')            // spaces to hyphens
    .replace(/-+/g, '-')             // collapse multiple hyphens
    .replace(/^-|-$/g, '')           // trim leading/trailing hyphens
    .slice(0, 80)                    // max length
}

async function run() {
  // Fetch all products with null slug
  const { data: products, error } = await supabase
    .from('products')
    .select('id, name, slug')
    .is('slug', null)

  if (error) {
    console.error('Error fetching:', error.message)
    process.exit(1)
  }

  console.log(`Generating slugs for ${products.length} products...`)

  // Track used slugs to avoid duplicates
  const usedSlugs = new Set()
  let updated = 0

  for (const product of products) {
    let slug = toSlug(product.name)
    if (!slug) slug = product.id

    // Make unique if collision
    let uniqueSlug = slug
    let counter = 2
    while (usedSlugs.has(uniqueSlug)) {
      uniqueSlug = `${slug}-${counter}`
      counter++
    }
    usedSlugs.add(uniqueSlug)

    const { error: updateErr } = await supabase
      .from('products')
      .update({ slug: uniqueSlug })
      .eq('id', product.id)

    if (updateErr) {
      console.error(`  ✗ ${product.name}: ${updateErr.message}`)
    } else {
      console.log(`  ✓ ${product.name} → ${uniqueSlug}`)
      updated++
    }
  }

  console.log(`\nDone. ${updated} slugs generated.`)
}

run()
