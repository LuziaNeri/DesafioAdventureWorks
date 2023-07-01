with 
    source_countryregion as (
        select
            cast (countryregioncode as string) as codigo_pais
            , cast (name as string) nome_pais   
        from {{ source('erp', 'countryregion') }}
    )

select *
from source_countryregion