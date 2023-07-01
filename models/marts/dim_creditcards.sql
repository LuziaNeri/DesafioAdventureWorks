with stg_creditcard as (
    select *
    from {{ref('stg_creditcard')}}
)

, transformacao as (
    select 
        row_number() over (order by stg_creditcard.id_cartao_credito) as sk_cartao_credito -- surrogate key
        , *
    from stg_creditcard
)
   


select *
from transformacao