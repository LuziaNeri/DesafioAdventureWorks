with source_personcreditcard as (
    select
        cast(businessentityid as int) as id_negocio
        , cast(creditcardid as numeric) as id_cartao_credito
        , cast(modifieddate as date) as data_modificada    
    from {{ source('erp', 'personcreditcard') }}
)
select *
from source_personcreditcard