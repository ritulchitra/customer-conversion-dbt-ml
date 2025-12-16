select
    customer_id,
    count(distinct order_id) as total_orders,
    sum(quantity * unit_price) as total_spend,
    avg(quantity * unit_price) as avg_order_value,
    max(order_timestamp) as last_order_timestamp
from {{ ref('stg_orders') }}
where customer_id is not null
group by customer_id
