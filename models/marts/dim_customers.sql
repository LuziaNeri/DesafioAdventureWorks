with stg_customer as (
    select *
    from {{ref('stg_customer')}}
)

, stg_person as (
    select *
    from {{ref('stg_person')}}
)

, join_tabelas as(
    select
        stg_person.id_negocio
        , stg_customer.id_cliente
        , stg_customer.id_pessoa
        , stg_customer.id_territorio
        , stg_person.nome_pessoa
    from stg_person
    inner join stg_customer on stg_person.id_negocio = stg_customer.id_cliente
)

, transformacao as(
    select
        row_number() over (order by id_cliente) as customer_sk
        , *  
    from join_tabelas
)

select *
from join_tabelas