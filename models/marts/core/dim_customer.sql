WITH ranking as (
    SELECT
        customer_id
        , customer_name
        , phone
        , address_line_1
        , address_line_2
        , postal_code
        , city
        , ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY order_date DESC) as rn
    FROM {{ ref('stg_sales') }}
    QUALIFY rn = 1 
)

SELECT * EXCEPT (rn)
FROM ranking