with
    salesorderheader as (
        select
            id_pedido
            , numero_revisao
            , data_pedido
            , data_vencimento
            , data_envio
            , status
            , onlineorderflag
            , numero_ordem_pedido
            , numero_conta
            , id_cliente
            , id_pessoa
            , id_territorio
            , id_endereco_cobranca
            , id_endereco_envio
            , id_metodo_envio
            , id_cartao_credito
            , codigo_aprovacao 
            , id_taxa_cambio
            , subtotal
            , imposto
            , frete
            , total_devido
        from {{ ref('stg_salesorderheader') }}
    )

    , salesorderdetail as (
        select
            id_pedido 
            , id_pedido_item
            , numero_rastreamento
            , quantidade
            , id_produto
            , oferta_especial
            , preco_unidade
            , desconto
        from {{ ref('stg_salesorderdetail') }}
    )

    /* Fazendo o fan-out da tabela de salesorderheader com salesorderdetail. */
    , joined as (
        select
            salesorderheader.id_pedido
            , salesorderheader.numero_revisao
            , salesorderheader.data_pedido
            , salesorderheader.data_vencimento
            , salesorderheader.data_envio
            , salesorderheader.status
            , salesorderheader.onlineorderflag
            , salesorderheader.numero_ordem_pedido
            , salesorderheader.numero_conta
            , salesorderheader.id_cliente
            , salesorderheader.id_pessoa
            , salesorderheader.id_territorio
            , salesorderheader.id_endereco_cobranca
            , salesorderheader.id_endereco_envio
            , salesorderheader.id_metodo_envio
            , salesorderheader.id_cartao_credito
            , salesorderheader.codigo_aprovacao 
            , salesorderheader.id_taxa_cambio
            , salesorderheader.subtotal
            , salesorderheader.imposto
            , salesorderheader.frete
            , salesorderheader.total_devido
            , salesorderdetail.id_pedido_item
            , salesorderdetail.numero_rastreamento
            , salesorderdetail.quantidade
            , salesorderdetail.id_produto
            , salesorderdetail.oferta_especial
            , salesorderdetail.preco_unidade
            , salesorderdetail.desconto
        from salesorderheader
        left join salesorderdetail on salesorderheader.id_pedido = salesorderdetail.id_pedido
    )

select *
from joined