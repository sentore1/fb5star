// fix-image-paths.js
// 1. Renames files with spaces in public/products (spaces -> hyphens)
// 2. Updates all DB image paths to match

const { createClient } = require('@supabase/supabase-js')
const fs = require('fs')
const path = require('path')

const SUPABASE_URL = 'https://vrkzipbpgvybrpqhcvte.supabase.co'
const SUPABASE_SERVICE_ROLE_KEY = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InZya3ppcGJwZ3Z5YnJwcWhjdnRlIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc4ODcwMDY4OCwiZXhwIjoyMTA0Mjc2Njg4fQ.P9PXRg09D4x0yepWpsB2bbykQK_TMAGbxAR7m_SrpmU'
const PRODUCTS_DIR = 'E:\\fb5star\\public\\products'

const supabase = createClient(SUPABASE_URL, SUPABASE_SERVICE_ROLE_KEY)

async function run() {
  // Step 1: rename files with spaces
  const files = fs.readdirSync(PRODUCTS_DIR)
  const renames = [] // [{oldName, newName}]

  for (const file of files) {
    if (file.includes(' ')) {
      const newName = file.replace(/ /g, '-')
      const oldPath = path.join(PRODUCTS_DIR, file)
      const newPath = path.join(PRODUCTS_DIR, newName)
      if (!fs.existsSync(newPath)) {
        fs.renameSync(oldPath, newPath)
        console.log(`  Renamed: "${file}" → "${newName}"`)
      }
      renames.push({ oldName: file, newName })
    }
  }

  console.log(`\nRenamed ${renames.length} files.\n`)

  // Step 2: update DB for renamed files
  for (const { oldName, newName } of renames) {
    const oldPath = `/products/${oldName}`
    const newPath = `/products/${newName}`

    const { data, error } = await supabase
      .from('products')
      .update({ image: newPath })
      .eq('image', oldPath)
      .select('name')

    if (error) {
      console.error(`  DB error for "${oldName}": ${error.message}`)
    } else if (data && data.length > 0) {
      data.forEach(p => console.log(`  ✓ Updated DB: ${p.name}`))
    }
  }

  // Step 3: also fix the .jpg.jpg double extension issue
  const doubleExt = files.filter(f => f.endsWith('.jpg.jpg'))
  for (const file of doubleExt) {
    const newName = file.replace('.jpg.jpg', '.jpg')
    const oldPath = path.join(PRODUCTS_DIR, file)
    const newPath = path.join(PRODUCTS_DIR, newName)
    if (!fs.existsSync(newPath)) {
      fs.renameSync(oldPath, newPath)
      console.log(`  Fixed ext: "${file}" → "${newName}"`)
    }
    const { data } = await supabase
      .from('products')
      .update({ image: `/products/${newName}` })
      .eq('image', `/products/${file}`)
      .select('name')
    if (data && data.length > 0) data.forEach(p => console.log(`  ✓ DB fixed: ${p.name}`))
  }

  console.log('\nAll done.')
}

run()
