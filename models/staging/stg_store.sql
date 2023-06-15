with source_store as (
    select
        cast(businessentityid as int) as id_negocio_loja
        , cast(name as string) as nome_loja
        , cast(salespersonid as int) as id_pessoa
        , cast(demographics as string) as demografia
        , cast(rowguid as string) as rowguid
        , cast(modifieddate as date) as data_modificada    
    from {{ source('erp', 'store') }}
)
select *
from source_store