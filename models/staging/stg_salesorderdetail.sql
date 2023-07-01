with 
    source_salesorderdetail as (
        select
            cast(salesorderid as int) as id_pedido
            , cast(salesorderdetailid as int) id_pedido_item
            , cast(carriertrackingnumber as string) as numero_rastreamento
            , cast(orderqty as int) as quantidade
            , cast(productid as int) as id_produto
            , cast(specialofferid as int) as oferta_especial
            , cast(unitprice as float64) as preco_unidade
            , unitpricediscount as desconto            
        from {{ source('erp', 'salesorderdetail') }}
    )

select *
from source_salesorderdetail