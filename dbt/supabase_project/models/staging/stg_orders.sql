with source as (

    select
        invoiceno      as order_id,
        stockcode      as product_code,
        description    as product_description,
        quantity,
        unitprice,
        customerid     as customer_id,
        country,
        invoicedate
    from raw_orders

),

cleaned as (

    select
        order_id,
        product_code,
        product_description,
        quantity,
        unitprice::numeric as unit_price,
        customer_id,
        lower(country) as country,
        to_timestamp(invoicedate, 'MM/DD/YY HH24:MI') as order_timestamp
    from source

)

select * from cleaned
