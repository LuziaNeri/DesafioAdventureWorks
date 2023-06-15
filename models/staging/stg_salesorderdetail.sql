with source_salesorderdetail as (
    select
        cast(salesorderid as int) as id_pedido
        , cast(salesorderdetailid as int) id_pedido_item
        , cast(carriertrackingnumber as string) as numero_rastreamento
        , cast(orderqty as int) as quantidade
        , cast(productid as int) as id_produto
        , cast(specialofferid as int) as oferta_especial
        , cast(unitprice as numeric) as preco_unidade
        , cast(unitpricediscount as numeric) as desconto
        , cast(rowguid as string) as rowguid
        , cast(modifieddate as date) as data_modificada
    from {{ source('erp', 'salesorderdetail') }}
)
select *
from source_salesorderdetail