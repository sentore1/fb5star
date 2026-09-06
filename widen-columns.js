// widen-columns.js
// Widens varchar columns in products table to TEXT (no length limit)
// Run with: node widen-columns.js

const { createClient } = require('@supabase/supabase-js')

const sb = createClient(
  'https://vrkzipbpgvybrpqhcvte.supabase.co',
  'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InZya3ppcGJwZ3Z5YnJwcWhjdnRlIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc4ODcwMDY4OCwiZXhwIjoyMTA0Mjc2Njg4fQ.P9PXRg09D4x0yepWpsB2bbykQK_TMAGbxAR7m_SrpmU'
)

// Columns to widen to TEXT
const alterStatements = [
  "ALTER TABLE products ALTER COLUMN description TYPE TEXT",
  "ALTER TABLE products ALTER COLUMN image TYPE TEXT",
  "ALTER TABLE products ALTER COLUMN images TYPE TEXT",
  "ALTER TABLE products ALTER COLUMN name TYPE TEXT",
  "ALTER TABLE products ALTER COLUMN slug TYPE TEXT",
  "ALTER TABLE products ALTER COLUMN category TYPE TEXT",
  "ALTER TABLE products ALTER COLUMN sizes TYPE TEXT",
  "ALTER TABLE products ALTER COLUMN colors TYPE TEXT",
  "ALTER TABLE products ALTER COLUMN seo_title TYPE TEXT",
  "ALTER TABLE products ALTER COLUMN seo_description TYPE TEXT",
  "ALTER TABLE products ALTER COLUMN seo_keywords TYPE TEXT",
]

async function run() {
  for (const sql of alterStatements) {
    const col = sql.match(/COLUMN (\w+)/)?.[1]
    const { error } = await sb.rpc('exec_sql', { sql })
    if (error) {
      // exec_sql might not exist — try via pg_catalog approach
      console.log(`  ⚠ RPC failed for ${col}: ${error.message}`)
    } else {
      console.log(`  ✓ Widened: ${col}`)
    }
  }
}

run().catch(console.error)
