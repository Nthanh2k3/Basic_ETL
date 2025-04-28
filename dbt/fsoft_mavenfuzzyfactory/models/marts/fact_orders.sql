{{ config(materialized='table') }}

WITH refund_summary AS (
    SELECT
        oi.order_id,
        COUNT(oir.order_item_refund_id) > 0 AS has_refund,
        SUM(oir.refund_amount_usd) AS refund_amount_usd
    FROM {{ ref('stg_order_item_refunds') }} oir
    JOIN {{ ref('stg_order_items') }} oi
        ON oir.order_item_id = oi.order_item_id
    GROUP BY oi.order_id
)

SELECT
    o.order_id,
    o.user_id,
    o.primary_product_id AS product_id,
    o.created_at::date AS date_id,
    o.website_session_id AS channel_id,
    o.price_usd,
    o.cogs_usd,
    o.price_usd - o.cogs_usd AS profit_usd,
    COALESCE(r.has_refund, FALSE) AS has_refund,
    COALESCE(r.refund_amount_usd, 0) AS refund_amount_usd
FROM {{ ref('stg_orders') }} o
LEFT JOIN refund_summary r
    ON o.order_id = r.order_id
WHERE o.order_id IS NOT NULL  
    AND o.created_at IS NOT NULL
    AND o.user_id IS NOT NULL
    AND o.primary_product_id IS NOT NULL
    AND o.website_session_id IS NOT NULL
    AND o.price_usd IS NOT NULL
    AND o.cogs_usd IS NOT NULL
    AND o.price_usd > 0
    AND o.cogs_usd > 0