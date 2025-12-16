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

        -- Recency (relative to dataset end)
        date_part(
            'day',
            max(last_order_timestamp) over () - last_order_timestamp
        ) as recency_days,

        -- Target label
        case
            when date_part(
                'day',
                max(last_order_timestamp) over () - last_order_timestamp
            ) <= 30 then 1
            else 0
        end as converted

    from customer_orders

)

select * from features
