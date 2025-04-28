{{ config(materialized='table') }}

SELECT
    website_session_id AS channel_id,
    utm_source,
    utm_campaign,
    utm_content
FROM {{ ref('stg_website_sessions') }}
WHERE utm_source IS NOT NULL
AND website_session_id IS NOT NULL
GROUP BY website_session_id, utm_source, utm_campaign, utm_content
HAVING COUNT(website_session_id) > 0
ORDER BY website_session_id