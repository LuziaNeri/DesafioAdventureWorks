with source_person as (
    select
        cast(businessentityid as int) as id_negocio
        , cast(persontype as int) as tipo_pessoa
        , cast(namestyle as string) as estilo_nome
        , cast(title as string) as titulo
        , cast((firstname || ' ' || middlename || ' ' || lastname) as string) as nome_pessoa
        , cast(suffix as string) as sufixo
        , cast(emailpromotion as int) as is_email_promocao
        , cast(additionalcontactinfo as string) as info_adicional
        , cast(demographics as string) as demografia
        , cast(rowguid as string) as rowguid
        , cast(modifieddate as date) as data_modificada    
    from {{ source('erp', 'person') }}
)
select *
from source_person