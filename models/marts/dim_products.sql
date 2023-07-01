with 
    stg_product as (
        select *
        from {{ref('stg_product')}}
    )

    , stg_productcategory as (
        select *
        from {{ref('stg_productcategory')}}
    )

    , stg_productsubcategory as (
        select *
        from {{ref('stg_productsubcategory')}}
    )

    , join_tabela as (
        select
            stg_product.id_produto
            , stg_productcategory.id_categoria_produto
            , stg_productsubcategory.id_sub_categoria_produto
            , stg_product.nome_produto
            , stg_productcategory.nome_categoria_produto
            , stg_productsubcategory.name_subcategoria_produto
        from stg_productsubcategory
        left join stg_productcategory on stg_productsubcategory.id_categoria_produto = stg_productcategory.id_categoria_produto
        left join stg_product on stg_productsubcategory.id_sub_categoria_produto = stg_product.id_sub_categoria_produto
        )

    , transformacao as (
        select 
            row_number() over (order by id_produto) as sk_produto -- -- chave substituta auto-incremental
            , *            
        from join_tabela
    )

select *
from transformacao