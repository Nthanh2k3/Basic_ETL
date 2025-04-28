{{ config(materialized='view') }}

SELECT
    product_id,
    product_name,
    created_at
FROM {{ source('public', 'products') }}
