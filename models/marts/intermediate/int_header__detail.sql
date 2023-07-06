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
            , coalesce(id_cartao_credito, 0) as id_cartao_credito -- substitui os valores null por 0 nos casos em que a coluna não tenha o valor.
            , salesorderheader.id_territorio
            , salesorderheader.id_endereco_cobranca
            , salesorderheader.id_endereco_envio
            , salesorderheader.id_metodo_envio            
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
            , case
                when status = 1 then 'Em processo'
                when status = 2 then 'Aprovado'
                when status =3 then 'Em espera'
                when status = 4 then 'Rejeitado'
                when status = 5 then 'Enviado'
                when status = 6 then 'Cancelado'
                else 'Desconhecido'
                end as status_pedido
             , (preco_unidade * quantidade) as total_bruto
             , (preco_unidade * quantidade * (1- desconto)) as total_liquido
             , count (imposto) over (partition by id_pedido) as qtde_imposto_por_id -- A função count() retorna a contagem e over (partition by id_pedido) especifica a partição das linhas com base na coluna id_pedido.
             , count (frete) over (partition by id_pedido) as qtde_frete_por_id
        from joined
    )

select *
from transformacoes