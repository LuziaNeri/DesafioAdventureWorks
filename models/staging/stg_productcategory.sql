with 
    source_productcategory as (
        select
            cast (productcategoryid as int) as id_categoria_produto
            , cast (name as string) as nome_categoria_produto
        from {{ source('erp', 'productcategory') }}
    )

select *
from source_productcategory