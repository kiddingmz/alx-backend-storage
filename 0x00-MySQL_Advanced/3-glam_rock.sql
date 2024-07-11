-- List all bands with Glam rock as their main style, ranked by their longevity
-- Column names are `band_name` and `lifespan` (in years until 2022)
-- Attributes `formed` and `split` are used for computing the lifespan
SELECT band_name, (COALESCE(split, 2022) - formed) AS lifespan
FROM metal_bands
WHERE style LIKE '%Glam rock%'
ORDER BY lifespan DESC;