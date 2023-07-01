with 
    source_product as (
        select
            cast(productid as int) as id_produto
            , cast(name as string) as nome_produto
            , cast(productnumber as string) as numero_produto
            , cast(makeflag as string) as makeflag
            , cast(finishedgoodsflag as string) as finishedgoodsflag
            , cast(color as string) as cor
            , cast(safetystocklevel as int) as estoque_seguranca
            , cast(reorderpoint as int) as ponto_reabastecimento
            , cast(standardcost as numeric) as custo_padrao
            , cast(listprice as numeric) as preco_tabela
            , cast(size as string) as tamanho
            , cast(sizeunitmeasurecode as string) as unidade_medida_tamanho
            , cast(weightunitmeasurecode as string) as unidade_medida_peso
            , cast(weight as numeric) as peso
            , cast(daystomanufacture as int) as dias_fabricacao
            , cast(productline as string) as linha_produto
            , cast(class as string) as classe
            , cast(style as string) as estilo
            , cast(productsubcategoryid as int) as id_sub_categoria_produto
            , cast(productmodelid as int) as id_modelo_produto
            , cast(sellstartdate as datetime) as data_inicio_venda
            , cast(sellenddate as datetime) as data_final_venda
            , cast(discontinueddate as string) as data_descotinuado
        from {{ source('erp', 'product') }}
    )

select *
from source_product