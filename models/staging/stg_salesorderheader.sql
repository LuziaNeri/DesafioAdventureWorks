with source_salesorderheader as (
    select
        cast(salesorderid as int) as id_pedido
        , cast(revisionnumber as int) as numero_revisao
        , cast(orderdate as date) as data_pedido
        , cast(duedate as date) as data_vencimneto
        , cast(shipdate as date) as data_envio
        , cast(status as int) as status
        , cast(onlineorderflag as string) as onlineorderflag
        , cast(purchaseordernumber as string) as numero_ordem_pedido
        , cast(accountnumber as string) as numero_conta
        , cast(customerid as int) as id_cliente
        , cast(salespersonid as int) as id_pessoa
        , cast(territoryid as int) as id_territorio
        , cast(billtoaddressid as int) as id_endereco_cobranca
        , cast(shiptoaddressid as int) as id_endereco_envio
        , cast(shipmethodid as int) as id_metodo_envio
        , cast(creditcardid as int) as id_cartao_credito
        , cast(creditcardapprovalcode as string) as codigo_aprovacao 
        , cast(currencyrateid as int) as id_taxa_cambio
        , cast(subtotal as numeric) as subtotal
        , cast(taxamt as numeric) as imposto
        , cast(freight as numeric) as frete
        , cast(totaldue as numeric) as total_devido
        , cast(comment as string) as cmentario
        , cast(rowguid as string) as rowguid
        , cast(modifieddate as date) as data_modificada   
    from {{ source('erp', 'salesorderheader') }}
)
select *
from source_salesorderheader