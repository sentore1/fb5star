-- Run this in Supabase Dashboard → SQL Editor
-- Widens all varchar columns in products table to TEXT (removes length limits)

ALTER TABLE products ALTER COLUMN description     TYPE TEXT;
ALTER TABLE products ALTER COLUMN image           TYPE TEXT;
ALTER TABLE products ALTER COLUMN images          TYPE TEXT;
ALTER TABLE products ALTER COLUMN name            TYPE TEXT;
ALTER TABLE products ALTER COLUMN slug            TYPE TEXT;
ALTER TABLE products ALTER COLUMN category        TYPE TEXT;
ALTER TABLE products ALTER COLUMN sizes           TYPE TEXT;
ALTER TABLE products ALTER COLUMN colors          TYPE TEXT;
ALTER TABLE products ALTER COLUMN seo_title       TYPE TEXT;
ALTER TABLE products ALTER COLUMN seo_description TYPE TEXT;
ALTER TABLE products ALTER COLUMN seo_keywords    TYPE TEXT;

-- Verify the change
SELECT column_name, data_type, character_maximum_length
FROM information_schema.columns
WHERE table_name = 'products'
ORDER BY ordinal_position;
