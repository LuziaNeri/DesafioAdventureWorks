with 
    stg_salesorderheadersalesreason as (
        select *
        from {{ref('stg_salesorderheadersalesreason')}}
    )
    
    , stg_salesreason as (
        select *
        from {{ref('stg_salesreason')}}
    )
    
    , join_tabela as (
        select 
            stg_salesorderheadersalesreason.id_pedido
            , stg_salesreason.motivo
        from stg_salesorderheadersalesreason
        left join stg_salesreason on stg_salesorderheadersalesreason.id_motivo_pedido = stg_salesreason.id_motivo_pedido
    )
    
    , transformacao as (
        select
            id_pedido
            -- função usada para agregar em uma linha quaisquer motivos múltiplos atribuídos a um único id_pedido
            , string_agg(motivo, ', ') as motivo_aggregated
        from join_tabela
        group by id_pedido
    )

select *
from transformacao