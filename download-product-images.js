// download-product-images.js
// Downloads all external product images into public/products/
// and updates the database image paths to local /products/<filename>
// Run with: node download-product-images.js

const { createClient } = require('@supabase/supabase-js')
const https = require('https')
const http = require('http')
const fs = require('fs')
const path = require('path')
const { URL } = require('url')

const SUPABASE_URL = 'https://vrkzipbpgvybrpqhcvte.supabase.co'
const SUPABASE_SERVICE_ROLE_KEY = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InZya3ppcGJwZ3Z5YnJwcWhjdnRlIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc4ODcwMDY4OCwiZXhwIjoyMTA0Mjc2Njg4fQ.P9PXRg09D4x0yepWpsB2bbykQK_TMAGbxAR7m_SrpmU'
const DEST_DIR = path.join('E:', 'fb5star', 'public', 'products')

const supabase = createClient(SUPABASE_URL, SUPABASE_SERVICE_ROLE_KEY)

// Download file ignoring SSL errors (old site has bad cert)
function download(url, destPath) {
  return new Promise((resolve, reject) => {
    const parsed = new URL(url)
    const lib = parsed.protocol === 'https:' ? https : http
    const agent = new https.Agent({ rejectUnauthorized: false })

    const file = fs.createWriteStream(destPath)
    const req = lib.get(url, { agent }, (res) => {
      if (res.statusCode === 301 || res.statusCode === 302) {
        file.close()
        fs.unlinkSync(destPath)
        return download(res.headers.location, destPath).then(resolve).catch(reject)
      }
      if (res.statusCode !== 200) {
        file.close()
        fs.unlinkSync(destPath)
        return reject(new Error(`HTTP ${res.statusCode}`))
      }
      res.pipe(file)
      file.on('finish', () => file.close(resolve))
    })
    req.on('error', (err) => {
      file.close()
      if (fs.existsSync(destPath)) fs.unlinkSync(destPath)
      reject(err)
    })
    req.setTimeout(15000, () => {
      req.destroy()
      reject(new Error('Timeout'))
    })
  })
}

// Sanitize URL filename to a safe local filename
function safeFilename(url) {
  try {
    const u = new URL(url)
    // get last path segment, decode it
    const base = decodeURIComponent(path.basename(u.pathname))
    // remove query strings, replace unsafe chars
    return base.replace(/[?#&]/g, '').replace(/\s+/g, '_') || 'image.jpg'
  } catch {
    return 'image.jpg'
  }
}

async function run() {
  // Fetch all products with external image URLs
  const { data: products, error } = await supabase
    .from('products')
    .select('id, name, image')
    .like('image', 'http%') // only external URLs

  if (error) {
    console.error('Failed to fetch products:', error.message)
    process.exit(1)
  }

  console.log(`Found ${products.length} products with external images.\n`)

  let downloaded = 0
  let skipped = 0
  let failed = 0

  for (const product of products) {
    const filename = safeFilename(product.image)
    const destPath = path.join(DEST_DIR, filename)
    const localPath = `/products/${filename}`

    // Skip if already downloaded
    if (fs.existsSync(destPath)) {
      // Still update DB if it still has old URL
      await supabase.from('products').update({ image: localPath }).eq('id', product.id)
      skipped++
      process.stdout.write(`  ↷ Already exists: ${filename}\n`)
      continue
    }

    // Download
    try {
      await download(product.image, destPath)

      // Update DB to local path
      const { error: updateErr } = await supabase
        .from('products')
        .update({ image: localPath })
        .eq('id', product.id)

      if (updateErr) {
        console.error(`  ✗ DB update failed for "${product.name}": ${updateErr.message}`)
      } else {
        console.log(`  ✓ ${filename}`)
        downloaded++
      }
    } catch (err) {
      console.error(`  ✗ Failed: ${filename} — ${err.message}`)
      failed++
    }
  }

  console.log(`\nDone. Downloaded: ${downloaded}, Skipped: ${skipped}, Failed: ${failed}`)
}

run()
