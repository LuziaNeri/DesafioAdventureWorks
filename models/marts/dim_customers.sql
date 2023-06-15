with stg_customer as (
    select 
        id_cliente
        , id_pessoa
        , id_loja
    from {{ref('stg_customer')}}
)

, stg_person as (
    select
        id_negocio
        , nome_pessoa
    from {{ref('stg_person')}}
)

, stg_store as (
    select
        id_negocio_loja
        , nome_loja
    from {{ref('stg_store')}}
)

, transformacao as (
    select
    row_number() over (order by stg_customer.id_cliente) as customer_sk --surrogate key    
    , stg_customer.id_cliente
    , stg_person.id_negocio
    , stg_person.nome_pessoa
    , stg_store.id_negocio_loja
    , stg_store.nome_loja
    from stg_customer
    inner join stg_person on stg_customer.id_pessoa = stg_person.id_negocio
    inner join stg_store on stg_customer.id_loja = stg_store.id_negocio_loja
)
select *
from transformacao