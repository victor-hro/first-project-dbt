
  create view "erp_oltp"."public"."stg_orders__dbt_tmp" as (
    with orders as (
  select
    numero_pedidos as order_id,
    codigo_cliente as customer_id,
    data_pedido as order_date
  from erp_oltp.public.pedidos
)

select * from orders
  );