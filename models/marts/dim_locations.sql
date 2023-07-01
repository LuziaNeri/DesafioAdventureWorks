with 
    stg_address as (
        select *
    from {{ref('stg_address')}}
    )

, stg_countryregion as (
    select *
    from {{ref('stg_countryregion')}}
)

, stg_stateprovince as (
    select *
    from {{ref('stg_stateprovince')}}
)

, join_locations as (
    select
        stg_address.id_endereco
        , stg_stateprovince.id_estado
        , stg_stateprovince.id_territorio
        , stg_address.nome_cidade
        , stg_stateprovince.nome_estado
        , stg_countryregion.codigo_pais
        , stg_countryregion.nome_pais
    from stg_stateprovince   
    left join stg_countryregion on stg_stateprovince.codigo_pais  = stg_countryregion.codigo_pais
    left join stg_address on stg_stateprovince.id_estado = stg_address.id_estado
)

, transformacao as (
    select
        row_number() over (order by id_estado) as sk_locations -- auto-incremental surrogate key
        , *
        from join_locations
)

select *
from transformacao