with source_salesreason as (
    select
        cast(salesreasonid as int) as id_razao_pedido
        , cast(territoryid as int) as 
        , cast(reasontype as string) as tipo_razao_pedido
        , cast(modifieddate as date) as data_modificada
    from {{ source('erp', 'salesreason') }}
)
select *
from source_salesreason