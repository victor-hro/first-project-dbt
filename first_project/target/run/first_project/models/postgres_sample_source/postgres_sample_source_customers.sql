
  create view "erp_oltp"."public"."postgres_sample_source_customers__dbt_tmp" as (
    with source_customers as (
  select * from "erp_oltp"."public"."clientes"
),

final as (
  select * from source_customers
)

select * from final
  );