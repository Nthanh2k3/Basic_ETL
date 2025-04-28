{{ config(materialized='view') }}

SELECT
    website_pageview_id,
    website_session_id,
    created_at,
    pageview_url
FROM {{ source('public', 'website_pageviews') }}
