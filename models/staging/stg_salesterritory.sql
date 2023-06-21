with source_salesterritory as (
    select
        cast(territoryid as int) as id_territorio
        , cast(name as string) as nome_territorio
        , cast(countryregioncode as string) as codigo_pais
        , cast('group' as string) as continente
        , cast(salesytd as numeric) as total_vendas_atualmente
        , cast(saleslastyear as numeric) as vendas_ano_anterior
        , cast(costytd as numeric) as custos_acumulados_ano
        , cast(costlastyear as numeric) as custos_ano_anterior
        , cast(modifieddate as date) as data_modificada    
    from {{ source('erp', 'salesterritory') }}
)
select *
from source_salesterritory