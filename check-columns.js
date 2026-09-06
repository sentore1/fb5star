const { createClient } = require('@supabase/supabase-js')
const sb = createClient(
  'https://vrkzipbpgvybrpqhcvte.supabase.co',
  'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InZya3ppcGJwZ3Z5YnJwcWhjdnRlIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc4ODcwMDY4OCwiZXhwIjoyMTA0Mjc2Njg4fQ.P9PXRg09D4x0yepWpsB2bbykQK_TMAGbxAR7m_SrpmU'
)

// Get one row to see all column names, then test inserting a known-short record
async function run() {
  // Get column info via information_schema
  const { data, error } = await sb.rpc('exec_sql', {
    sql: "SELECT column_name, data_type, character_maximum_length FROM information_schema.columns WHERE table_name = 'products' ORDER BY ordinal_position"
  })

  if (error) {
    console.log('RPC not available, trying direct insert test...')

    // Try inserting minimal product to isolate which field fails
    const test = {
      name: 'Test Product',
      price: 1000,
      description: 'Short desc',
      category: 'Test',
      image: '/test.jpg',
      stock: 1,
      currency: 'RWF',
      slug: 'test-product-' + Date.now(),
    }

    const { data: d, error: e } = await sb.from('products').insert([test]).select().single()
    if (e) {
      console.log('Minimal insert failed:', e.message, e.code)
    } else {
      console.log('Minimal insert succeeded! ID:', d.id)
      // Clean up
      await sb.from('products').delete().eq('id', d.id)
      console.log('Cleaned up test record')
    }
  } else {
    data.forEach(c => console.log(`${c.column_name} | ${c.data_type} | max: ${c.character_maximum_length}`))
  }
}

run()
