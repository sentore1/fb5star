import { NextRequest, NextResponse } from 'next/server'
import { supabase } from '../../../lib/supabase'

export async function GET(request: NextRequest) {
  try {
    const { searchParams } = new URL(request.url)
    const id = searchParams.get('id')

    // Single product lookup by id or slug
    if (id) {
      // Try by UUID id first
      let { data: product, error } = await supabase
        .from('products')
        .select('*')
        .eq('id', id)
        .maybeSingle()

      // If not found by id, try by slug
      if (!product && !error) {
        const result = await supabase
          .from('products')
          .select('*')
          .eq('slug', id)
          .maybeSingle()
        product = result.data
        error = result.error
      }

      if (error) {
        console.error('Supabase error:', error)
        return NextResponse.json(null)
      }

      return NextResponse.json(product || null)
    }

    // All products
    const { data: products, error } = await supabase
      .from('products')
      .select('*')
      .order('created_at', { ascending: false })

    if (error) {
      console.error('Supabase error:', error)
      return NextResponse.json([])
    }

    return NextResponse.json(products || [])
  } catch (error) {
    console.error('API error:', error)
    return NextResponse.json([])
  }
}

export async function POST(request: NextRequest) {
  try {
    const body = await request.json()
    
    const { data: product, error } = await supabase
      .from('products')
      .insert([body])
      .select()
      .single()

    if (error) throw error

    return NextResponse.json(product, { status: 201 })
  } catch (error) {
    return NextResponse.json({ error: 'Failed to create product' }, { status: 500 })
  }
}