with 
    source_adress as (
        select
            cast (addressid as int) as id_endereco
            , cast(addressline1 as string) as endereco_1
            , cast(addressline2 as string) as endereco_2
            , cast(city as string) as nome_cidade
            , cast(stateprovinceid as int) as id_estado
            , cast(postalcode as string) as cep
            , cast(spatiallocation as string) as localizacao_espacial
        from {{ source('erp', 'address') }}
    )

select *
from source_adress