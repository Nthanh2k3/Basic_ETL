{{ config(materialized='view') }}

SELECT
    order_item_id,
    order_id,
    product_id,
    price_usd,
    cogs_usd
FROM {{ source('public', 'order_items') }}
