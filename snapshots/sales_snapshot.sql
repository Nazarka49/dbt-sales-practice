{% snapshot sales_snapshot %}

{{
    config(
      target_schema='snapshots',
      strategy='check',
      unique_key= "CONCAT(ORDERNUMBER, ORDERLINENUMBER)",
      check_cols=['STATUS'],
    )
}}

SELECT * FROM {{ source('sales', 'raw_sales_data') }}

{% endsnapshot %}