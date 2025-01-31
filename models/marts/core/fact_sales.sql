WITH source as (
    SELECT *
    FROM {{ ref('stg_sales') }}
)

, agg as (
    SELECT
        order_id
        , order_date
        , status
        , customer_id
        , city_id
        , contact_id
        , SUM(sales) as order_sales 
        , SUM(quantity) as order_quantity 
        , MAX(order_line_num) as distinct_products
    FROM source
    GROUP BY 1,2,3,4,5,6
)

, add_order_num as (
    SELECT 
        *
        , ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY order_date ASC) as order_num
    FROM agg
)

SELECT *
FROM add_order_num