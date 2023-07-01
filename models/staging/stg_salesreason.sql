with 
    source_salesreason as (
        select
            cast(salesreasonid as int) as id_motivo_pedido
            , cast(name as string) as motivo
            , cast(reasontype as string) as tipo_motivo_pedido
        from {{ source('erp', 'salesreason') }}
    )

select *
from source_salesreason