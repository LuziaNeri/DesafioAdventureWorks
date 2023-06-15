with source_adress as (
    select
     cast (addressid as int) as id_endereco
        , cast(addressline1 as string) as endereco_1
        , cast(addressline2 as string) as endereco_2
        , cast(city as string) as cidade
        , cast(stateprovinceid as string) as estado_provincia
        , cast(postalcode as string) as cep
        , cast(spatiallocation as string) as localizacao_espacial
        , cast(rowguid as string) as rowguid
        , cast(modifieddate as date) as data_modificada 
    from {{ source('erp', 'address') }}
)
select *
from source_adress