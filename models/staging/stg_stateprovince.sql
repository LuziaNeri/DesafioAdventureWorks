with source_stateprovince as (
    select
        cast(stateprovinceid as int) as id_estado
        , cast(stateprovincecode as string) as codigo_estado
        , cast(countryregioncode as string) as codigo_pais
        , cast(isonlystateprovinceflag as string) as is_only_state_province
        , cast(name as string) as nome_estado
        , cast(territoryid as int) as id_territorio
        , cast(rowguid as string) as rowguid
        , cast(modifieddate as date) as data_modificada   
    from {{ source('erp', 'stateprovince') }}
)
select *
from source_stateprovince