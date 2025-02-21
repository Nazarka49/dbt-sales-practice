WITH source as (
    
    SELECT * FROM {{ ref('sales_snapshot') }}
    
),

renamed as (
    
    SELECT
        ORDERNUMBER as order_id
        , CONCAT(ORDERNUMBER, ORDERLINENUMBER) as compossed_pk
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
        -- id is based only on a full name because this dataset does not include any other unique immutable fields related to customer
        , {{ dbt_utils.generate_surrogate_key(['CUSTOMERNAME']) }} as customer_id
        , CUSTOMERNAME as customer_name
        , PHONE as phone
        , ADDRESSLINE1 as address_line_1
        , ADDRESSLINE2 as address_line_2
        , {{ dbt_utils.generate_surrogate_key(['CITY', 'COUNTRY']) }} as city_id
        , CITY as city 
        , STATE as state
        , POSTALCODE as postal_code
        , COUNTRY as country
        , TERRITORY as territory
        -- id is based only on first and last name because those are only column available in the raw data related to sales reps
        , {{ dbt_utils.generate_surrogate_key(['CONTACTLASTNAME', 'CONTACTFIRSTNAME']) }} as contact_id
        , CONTACTLASTNAME as contact_last_name
        , CONTACTFIRSTNAME as contact_first_name
        , DEALSIZE as deal_size
    FROM source
    WHERE dbt_valid_to IS NULL

)

SELECT * FROM renamed