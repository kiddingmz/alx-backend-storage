-- Ranks country of bands,
-- ordered by the total number of fans for that country
SELECT origin, SUM(fans) AS nb_fans
FROM metal_bands
GROUP BY origin
ORDER BY nb_fans DESC;