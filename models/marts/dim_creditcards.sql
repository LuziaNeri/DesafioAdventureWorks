with stg_salesorderheader as (
    select 
        distinct(id_cartao_credito)
    from {{ref('stg_salesorderheader')}}
    where id_cartao_credito is not null
)

, stg_creditcard as (
    select *
    from {{ref('stg_creditcard')}}
)

, transformacao as (
    select 
        row_number() over (order by stg_salesorderheader.id_cartao_credito) as creditcard_sk -- surrogate key	
        , stg_salesorderheader.id_cartao_credito
        , stg_creditcard.tipo_cartao
    from stg_salesorderheader 
    left join stg_creditcard on stg_salesorderheader.id_cartao_credito = stg_creditcard.id_cartao_credito
)

select *
from transformacao