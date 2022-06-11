with source_customers as (
  select * from "erp_oltp"."public"."clientes"
),

final as (
  select * from source_customers
)

select * from final