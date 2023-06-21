with
    countryregion as (
        select
            codigo_pais
            , nome_pais
        from {{ ref('stg_countryregion') }}
    )

    , salesterritory as (
        select
            id_territorio 
            , nome_territorio
            , codigo_pais
            , continente
            , total_vendas_atualmente
            , vendas_ano_anterior
            , custos_acumulados_ano
            , custos_ano_anterior
        from {{ ref('stg_salesterritory') }}
    )

    /* Fazendo o fan-out da tabela de countryregion com salesterritory . */
    , joined as (
        select
            countryregion.codigo_pais
            , countryregion.nome_pais
            , salesterritory.id_territorio
            , salesterritory.continente
            , salesterritory.total_vendas_atualmente
            , salesterritory.vendas_ano_anterior
            , salesterritory.custos_acumulados_ano
            , salesterritory.custos_ano_anterior
        from salesterritory
        inner join countryregion on salesterritory.codigo_pais = countryregion.codigo_pais
    )

select *
from joined