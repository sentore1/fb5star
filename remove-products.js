// remove-products.js
// Run with: node remove-products.js

const { createClient } = require('@supabase/supabase-js')

const SUPABASE_URL = 'https://vrkzipbpgvybrpqhcvte.supabase.co'
const SUPABASE_SERVICE_ROLE_KEY = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InZya3ppcGJwZ3Z5YnJwcWhjdnRlIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc4ODcwMDY4OCwiZXhwIjoyMTA0Mjc2Njg4fQ.P9PXRg09D4x0yepWpsB2bbykQK_TMAGbxAR7m_SrpmU'

const supabase = createClient(SUPABASE_URL, SUPABASE_SERVICE_ROLE_KEY)

const namesToRemove = [
  'Classic Damask Elegant Curtains',
  'Children\'s Room Playful Curtains',
  'Ombre Gradient Curtains',
  'Textured Waffle Weave Curtains',
  'Elegant Black & White Minimalist Curtain',
  'Luxury Beige Textured Drapes',
  'Modern Grey Blackout Curtains',
  'Classic White Sheer Curtains',
  'Contemporary Patterned Curtains',
  'Rustic Linen Blend Curtains',
  'Velvet Luxury Curtains - Navy Blue',
  'Scandinavian Minimalist Curtains',
  'Smart Home Motorized Curtains',
  'Eco-Friendly Bamboo Curtains',
  'Botanical Print Curtains',
  'Industrial Loft Style Curtains',
  'Thermal Insulated Energy Saving Curtains',
  'Coastal Blue & White Stripe Curtains',
  'Bohemian Tassel Curtains',
  'Premium Silk Blend Drapes',
  'Farmhouse Gingham Check Curtains',
  'Art Deco Geometric Curtains',
  'Japanese Inspired Minimalist Curtains',
  'Moroccan Tile Pattern Curtains',
  'Mid-Century Modern Curtains',
  'Luxury Hotel Collection Curtains',
  'Essential Piece 3',
  'Essential Piece 1',
  'Essential Piece 2',
]

async function removeProducts() {
  console.log(`Removing ${namesToRemove.length} products from Supabase...`)

  const { data, error } = await supabase
    .from('products')
    .delete()
    .in('name', namesToRemove)
    .select()

  if (error) {
    console.error('Error deleting products:', error.message)
    console.error('Details:', error.details)
    process.exit(1)
  }

  if (data.length === 0) {
    console.log('No matching products found to delete.')
  } else {
    console.log(`Successfully deleted ${data.length} products:`)
    data.forEach(p => console.log(`  ✓ ${p.name}`))
  }

  // Report any names that weren't found
  const deletedNames = data.map(p => p.name)
  const notFound = namesToRemove.filter(n => !deletedNames.includes(n))
  if (notFound.length > 0) {
    console.log(`\nNot found in database (${notFound.length}):`)
    notFound.forEach(n => console.log(`  - ${n}`))
  }
}

removeProducts()
