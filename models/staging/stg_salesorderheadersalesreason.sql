with 
    source_salesorderheadersalesreason as (
        select
            cast(salesorderid as int) as id_pedido
            , cast(salesreasonid as int) as id_motivo_pedido        
        from {{ source('erp', 'salesorderheadersalesreason') }}
    )

select *
from source_salesorderheadersalesreason