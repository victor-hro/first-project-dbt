

  create  table "erp_oltp"."public"."customer2__dbt_tmp"
  as (
    

with customers as (
   select * from "erp_oltp"."public"."stg_customers"
),
orders as (
  select
    numero_pedidos as order_id,
    codigo_cliente as customer_id,
    data_pedido as order_date
    from erp_oltp.public.pedidos
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
    customers.first_name,
    customers.last_name,
    customer_orders.first_order_date,
    customer_orders.most_recent_order_date,
    coalesce(customer_orders.number_of_orders, 0) as number_of_orders
from customers
  left join customer_orders using (customer_id)
)
select * from final
  );