{{
    config(
        severity = "error"
    )
}}

with
    total_vendas as (
        select sum (total_bruto) as total_vendido
        from {{ref('fct_order_details')}}
        where data_pedido between '2011-05-31' and '2014-06-30'
    )

select total_vendido
from total_vendas
where total_vendido not between 110373889.30 and 110373889.32