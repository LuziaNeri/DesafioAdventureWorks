with 
    source_personcreditcard as (
        select
            cast(businessentityid as int) as id_negocio
            , cast(creditcardid as numeric) as id_cartao_credito  
        from {{ source('erp', 'personcreditcard') }}
    )

select *
from source_personcreditcard