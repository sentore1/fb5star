import { NextRequest, NextResponse } from 'next/server'
import { supabase } from '../../../lib/supabase'
import { supabaseAdmin } from '../../../lib/supabaseAdmin'

// Truncate fields to match DB column limits
function sanitize(body: Record<string, unknown>) {
  const s = (v: unknown, max: number) =>
    typeof v === 'string' ? v.slice(0, max) : v

  return {
    ...body,
    // Known varchar limits
    name:            s(body.name, 255),
    description:     s(body.description, 500),
    category:        s(body.category, 255),
    image:           s(body.image, 500),
    images:          s(body.images, 2000),   // JSON string of image array
    slug:            s(body.slug, 255),
    currency:        s(body.currency, 10),
    sizes:           s(body.sizes, 255),
    colors:          s(body.colors, 255),
    seo_title:       s(body.seo_title, 60),
    seo_description: s(body.seo_description, 160),
    seo_keywords:    s(body.seo_keywords, 255),
  }
}

export async function GET(request: NextRequest) {
  try {
    const { searchParams } = new URL(request.url)
    const id = searchParams.get('id')

    // Single product lookup by id or slug
    if (id) {
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
    const raw = await request.json()

    // Log each field length to identify which one exceeds the DB limit
    console.log('POST /api/products field lengths:',
      Object.entries(raw).map(([k, v]) =>
        `${k}=${typeof v === 'string' ? v.length : typeof v}`
      ).join(', ')
    )

    const body = sanitize(raw)

    const { data: product, error } = await supabaseAdmin
      .from('products')
      .insert([body])
      .select()
      .single()

    if (error) {
      console.error('Insert error:', error)
      return NextResponse.json({ error: error.message }, { status: 500 })
    }

    return NextResponse.json(product, { status: 201 })
  } catch (error) {
    console.error('API error:', error)
    return NextResponse.json({ error: 'Failed to create product' }, { status: 500 })
  }
}

export async function PUT(request: NextRequest) {
  try {
    const raw = await request.json()
    const { id, ...rest } = raw

    if (!id) return NextResponse.json({ error: 'Missing product id' }, { status: 400 })

    const updates = sanitize(rest)

    const { data: product, error } = await supabaseAdmin
      .from('products')
      .update(updates)
      .eq('id', id)
      .select()
      .single()

    if (error) {
      console.error('Update error:', error)
      return NextResponse.json({ error: error.message }, { status: 500 })
    }

    return NextResponse.json(product)
  } catch (error) {
    console.error('API error:', error)
    return NextResponse.json({ error: 'Failed to update product' }, { status: 500 })
  }
}

export async function DELETE(request: NextRequest) {
  try {
    const { searchParams } = new URL(request.url)
    const id = searchParams.get('id')

    if (!id) return NextResponse.json({ error: 'Missing product id' }, { status: 400 })

    const { error } = await supabaseAdmin
      .from('products')
      .delete()
      .eq('id', id)

    if (error) {
      console.error('Delete error:', error)
      return NextResponse.json({ error: error.message }, { status: 500 })
    }

    return NextResponse.json({ success: true })
  } catch (error) {
    console.error('API error:', error)
    return NextResponse.json({ error: 'Failed to delete product' }, { status: 500 })
  }
}
