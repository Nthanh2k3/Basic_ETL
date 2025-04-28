{{ config(materialized='table') }}

SELECT
    product_id,
    product_name,
    created_at
FROM {{ ref('stg_products') }}
WHERE product_id IS NOT NULL
GROUP BY product_id, product_name, created_at
HAVING COUNT(product_id) > 0
ORDER BY product_id
