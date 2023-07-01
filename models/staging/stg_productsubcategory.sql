with 
    source_productsubcategory as (
        select
            cast (productsubcategoryid	 as int) as id_sub_categoria_produto
            , cast (productcategoryid as int) as id_categoria_produto
            , cast (name as string) as name_subcategoria_produto
        from {{ source('erp', 'productsubcategory') }}
    )

select *
from source_productsubcategory