with 
    source_person as (
        select
            cast(businessentityid as int) as id_negocio
            , cast(persontype as int) as tipo_pessoa
            , cast(namestyle as string) as estilo_nome
            , cast(title as string) as titulo
            , cast((firstname || ' ' || lastname) as string) as nome_pessoa
            , cast(suffix as string) as sufixo
            , cast(emailpromotion as int) as promocao_por_email
            , cast(additionalcontactinfo as string) as info_adicional           
        from {{ source('erp', 'person') }}
    )

select *
from source_person