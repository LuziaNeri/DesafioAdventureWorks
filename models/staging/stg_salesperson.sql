with source_salesperson as (
    select
        cast(businessentityid as int) as id_negocio
        , cast(territoryid as string) as id_territorio
        , cast(salesquota as int) as cota_vendas
        , cast(bonus as numeric) as bonus
        , cast(commissionpct as numeric) as perc_comissao
        , cast(salesytd as numeric) as vendas_acumuladas_ano
        , cast(saleslastyear as numeric) as vendas_ano_anterior
        , cast(rowguid as string) as rowguid
        , cast(modifieddate as date) as data_modificada
    from {{ source('erp', 'salesperson') }}
)
select *
from source_salesperson