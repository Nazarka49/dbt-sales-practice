WITH source as (
    
    SELECT * FROM {{ source('sales', 'raw_sales_data') }}
    
),

renamed as (
    
    SELECT
        ORDERNUMBER as order_id
        , CONCAT(ORDERNUMBER, order_line_num) as compossed_pk
        , QUANTITYORDERED as quantity
        , PRICEEACH as price
        , ORDERLINENUMBER as order_line_num
        , SALES as sales
        , ORDERDATE as order_date
        , STATUS as status
        , QTR_ID as quarter
        , MONTH_ID as month
        , YEAR_ID as year 
        , PRODUCTLINE as product_line
        , MSRP as msrp
        , PRODUCTCODE as product_code
        , SHA256(CONCAT(CUSTOMERNAME, PHONE)) AS customer_id
        , CUSTOMERNAME as customer_name
        , PHONE as phone
        , ADDRESSLINE1 as address_line_1
        , ADDRESSLINE2 as address_line_2
        , CITY as city 
        , STATE as state
        , POSTALCODE as postal_code
        , COUNTRY as country
        , TERRITORY as territory
        -- id is based only on first and last name because those are only column available in the raw data related to sales reps
        , SHA256(CONCAT(CONTACTLASTNAME, CONTACTFIRSTNAME)) AS contact_id
        , CONTACTLASTNAME as contact_last_name
        , CONTACTFIRSTNAME as contact_first_name
        , DEALSIZE as deal_size
    FROM source

)

SELECT * FROM renamed