{{ config(materialized='view') }}

SELECT
    order_item_refund_id,
    order_item_id,
    refund_amount_usd
FROM {{ source('public', 'order_item_refunds') }}
