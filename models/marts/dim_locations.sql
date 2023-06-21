with stg_salesorderheader as (
    select 
        distinct(id_endereco_envio)
    from {{ref('stg_salesorderheader')}}
)

, stg_address as (
    select *
    from {{ref('stg_address')}}
)

, stg_stateprovince as (
    select *
    from {{ref('stg_stateprovince')}}
)

, int_countryregion__salesterritory as (
    select *
    from {{ref('int_countryregion__salesterritory')}}
)

, transformacao as (
    select
        row_number() over (order by stg_salesorderheader.id_endereco_envio) as shiptoaddress_sk -- auto-incremental surrogate key
        , stg_salesorderheader.id_endereco_envio
        , stg_address.cidade
        , stg_stateprovince.nome_estado
        , int_countryregion__salesterritory.nome_pais
    from stg_salesorderheader
    left join stg_address on stg_salesorderheader.id_endereco_envio = stg_adress.id_endereco
    left join stg_stateprovince on stg_address.id_endereco = stg_stateprovince.id_estado_provincia
    left join int_countryregion__salesterritory on stg_stateprovince.codigo_pais = int_countryregion__salesterritory.codigo_pais 
)

select *
from transformacao