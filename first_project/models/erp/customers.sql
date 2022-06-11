{% set client_not_filter = 63 %}
{% set fields_show_customers = ["first_name","last_name"] %}

with customers as (
   select * from {{ ref('stg_customers')}}
),
orders as (
   select * from {{ ref('stg_orders')}}
),
customer_orders as (
  select
    customer_id,
    min(order_date) as first_order_date,
    max(order_date) as most_recent_order_date,
    count(order_id) as number_of_orders
  from orders
  group by 1
),
final as (
  select
    customers.customer_id,
    {%- for field_show in fields_show_customers %}
    customers.{{field_show}},
    {%- endfor %}
    customer_orders.first_order_date,
    customer_orders.most_recent_order_date,
    coalesce(customer_orders.number_of_orders, 0) as number_of_orders,
    customers.state
from customers
  left join customer_orders using (customer_id)
  WHERE customers.customer_id != {{client_not_filter}}
)
select * from final
