with 
    stg_creditcard as (
        select *
        from {{ref('stg_creditcard')}}
    )

    , stg_personcreditcard as (
        select *
        from {{ref('stg_personcreditcard')}}
    )
   
    , joinded as (
        select
            stg_personcreditcard.id_negocio
            , stg_creditcard.id_cartao_credito        
            , stg_creditcard.tipo_cartao
        from stg_creditcard 
        left join stg_personcreditcard on stg_creditcard.id_cartao_credito  = stg_personcreditcard.id_cartao_credito
    )

    , transformacao as (
        select 
            row_number() over (order by id_cartao_credito) as sk_cartao_credito -- surrogate key
            , *
        from joinded
    )
    
select *
from transformacao