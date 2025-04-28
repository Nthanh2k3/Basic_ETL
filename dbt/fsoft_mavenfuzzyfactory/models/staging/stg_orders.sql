{{ config(materialized='view') }}

SELECT
    order_id,
    created_at,
    website_session_id,
    user_id,
    primary_product_id,
    price_usd,
    cogs_usd
FROM {{ source('public', 'orders') }}
