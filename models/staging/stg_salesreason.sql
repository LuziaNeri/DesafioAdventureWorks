with source_salesreason as (
    select
        cast(salesreasonid as int) as id_razao_pedido
        , cast(name as string) as nome_razao_pedido
        , cast(reasontype as string) as tipo_razao_pedido
        , cast(modifieddate as date) as data_modificada
    from {{ source('erp', 'salesreason') }}
)
select *
from source_salesreason