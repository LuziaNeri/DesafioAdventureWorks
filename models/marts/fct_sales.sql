with 
    customers as (
        select *       
        from {{ref('dim_customers')}} 
    )
    
    , creditcards as (
        select *        
        from {{ref('dim_creditcards')}}
    )
    
    , locations as (
        select *        
        from {{ref('dim_locations')}}
    )
    
    , reasons as (
        select *        
        from {{ref('dim_reasons')}} 
    )
    
    , products as (
        select *       
        from {{ref('dim_products')}}
    )
    
    , int_header__detail as (
        select *        
        from {{ref('int_header__detail')}}
    )
    
    , joined as (
        select
            reasons.id_pedido
            , int_header__detail.id_pedido_item
            , products.id_produto
            , products.sk_produto
            , products.id_categoria_produto
            , products.id_sub_categoria_produto   
            , customers.sk_cliente
            , creditcards.id_cartao_credito
            , creditcards.sk_cartao_credito
            , locations.sk_locations
            , int_header__detail.id_territorio
            , int_header__detail.id_endereco_cobranca
            , int_header__detail.id_metodo_envio
            , int_header__detail.id_taxa_cambio
            , int_header__detail.data_pedido
            , int_header__detail.data_vencimento
            , int_header__detail.data_envio    
            , customers.nome_pessoa   
            , creditcards.tipo_cartao      
            , locations.nome_cidade
            , locations.nome_estado
            , locations.nome_pais        
            , reasons.motivo_aggregated   
            , products.nome_produto
            , products.nome_categoria_produto			
            , products.name_subcategoria_produto
            , int_header__detail.status --Status atual do pedido. 1 = Em processo; 2 = Aprovado; 3 = Em espera; 4 = Rejeitado; 5 = Enviado; 6 = Cancelado
            , int_header__detail.subtotal
            , int_header__detail.imposto
            , int_header__detail.frete
            , int_header__detail.total_devido        
            , int_header__detail.quantidade
            , int_header__detail.oferta_especial
            , int_header__detail.preco_unidade
            , int_header__detail.desconto         
            , int_header__detail.qtde_imposto_por_id
            , int_header__detail.qtde_frete_por_id
        from int_header__detail
        left join customers on int_header__detail.id_cliente = customers.id_cliente
        left join creditcards on int_header__detail.id_cartao_credito = creditcards.id_cartao_credito
        left join locations on int_header__detail.id_endereco_cobranca = locations.id_endereco
        left join reasons on int_header__detail.id_pedido = reasons.id_pedido
        left join products on int_header__detail.id_produto = products.id_produto
    ) 
    
    , transformacoes as (
            select
                {{ dbt_utils.surrogate_key(['id_pedido_item', 'sk_produto']) }} as sk_venda
                , *
                , (preco_unidade * quantidade) as total_bruto
                , (preco_unidade * quantidade * (1- desconto)) as total_liquido
                , (imposto/qtde_imposto_por_id) as imposto_unico
                , (frete/qtde_frete_por_id) as frete_unico            
            from joined
    )

select *
from transformacoes