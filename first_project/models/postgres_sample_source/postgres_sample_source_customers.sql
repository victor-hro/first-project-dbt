with source_customers as (
  select * from {{ source('postgres_sample_source','clientes')}}
),

final as (
  select * from source_customers
)

select * from final
