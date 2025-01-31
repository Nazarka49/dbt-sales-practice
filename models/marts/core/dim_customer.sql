WITH ranking as (
    SELECT
        customer_id
        , customer_name
        , phone
        , address_line_1
        , address_line_2
        , postal_code
        , city_id
        , order_date as last_order_date
    FROM {{ ref('stg_sales') }}
    QUALIFY ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY order_date DESC) = 1 
)

SELECT * 
FROM ranking