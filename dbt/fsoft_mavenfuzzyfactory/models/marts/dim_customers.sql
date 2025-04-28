{{ config(materialized='table') }}

SELECT
    user_id,
    MIN(created_at) AS created_at
FROM {{ ref('stg_website_sessions') }}
WHERE user_id IS NOT NULL
GROUP BY user_id
