with
    salesorderheader as (
        select *
        from {{ ref('stg_salesorderheader') }}
    )

    , salesorderdetail as (
        select *        
        from {{ ref('stg_salesorderdetail') }}
    )

     , joined as (
        select
            salesorderheader.id_pedido
            , salesorderdetail.id_pedido_item
            , salesorderdetail.id_produto
            , salesorderheader.id_cliente
            , salesorderheader.id_pessoa
            , salesorderheader.id_cartao_credito
            , salesorderheader.id_territorio
            , salesorderheader.id_endereco_cobranca
            , salesorderheader.id_endereco_envio
            , salesorderheader.id_metodo_envio
            , salesorderheader.id_taxa_cambio
            , salesorderheader.data_pedido
            , salesorderheader.data_vencimento
            , salesorderheader.data_envio
            , salesorderheader.status
            , salesorderheader.onlineorderflag            
            , salesorderheader.numero_conta 
            , salesorderheader.subtotal
            , salesorderheader.imposto
            , salesorderheader.frete
            , salesorderheader.total_devido            
            , salesorderdetail.quantidade
            , salesorderdetail.oferta_especial
            , salesorderdetail.preco_unidade
            , salesorderdetail.desconto
        from salesorderheader
        inner join salesorderdetail on salesorderheader.id_pedido = salesorderdetail.id_pedido
    )

    , transformacoes as (
        select
            row_number() over (order by id_pedido) as sk_pedido -- surrogate key
             , *
             , (preco_unidade * quantidade) as total_bruto
             , (preco_unidade * quantidade * (1- desconto)) as total_liquido
             , count (imposto) over (partition by id_pedido) as qtde_imposto_por_id
             , count (frete) over (partition by id_pedido) as qtde_frete_por_id
        from joined
    )

select *
from transformacoes