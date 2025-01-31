WITH ranking as (
    SELECT
        product_code
        , msrp
        , product_line
    FROM {{ ref('stg_sales') }}
    QUALIFY ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY order_date DESC) = 1 
)

SELECT * 
FROM ranking