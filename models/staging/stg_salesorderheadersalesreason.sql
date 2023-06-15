with source_salesorderheadersalesreason as (
    select
        cast(salesorderid as int) as id_pedido
        , cast(salesreasonid as int) as id_pedido_item
        , cast(modifieddate as date) as data_modificada 
    from {{ source('erp', 'salesorderheadersalesreason') }}
)
select *
from source_salesorderheadersalesreason