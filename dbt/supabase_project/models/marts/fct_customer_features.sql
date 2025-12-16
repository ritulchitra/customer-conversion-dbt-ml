with customer_orders as (

    select
        customer_id,
        total_orders,
        total_spend,
        avg_order_value,
        last_order_timestamp
    from {{ ref('int_customer_orders') }}

),

features as (

    select
        customer_id,

        -- Frequency
        total_orders,

        -- Monetary
        total_spend,
        avg_order_value,

        -- Recency (days since last purchase)
        date_part(
            'day',
            current_timestamp - last_order_timestamp
        ) as recency_days

    from customer_orders

)

select * from features
