{{ config(materialized='table') }}

WITH dates AS (

    SELECT
        created_at::date AS date_id
    FROM {{ ref('stg_orders') }}

    UNION

    SELECT
        created_at::date
    FROM {{ ref('stg_website_sessions') }}

)

SELECT
    date_id,
    EXTRACT(YEAR FROM date_id) AS year,
    EXTRACT(QUARTER FROM date_id) AS quarter,
    EXTRACT(MONTH FROM date_id) AS month,
    EXTRACT(DAY FROM date_id) AS day,
    EXTRACT(DOW FROM date_id) AS day_of_week
FROM dates
GROUP BY date_id
ORDER BY date_id

